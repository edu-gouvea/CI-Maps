:- consult(regras).

% -------------------------------------------------------------
%  consultar(+IdParada)
%  Ponto de entrada principal. Exibe rotas e, para cada linha
%  encontrada, mostra tipo, dias de operação, horários e
%  acessibilidade da parada de origem.
%
%  Exemplos:
%    ?- consultar(p019).
%    ?- consultar(p023).
%    ?- consultar(p013).
% -------------------------------------------------------------
consultar(IdOrigem) :-
    parada(IdOrigem, _, _, _, _), !,
    parada_info(IdOrigem, DescOrigem),
    recursos_parada(IdOrigem, Recursos),
    format("~n==============================================~n"),
    format(" GPS CI/UFPB~n"),
    format(" Origem : ~w~n", [DescOrigem]),
    format(" Destino: CI/UFPB (Campus I — Bancarios)~n"),
    exibir_acessibilidade_parada(Recursos),
    format("==============================================~n"),
    (
        buscar_e_exibir(IdOrigem)
    ;
        format("~n  [!] Nenhuma rota encontrada para essa parada.~n"),
        format("      Dica: use buscar('fragmento') para localizar paradas.~n~n")
    ), !.

consultar(IdOrigem) :-
    format("~n  [!] Parada '~w' nao encontrada na base de dados.~n", [IdOrigem]),
    format("      Use listar_paradas ou buscar('fragmento').~n~n").


% -------------------------------------------------------------
%  exibir_acessibilidade_parada(+Recursos)
%  Exibe linha de acessibilidade apenas se houver recursos.
% -------------------------------------------------------------
exibir_acessibilidade_parada([]) :- !.
exibir_acessibilidade_parada(Recursos) :-
    format(" Acessib.: ~w~n", [Recursos]).


% -------------------------------------------------------------
%  buscar(+Fragmento)
%  Busca paradas por fragmento de nome, rua ou bairro.
%
%  Exemplos:
%    ?- buscar('UFPB').
%    ?- buscar('Mangabeira').
%    ?- buscar('Tambau').
% -------------------------------------------------------------
buscar(Fragmento) :-
    buscar_paradas_por_fragmento(Fragmento, Ids),
    (
        Ids = []
    ->
        format("~n  [!] Nenhuma parada encontrada com '~w'.~n", [Fragmento]),
        format("      Use listar_paradas para ver todas as paradas.~n~n")
    ;
        length(Ids, Total),
        format("~n  ~w parada(s) encontrada(s) com '~w':~n~n", [Total, Fragmento]),
        forall(
            member(Id, Ids),
            (
                parada_info(Id, Desc),
                format("    [~w] ~w~n", [Id, Desc])
            )
        ),
        format("~n  Use: consultar(Id).~n~n")
    ).


% -------------------------------------------------------------
%  buscar_e_exibir(+IdOrigem)
%  Tenta rota direta; se não houver, tenta com baldeação.
% -------------------------------------------------------------
buscar_e_exibir(IdOrigem) :-
    (
        rota_direta(IdOrigem, _)
    ->
        format("~n  Rota(s) direta(s) encontrada(s):~n"),
        forall(
            rota_direta(IdOrigem, Linha),
            exibir_direta(Linha)
        )
    ;
        rota_com_baldeacao(IdOrigem, _, _, _)
    ->
        format("~n  Sem rota direta. Rota(s) com baldeacao encontrada(s):~n"),
        forall(
            rota_com_baldeacao(IdOrigem, L1, IdB, L2),
            exibir_baldeacao(L1, IdB, L2)
        )
    ).


% -------------------------------------------------------------
%  exibir_direta(+Linha)
% -------------------------------------------------------------
exibir_direta(Linha) :-
    nome_linha(Linha, Nome),
    info_linha(Linha, Tipo, Dias, Primeira, Ultima),
    format("~n  [DIRETA]~n"),
    format("  Linha      : ~w — ~w~n",   [Linha, Nome]),
    format("  Tipo       : ~w~n",         [Tipo]),
    format("  Opera      : ~w~n",         [Dias]),
    format("  Horarios   : ~w ate ~w~n",  [Primeira, Ultima]),
    format("  Embarque   : Na parada informada~n"),
    format("  Desembarque: CI/UFPB (Campus I — Bancarios)~n").


% -------------------------------------------------------------
%  exibir_baldeacao(+Linha1, +IdBaldeacao, +Linha2)
% -------------------------------------------------------------
exibir_baldeacao(Linha1, IdBaldeacao, Linha2) :-
    nome_linha(Linha1, Nome1),
    nome_linha(Linha2, Nome2),
    info_linha(Linha1, Tipo1, Dias1, Primeira1, Ultima1),
    info_linha(Linha2, Tipo2, Dias2, Primeira2, Ultima2),
    parada_info(IdBaldeacao, DescBaldeacao),
    recursos_parada(IdBaldeacao, RecursosBaldeacao),
    format("~n  [COM BALDEACAO]~n"),
    format("  1a Linha   : ~w — ~w~n",  [Linha1, Nome1]),
    format("  Tipo       : ~w~n",        [Tipo1]),
    format("  Opera      : ~w~n",        [Dias1]),
    format("  Horarios   : ~w ate ~w~n", [Primeira1, Ultima1]),
    format("  Baldeacao  : ~w~n",        [DescBaldeacao]),
    exibir_acessibilidade_baldeacao(RecursosBaldeacao),
    format("  2a Linha   : ~w — ~w~n",  [Linha2, Nome2]),
    format("  Tipo       : ~w~n",        [Tipo2]),
    format("  Opera      : ~w~n",        [Dias2]),
    format("  Horarios   : ~w ate ~w~n", [Primeira2, Ultima2]),
    format("  Desembarque: CI/UFPB (Campus I — Bancarios)~n").


% -------------------------------------------------------------
%  exibir_acessibilidade_baldeacao(+Recursos)
% -------------------------------------------------------------
exibir_acessibilidade_baldeacao([]) :- !.
exibir_acessibilidade_baldeacao(Recursos) :-
    format("  Acessib.   : ~w~n", [Recursos]).


% -------------------------------------------------------------
%  listar_paradas/0
% -------------------------------------------------------------
listar_paradas :-
    format("~n=== PARADAS CADASTRADAS ===~n"),
    format("Use o Id em: consultar(Id).~n~n"),
    forall(
        parada(Id, _, Referencia, Bairro, _),
        format("  [~w] ~w (~w)~n", [Id, Referencia, Bairro])
    ).