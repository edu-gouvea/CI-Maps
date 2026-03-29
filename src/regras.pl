% =============================================================
%  regras.pl — Regras de inferência do GPS CI/UFPB
%  Versão 2.1 — Inclui regras de enriquecimento de linha/parada
%
%  Compatível com dados.pl v2:
%    parada(Id, Rua, Referencia, Bairro, Sentido)
%    linha(Codigo, Nome)
%    passa_por(Linha, IdParada)
%    linha_vai_ao_ci(CodigoLinha)
%    ponto_de_baldeacao(IdParada, LinhaQueChega, LinhaQueSai)
%    horario_primeira_viagem(CodigoLinha, Sentido, Hora)
%    horario_ultima_viagem(CodigoLinha, Sentido, Hora)
%    opera_nos_dias(CodigoLinha, Dias)
%    tipo_linha(CodigoLinha, Tipo)
%    acessibilidade_parada(IdParada, TipoRecurso)
% =============================================================

:- consult(dados).


% -------------------------------------------------------------
%  VERIFICAÇÃO DE INTEGRIDADE — executada automaticamente
%  ao carregar o arquivo.
% -------------------------------------------------------------
:- format("~n[integridade] Verificando base de conhecimento...~n"),
   forall(
       linha_vai_ao_ci(L),
       (
           passa_por(L, _)
       ->
           format("[integridade] OK  — Linha ~w tem paradas cadastradas.~n", [L])
       ;
           format("[integridade] ERRO — Linha ~w vai ao CI mas nao tem paradas em passa_por!~n", [L])
       )
   ),
   format("[integridade] Verificacao concluida.~n~n").


% -------------------------------------------------------------
%  nome_linha(+CodigoLinha, -NomeDescritivo)
% -------------------------------------------------------------
nome_linha(Codigo, Nome) :-
    linha(Codigo, Nome).


% -------------------------------------------------------------
%  parada_info(+IdParada, -Descricao)
%  Formato: "Referencia (Bairro)"
% -------------------------------------------------------------
parada_info(Id, Descricao) :-
    parada(Id, _, Referencia, Bairro, _),
    atomic_list_concat([Referencia, ' (', Bairro, ')'], Descricao).


% -------------------------------------------------------------
%  recursos_parada(+IdParada, -ListaRecursos)
%  Retorna lista de recursos de acessibilidade da parada.
%  Lista vazia se nenhum recurso cadastrado.
% -------------------------------------------------------------
recursos_parada(Id, Recursos) :-
    findall(R, acessibilidade_parada(Id, R), Recursos).


% -------------------------------------------------------------
%  info_linha(+CodigoLinha, -Tipo, -Dias, -PrimeiraIda, -UltimaIda)
%  Agrega tipo, dias de operação e horários (sentido bairro_centro).
%  Usa 'N/D' quando o fato não está cadastrado.
% -------------------------------------------------------------
info_linha(Codigo, Tipo, Dias, Primeira, Ultima) :-
    ( tipo_linha(Codigo, Tipo)             -> true ; Tipo     = 'N/D' ),
    ( opera_nos_dias(Codigo, Dias)         -> true ; Dias     = 'N/D' ),
    ( horario_primeira_viagem(Codigo, bairro_centro, Primeira)
                                           -> true ; Primeira = 'N/D' ),
    ( horario_ultima_viagem(Codigo, bairro_centro, Ultima)
                                           -> true ; Ultima   = 'N/D' ).


% -------------------------------------------------------------
%  rota_direta(+IdParadaOrigem, -Linha)
% -------------------------------------------------------------
rota_direta(IdOrigem, Linha) :-
    passa_por(Linha, IdOrigem),
    linha_vai_ao_ci(Linha).


% -------------------------------------------------------------
%  rota_com_baldeacao(+IdParadaOrigem, -Linha1, -IdBaldeacao, -Linha2)
%
%  Verifica se existe uma baldeacao valida cadastrada para a origem.
%  Linha2 pode ou nao ir ao CI — a verificacao de destino fica a cargo
%  de existe_rota/1. Isso permite consultas como 203->520 via p002
%  (baldeacao valida mesmo que a 520 nao va ao CI diretamente).
%
%  Clausula 1: Linha1 nao vai ao CI (caso classico).
%  Clausula 2: Linha1 vai ao CI mas o passageiro troca de linha
%              no ponto de baldeacao (ex.: 517 via p013 -> 301).
% -------------------------------------------------------------
rota_com_baldeacao(IdOrigem, Linha1, IdBaldeacao, Linha2) :-
    passa_por(Linha1, IdOrigem),
    \+ linha_vai_ao_ci(Linha1),
    ponto_de_baldeacao(IdBaldeacao, Linha1, Linha2),
    passa_por(Linha1, IdBaldeacao).

rota_com_baldeacao(IdOrigem, Linha1, IdBaldeacao, Linha2) :-
    passa_por(Linha1, IdOrigem),
    linha_vai_ao_ci(Linha1),
    Linha1 \= Linha2,
    ponto_de_baldeacao(IdBaldeacao, Linha1, Linha2),
    passa_por(Linha1, IdBaldeacao),
    IdOrigem \= IdBaldeacao.


% -------------------------------------------------------------
%  existe_rota(+IdParadaOrigem)
%  Verdadeiro se existe rota direta ou via baldeacao que leve ao CI.
% -------------------------------------------------------------
existe_rota(IdOrigem) :-
    rota_direta(IdOrigem, _), !.
existe_rota(IdOrigem) :-
    rota_com_baldeacao(IdOrigem, _, _, Linha2),
    linha_vai_ao_ci(Linha2).


% -------------------------------------------------------------
%  buscar_paradas_por_bairro(+Bairro, -ListaDeIds)
% -------------------------------------------------------------
buscar_paradas_por_bairro(Bairro, Ids) :-
    findall(Id, parada(Id, _, _, Bairro, _), Todos),
    sort(Todos, Ids).


% -------------------------------------------------------------
%  buscar_paradas_por_fragmento(+Fragmento, -ListaDeIds)
% -------------------------------------------------------------
buscar_paradas_por_fragmento(Fragmento, Ids) :-
    findall(
        Id,
        (
            parada(Id, Rua, Referencia, Bairro, _),
            (
                sub_atom(Rua, _, _, _, Fragmento)
            ;   sub_atom(Referencia, _, _, _, Fragmento)
            ;   sub_atom(Bairro, _, _, _, Fragmento)
            )
        ),
        Todos
    ),
    sort(Todos, Ids).