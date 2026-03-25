% =============================================================
%  regras.pl — Regras de inferência do GPS CI/UFPB
%  Versão 2.0 — Atualizada para o modelo de dados v2
%
%  Compatível com dados.pl v2:
%    parada(Id, Rua, Referencia, Bairro, Sentido)
%    linha(Codigo, Nome)
%    passa_por(Linha, IdParada)
%    linha_vai_ao_ci(CodigoLinha)
%    ponto_de_baldeacao(IdParada, LinhaQueChega, LinhaQueSai)
% =============================================================

:- consult(dados).


% -------------------------------------------------------------
%  VERIFICAÇÃO DE INTEGRIDADE — executada automaticamente
%  ao carregar o arquivo.
%  Garante que toda linha marcada como linha_vai_ao_ci/1
%  possui ao menos uma parada cadastrada em passa_por/2.
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
%  Recupera o nome descritivo de uma linha a partir de linha/2.
%  Mantém a mesma interface usada pela interface.pl.
% -------------------------------------------------------------
nome_linha(Codigo, Nome) :-
    linha(Codigo, Nome).


% -------------------------------------------------------------
%  parada_info(+IdParada, -Descricao)
%  Gera uma descrição legível de uma parada a partir do seu Id.
%  Formato: "Referencia (Bairro)"
% -------------------------------------------------------------
parada_info(Id, Descricao) :-
    parada(Id, _, Referencia, Bairro, _),
    atomic_list_concat([Referencia, ' (', Bairro, ')'], Descricao).


% -------------------------------------------------------------
%  rota_direta(+IdParadaOrigem, -Linha)
%  Verdadeiro se existe uma linha direta de IdParadaOrigem
%  até o CI (linha marcada como linha_vai_ao_ci).
% -------------------------------------------------------------
rota_direta(IdOrigem, Linha) :-
    passa_por(Linha, IdOrigem),
    linha_vai_ao_ci(Linha).


% -------------------------------------------------------------
%  rota_com_baldeacao(+IdParadaOrigem, -Linha1, -IdBaldeacao, -Linha2)
%  Verdadeiro se existe:
%    IdOrigem --Linha1--> IdBaldeacao --Linha2--> CI
% -------------------------------------------------------------
rota_com_baldeacao(IdOrigem, Linha1, IdBaldeacao, Linha2) :-
    passa_por(Linha1, IdOrigem),
    \+ linha_vai_ao_ci(Linha1),
    ponto_de_baldeacao(IdBaldeacao, Linha1, Linha2),
    passa_por(Linha1, IdBaldeacao),
    linha_vai_ao_ci(Linha2).


% -------------------------------------------------------------
%  existe_rota(+IdParadaOrigem)
%  Verdadeiro se há qualquer rota (direta ou com baldeação)
%  partindo de IdParadaOrigem até o CI.
% -------------------------------------------------------------
existe_rota(IdOrigem) :-
    rota_direta(IdOrigem, _), !.
existe_rota(IdOrigem) :-
    rota_com_baldeacao(IdOrigem, _, _, _).


% -------------------------------------------------------------
%  buscar_paradas_por_bairro(+Bairro, -ListaDeIds)
%  Retorna todos os Ids de paradas do bairro informado.
% -------------------------------------------------------------
buscar_paradas_por_bairro(Bairro, Ids) :-
    findall(Id, parada(Id, _, _, Bairro, _), Todos),
    sort(Todos, Ids).


% -------------------------------------------------------------
%  buscar_paradas_por_fragmento(+Fragmento, -ListaDeIds)
%  Retorna todos os Ids de paradas cuja Referencia, Rua ou
%  Bairro contenha o Fragmento (busca parcial, sem nome exato).
%
%  Exemplo:
%    ?- buscar_paradas_por_fragmento('UFPB', Ids).
%    ?- buscar_paradas_por_fragmento('Mangabeira', Ids).
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