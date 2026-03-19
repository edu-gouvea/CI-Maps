% =============================================================
%  regras.pl — Regras de inferência do GPS CI/UFPB
%  Contém toda a lógica de busca de rotas
% =============================================================

:- consult(dados).


% -------------------------------------------------------------
%  VERIFICAÇÃO DE INTEGRIDADE — executada automaticamente
%  ao carregar o arquivo.
%  Garante que toda linha marcada como linha_vai_ao_ci/1
%  possui o Terminal Quadramares cadastrado em ponto_da_linha/2.
% -------------------------------------------------------------
:- format("~n[integridade] Verificando base de conhecimento...~n"),
   forall(
       linha_vai_ao_ci(L),
       (
           ponto_da_linha('Terminal Quadramares - LIQ (Mangabeira VII)', L)
       ->
           format("[integridade] OK  — Linha ~w tem o ponto do CI cadastrado.~n", [L])
       ;
           format("[integridade] ERRO — Linha ~w vai ao CI mas nao tem o ponto do CI em ponto_da_linha!~n", [L])
       )
   ),
   format("[integridade] Verificacao concluida.~n~n").


% -------------------------------------------------------------
%  rota_direta(+Origem, -Linha)
%  Verdadeiro se existe uma linha direta de Origem até o CI.
% -------------------------------------------------------------
rota_direta(Origem, Linha) :-
    ponto_da_linha(Origem, Linha),
    linha_vai_ao_ci(Linha).


% -------------------------------------------------------------
%  rota_com_baldeacao(+Origem, -Linha1, -PontoBaldeacao, -Linha2)
%  Verdadeiro se existe:
%    Origem --Linha1--> PontoBaldeacao --Linha2--> CI
% -------------------------------------------------------------
rota_com_baldeacao(Origem, Linha1, PontoBaldeacao, Linha2) :-
    ponto_da_linha(Origem, Linha1),
    \+ linha_vai_ao_ci(Linha1),
    ponto_de_baldeacao(PontoBaldeacao, Linha1, Linha2),
    ponto_da_linha(PontoBaldeacao, Linha1),
    linha_vai_ao_ci(Linha2).


% -------------------------------------------------------------
%  existe_rota(+Origem)
%  Verdadeiro se há qualquer rota (direta ou com baldeação)
%  partindo de Origem até o CI.
% -------------------------------------------------------------
existe_rota(Origem) :-
    rota_direta(Origem, _), !.
existe_rota(Origem) :-
    rota_com_baldeacao(Origem, _, _, _).


% -------------------------------------------------------------
%  buscar_pontos_aproximados(+Fragmento, -ListaDePontos)
%  Retorna todos os pontos cujo nome contenha o Fragmento
%  (busca parcial, sem necessidade do nome exato).
%
%  Exemplo:
%    ?- buscar_pontos_aproximados('Tambaú', Pontos).
%    ?- buscar_pontos_aproximados('Bancários', Pontos).
% -------------------------------------------------------------
buscar_pontos_aproximados(Fragmento, Pontos) :-
    findall(
        P,
        (ponto_da_linha(P, _), sub_atom(P, _, _, _, Fragmento)),
        Todos
    ),
    sort(Todos, Pontos).