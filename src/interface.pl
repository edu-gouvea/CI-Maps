% =============================================================
%  interface.pl — Interface amigável do GPS CI/UFPB
%  Exibe resultados formatados no terminal
% =============================================================

:- consult(regras).

% -------------------------------------------------------------
%  consultar(+Origem)
%  Predicado principal. Use este para fazer consultas.
%
%  Exemplos:
%    ?- consultar('Orla de Tambaú').
%    ?- consultar('Av. Dom Pedro II (Centro)').
%    ?- consultar('Bessa').
% -------------------------------------------------------------
consultar(Origem) :-
    format("~n==============================================~n"),
    format(" GPS CI/UFPB~n"),
    format(" Origem : ~w~n", [Origem]),
    format(" Destino: Terminal Quadramares - LIQ (CI/UFPB)~n"),
    format("==============================================~n"),
    (
        buscar_e_exibir(Origem)
    ;
        format("~n  [!] Nenhuma rota encontrada para esse ponto.~n"),
        format("      Use listar_pontos para ver os pontos cadastrados.~n~n")
    ), !.


% -------------------------------------------------------------
%  buscar_e_exibir(+Origem)
%  Tenta rota direta primeiro; se não houver, tenta baldeação.
% -------------------------------------------------------------
buscar_e_exibir(Origem) :-
    (
        rota_direta(Origem, _)
    ->
        format("~n  Rota(s) direta(s) encontrada(s):~n"),
        forall(
            rota_direta(Origem, Linha),
            exibir_direta(Linha)
        )
    ;
        rota_com_baldeacao(Origem, _, _, _)
    ->
        format("~n  Sem rota direta. Rota(s) com baldeacao encontrada(s):~n"),
        forall(
            rota_com_baldeacao(Origem, L1, PB, L2),
            exibir_baldeacao(L1, PB, L2)
        )
    ).


% -------------------------------------------------------------
%  Exibição formatada de rota direta
% -------------------------------------------------------------
exibir_direta(Linha) :-
    format("~n  [DIRETA]~n"),
    format("  Linha     : ~w~n", [Linha]),
    format("  Embarque  : No ponto informado~n"),
    format("  Desembarque: Terminal Quadramares - LIQ (CI/UFPB)~n").


% -------------------------------------------------------------
%  Exibição formatada de rota com baldeação
% -------------------------------------------------------------
exibir_baldeacao(Linha1, PontoBaldeacao, Linha2) :-
    format("~n  [COM BALDEACAO]~n"),
    format("  1a Linha   : ~w~n",  [Linha1]),
    format("  Baldeacao  : ~w~n",  [PontoBaldeacao]),
    format("  2a Linha   : ~w~n",  [Linha2]),
    format("  Desembarque: Terminal Quadramares - LIQ (CI/UFPB)~n").


% -------------------------------------------------------------
%  listar_pontos/0
%  Lista todos os pontos de ônibus cadastrados (sem duplicatas)
% -------------------------------------------------------------
listar_pontos :-
    format("~n=== PONTOS DE ONIBUS CADASTRADOS ===~n"),
    format("Use exatamente esses nomes em: consultar('Nome do Ponto').~n~n"),
    findall(P, ponto_da_linha(P, _), Todos),
    sort(Todos, Unicos),
    forall(member(P, Unicos), format("  ~w~n", [P])).