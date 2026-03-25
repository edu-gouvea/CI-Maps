% =============================================================
%  interface.pl — Interface amigável do GPS CI/UFPB
%  Versão 2.0 — Atualizada para o modelo de dados v2
% =============================================================

:- consult(regras).


% -------------------------------------------------------------
%  consultar(+IdParada)
%  Predicado principal — busca rota pelo ID da parada.
%
%  Exemplos:
%    ?- consultar(p019).   % Av. Epitacio Pessoa (Tambau)
%    ?- consultar(p013).   % HU / Girador UFPB
%    ?- consultar(p023).   % Terminal Bessa
% -------------------------------------------------------------
consultar(IdOrigem) :-
    parada_info(IdOrigem, Descricao),
    format("~n==============================================~n"),
    format(" GPS CI/UFPB~n"),
    format(" Origem : ~w~n", [Descricao]),
    format(" Destino: CI/UFPB (Campus I — Bancarios)~n"),
    format("==============================================~n"),
    (
        buscar_e_exibir(IdOrigem)
    ;
        format("~n  [!] Nenhuma rota encontrada para essa parada.~n"),
        format("      Dica: use buscar('fragmento') para localizar paradas.~n~n")
    ), !.

consultar(IdOrigem) :-
    \+ parada(IdOrigem, _, _, _, _),
    format("~n  [!] Parada '~w' nao encontrada na base de dados.~n", [IdOrigem]),
    format("      Use listar_paradas ou buscar('fragmento').~n~n").


% -------------------------------------------------------------
%  buscar(+Fragmento)
%  Busca paradas cujo nome, referência ou bairro contenha
%  o Fragmento digitado. Substitui o antigo consultar_aproximado.
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
        format("~n  Use: consultar(Id).  Ex: consultar(~w).~n~n", [Ids])
    ).


% -------------------------------------------------------------
%  buscar_e_exibir(+IdOrigem)
%  Tenta rota direta primeiro; se não houver, tenta baldeação.
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
    format("~n  [DIRETA]~n"),
    format("  Linha      : ~w~n", [Linha]),
    format("  Descricao  : ~w~n", [Nome]),
    format("  Embarque   : Na parada informada~n"),
    format("  Desembarque: CI/UFPB (Campus I — Bancarios)~n").


% -------------------------------------------------------------
%  exibir_baldeacao(+Linha1, +IdBaldeacao, +Linha2)
% -------------------------------------------------------------
exibir_baldeacao(Linha1, IdBaldeacao, Linha2) :-
    nome_linha(Linha1, Nome1),
    nome_linha(Linha2, Nome2),
    parada_info(IdBaldeacao, DescBaldeacao),
    format("~n  [COM BALDEACAO]~n"),
    format("  1a Linha   : ~w — ~w~n",  [Linha1, Nome1]),
    format("  Baldeacao  : ~w~n",        [DescBaldeacao]),
    format("  2a Linha   : ~w — ~w~n",  [Linha2, Nome2]),
    format("  Desembarque: CI/UFPB (Campus I — Bancarios)~n").


% -------------------------------------------------------------
%  listar_paradas/0
%  Lista todas as paradas cadastradas com seus IDs.
% -------------------------------------------------------------
listar_paradas :-
    format("~n=== PARADAS CADASTRADAS ===~n"),
    format("Use o Id em: consultar(Id).~n~n"),
    forall(
        parada(Id, _, Referencia, Bairro, _),
        format("  [~w] ~w (~w)~n", [Id, Referencia, Bairro])
    ).