% =============================================================
%  interface.pl — Interface amigável do GPS CI/UFPB
%  Exibe resultados formatados no terminal
% =============================================================

:- consult(regras).


% -------------------------------------------------------------
%  consultar(+Origem)
%  Predicado principal — busca rota pelo nome exato do ponto.
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
        format("      Dica: use consultar_aproximado('parte do nome')~n"),
        format("      para buscar pelo nome parcial do ponto.~n~n")
    ), !.


% -------------------------------------------------------------
%  consultar_aproximado(+Fragmento)
%  Busca pontos cujo nome contenha o Fragmento digitado.
%  Útil quando o usuário não lembra o nome exato do ponto.
%
%  Exemplos:
%    ?- consultar_aproximado('Tambaú').
%    ?- consultar_aproximado('Bancários').
%    ?- consultar_aproximado('Mangabeira').
% -------------------------------------------------------------
consultar_aproximado(Fragmento) :-
    buscar_pontos_aproximados(Fragmento, Pontos),
    (
        Pontos = []
    ->
        format("~n  [!] Nenhum ponto encontrado com '~w'.~n", [Fragmento]),
        format("      Use listar_pontos para ver todos os pontos.~n~n")
    ;
        length(Pontos, Total),
        format("~n  ~w ponto(s) encontrado(s) com '~w':~n~n", [Total, Fragmento]),
        forall(
            member(P, Pontos),
            format("    -> ~w~n", [P])
        ),
        format("~n  Use: consultar('Nome Exato do Ponto').~n~n")
    ).


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
%  exibir_direta(+Linha)
%  Exibe rota direta com nome descritivo da linha.
% -------------------------------------------------------------
exibir_direta(Linha) :-
    nome_linha(Linha, Nome),
    format("~n  [DIRETA]~n"),
    format("  Linha      : ~w~n", [Linha]),
    format("  Descricao  : ~w~n", [Nome]),
    format("  Embarque   : No ponto informado~n"),
    format("  Desembarque: Terminal Quadramares - LIQ (CI/UFPB)~n").


% -------------------------------------------------------------
%  exibir_baldeacao(+Linha1, +PontoBaldeacao, +Linha2)
%  Exibe rota com baldeação com nomes descritivos das linhas.
% -------------------------------------------------------------
exibir_baldeacao(Linha1, PontoBaldeacao, Linha2) :-
    nome_linha(Linha1, Nome1),
    nome_linha(Linha2, Nome2),
    format("~n  [COM BALDEACAO]~n"),
    format("  1a Linha   : ~w — ~w~n",  [Linha1, Nome1]),
    format("  Baldeacao  : ~w~n",        [PontoBaldeacao]),
    format("  2a Linha   : ~w — ~w~n",  [Linha2, Nome2]),
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