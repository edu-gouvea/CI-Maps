% =============================================================
%  GPS DE ÔNIBUS - DESTINO: CI/UFPB (Campus Mangabeira)
%  Projeto de Lógica de Programação - Centro de Informática UFPB
%
%  MODELAGEM:
%    - A origem é um PONTO DE ÔNIBUS (rua/avenida real de JP)
%    - O destino é sempre o CI/UFPB (Terminal Quadramares - LIQ)
%    - Suporte a rotas diretas e com 1 baldeação
%
%  USO NO TERMINAL:
%    ?- consultar('Av. Epitácio Pessoa (Tambaú)').
%    ?- consultar('Av. Dom Pedro II (Centro)').
%    ?- consultar('Bessa').
%    ?- listar_pontos.
% =============================================================


% -------------------------------------------------------------
%  FATO: ponto_da_linha(+PontoDeOnibus, +NumeroDaLinha)
%  Indica que um determinado ponto é servido por uma linha.
%  Os nomes dos pontos seguem a nomenclatura real do Moovit/Unitrans.
% -------------------------------------------------------------

% LINHA 203 — Mangabeira VII ↔ LIQ ↔ José Américo ↔ Rangel ↔ Terminal Varadouro
ponto_da_linha('Terminal Quadramares - LIQ (Mangabeira VII)', '203').
ponto_da_linha('Av. Hilton Souto Maior (Mangabeira VII)',     '203').
ponto_da_linha('Av. Vasco da Gama (Mangabeira)',              '203').
ponto_da_linha('Av. Josefa Taveira (Mangabeira)',             '203').
ponto_da_linha('Av. Benicio de Oliveira Lima (Mangabeira)',   '203').
ponto_da_linha('Rua José Ananias (José Américo)',             '203').
ponto_da_linha('Av. Campos Sales (Rangel)',                   '203').
ponto_da_linha('Av. Cruz das Armas (Rangel)',                 '203').
ponto_da_linha('Terminal de Integração Varadouro',            '203').
ponto_da_linha('Av. Sanhauá - Marco Zero (Centro)',           '203').

% LINHA 207 — Penha Via Seixas ↔ Mangabeira ↔ Rangel ↔ Terminal Varadouro
ponto_da_linha('Av. Nossa Senhora da Penha (Penha)',          '207').
ponto_da_linha('Praia de Seixas (Seixas)',                    '207').
ponto_da_linha('Av. Hilton Souto Maior (Mangabeira VII)',     '207').
ponto_da_linha('Av. Vasco da Gama (Mangabeira)',              '207').
ponto_da_linha('Av. Campos Sales (Rangel)',                   '207').
ponto_da_linha('Terminal de Integração Varadouro',            '207').

% LINHA 304 — Mangabeira Shopping / Bancários / Castelo Branco ↔ Pedro II ↔ Varadouro
ponto_da_linha('Terminal Quadramares - LIQ (Mangabeira VII)', '304').
ponto_da_linha('Av. Hilton Souto Maior (Mangabeira VII)',     '304').
ponto_da_linha('Mangabeira Shopping',                         '304').
ponto_da_linha('Av. Monsenhor Walfredo Leal (Tambauzinho)',   '304').
ponto_da_linha('Av. Epitácio Pessoa (Bancários)',             '304').
ponto_da_linha('Av. João Mauricio (Bancários)',               '304').
ponto_da_linha('UFPB - Campus I (Castelo Branco)',            '304').
ponto_da_linha('Av. Dom Pedro II (Centro)',                   '304').
ponto_da_linha('Terminal de Integração Varadouro',            '304').

% LINHA 508 — Penha Via Jacarapé ↔ Epitácio ↔ Mangabeira Shopping
ponto_da_linha('Terminal Quadramares - LIQ (Mangabeira VII)', '508').
ponto_da_linha('Mangabeira Shopping',                         '508').
ponto_da_linha('Av. Hilton Souto Maior (Mangabeira VII)',     '508').
ponto_da_linha('Av. Epitácio Pessoa (Bancários)',             '508').
ponto_da_linha('Av. Epitácio Pessoa (Tambaú)',                '508').
ponto_da_linha('Orla de Tambaú',                             '508').
ponto_da_linha('Av. Epitácio Pessoa (Cabo Branco)',           '508').
ponto_da_linha('Praia de Jacarapé',                          '508').
ponto_da_linha('Av. Nossa Senhora da Penha (Penha)',          '508').

% LINHA 520 — Altiplano Via Av. Epitácio Pessoa ↔ Terminal Varadouro
ponto_da_linha('Terminal Quadramares - LIQ (Mangabeira VII)', '520').
ponto_da_linha('Av. Hilton Souto Maior (Mangabeira VII)',     '520').
ponto_da_linha('Mangabeira Shopping',                         '520').
ponto_da_linha('Av. Epitácio Pessoa (Bancários)',             '520').
ponto_da_linha('Av. Epitácio Pessoa (Tambaú)',                '520').
ponto_da_linha('Altiplano Cabo Branco',                      '520').
ponto_da_linha('Terminal de Integração Varadouro',            '520').

% LINHA 517 — Mangabeira / Cidade Verde ↔ Av. Epitácio Pessoa ↔ Terminal Lagoa
ponto_da_linha('Mangabeira Shopping',                         '517').
ponto_da_linha('Av. Epitácio Pessoa (Manaíra)',               '517').
ponto_da_linha('Av. Epitácio Pessoa (Tambaú)',                '517').
ponto_da_linha('Av. Epitácio Pessoa (Bancários)',             '517').
ponto_da_linha('Av. Hilton Souto Maior (Mangabeira VII)',     '517').

% LINHA 521 — Manaíra Shopping / Bessa ↔ (integra nos Bancários)
ponto_da_linha('Av. Epitácio Pessoa (Bancários)',             '521').
ponto_da_linha('Av. Epitácio Pessoa (Manaíra)',               '521').
ponto_da_linha('Manaíra Shopping',                           '521').
ponto_da_linha('Av. Flávio Ribeiro Coutinho (Manaíra)',       '521').
ponto_da_linha('Bessa',                                       '521').

% LINHA 301 — Mangabeira IV ↔ Pedro II ↔ Terminal Varadouro
ponto_da_linha('Terminal de Integração Varadouro',            '301').
ponto_da_linha('Av. Dom Pedro II (Centro)',                   '301').
ponto_da_linha('UFPB - Campus I (Castelo Branco)',            '301').
ponto_da_linha('Mangabeira IV',                              '301').

% LINHA 302 — Cidade Verde ↔ Pedro II ↔ Terminal Varadouro
ponto_da_linha('Terminal de Integração Varadouro',            '302').
ponto_da_linha('Av. Dom Pedro II (Centro)',                   '302').
ponto_da_linha('UFPB - Campus I (Castelo Branco)',            '302').
ponto_da_linha('Cidade Verde',                               '302').

% LINHA 510 — Val Paraíso via Tambaú ↔ Epitácio ↔ Terminal Varadouro
ponto_da_linha('Terminal de Integração Varadouro',            '510').
ponto_da_linha('Av. Epitácio Pessoa (Tambaú)',                '510').
ponto_da_linha('Orla de Tambaú',                             '510').
ponto_da_linha('Val Paraíso',                                '510').


% -------------------------------------------------------------
%  FATO: linha_vai_ao_ci(+NumeroDaLinha)
%  Linhas que param no Terminal Quadramares (CI/UFPB)
% -------------------------------------------------------------
linha_vai_ao_ci('203').
linha_vai_ao_ci('207').
linha_vai_ao_ci('304').
linha_vai_ao_ci('508').
linha_vai_ao_ci('520').


% -------------------------------------------------------------
%  FATO: ponto_de_baldeacao(+Ponto, +LinhaQueChega, +LinhaQueSai)
%  Pontos onde é possível trocar de linha rumo ao CI
% -------------------------------------------------------------
ponto_de_baldeacao('Terminal de Integração Varadouro', '301', '203').
ponto_de_baldeacao('Terminal de Integração Varadouro', '301', '207').
ponto_de_baldeacao('Terminal de Integração Varadouro', '302', '203').
ponto_de_baldeacao('Terminal de Integração Varadouro', '302', '207').
ponto_de_baldeacao('Terminal de Integração Varadouro', '510', '203').
ponto_de_baldeacao('Terminal de Integração Varadouro', '510', '207').
ponto_de_baldeacao('Av. Epitácio Pessoa (Bancários)',  '521', '304').
ponto_de_baldeacao('Av. Epitácio Pessoa (Bancários)',  '521', '508').
ponto_de_baldeacao('Av. Epitácio Pessoa (Bancários)',  '521', '520').
ponto_de_baldeacao('Mangabeira Shopping',              '517', '304').
ponto_de_baldeacao('Mangabeira Shopping',              '517', '508').
ponto_de_baldeacao('Mangabeira Shopping',              '517', '520').


% =============================================================
%  REGRAS DE BUSCA
% =============================================================

% rota_direta(+Origem, -Linha)
% Verdadeiro se existe uma linha direta da Origem até o CI.
rota_direta(Origem, Linha) :-
    ponto_da_linha(Origem, Linha),
    linha_vai_ao_ci(Linha).

% rota_com_baldeacao(+Origem, -Linha1, -PontoBaldeacao, -Linha2)
% Verdadeiro se existe: Origem --Linha1--> PontoBaldeacao --Linha2--> CI
rota_com_baldeacao(Origem, Linha1, PontoBaldeacao, Linha2) :-
    ponto_da_linha(Origem, Linha1),
    \+ linha_vai_ao_ci(Linha1),
    ponto_de_baldeacao(PontoBaldeacao, Linha1, Linha2),
    ponto_da_linha(PontoBaldeacao, Linha1),
    linha_vai_ao_ci(Linha2).


% =============================================================
%  INTERFACE AMIGÁVEL
% =============================================================

% consultar(+Origem)
% Ponto de entrada principal.
consultar(Origem) :-
    format("~n==============================================~n"),
    format(" GPS CI/UFPB~n"),
    format(" Origem : ~w~n", [Origem]),
    format(" Destino: Terminal Quadramares - LIQ (CI/UFPB)~n"),
    format("==============================================~n"),
    (
        buscar_rotas(Origem)
    ;
        format("~n  [!] Nenhuma rota encontrada para esse ponto.~n"),
        format("      Use listar_pontos para ver os pontos cadastrados.~n~n")
    ), !.

% buscar_rotas(+Origem)
buscar_rotas(Origem) :-
    (
        rota_direta(Origem, _)
    ->
        format("~n  Rotas diretas encontradas:~n"),
        forall(
            rota_direta(Origem, Linha),
            exibir_direta(Linha)
        )
    ;
        rota_com_baldeacao(Origem, _, _, _)
    ->
        format("~n  Sem rota direta. Rotas com baldeação encontradas:~n"),
        forall(
            rota_com_baldeacao(Origem, L1, PB, L2),
            exibir_baldeacao(L1, PB, L2)
        )
    ).

exibir_direta(Linha) :-
    format("~n  ✔  DIRETA~n"),
    format("     Linha ~w~n", [Linha]),
    format("     Embarque aqui → Desembarque no CI/UFPB~n").

exibir_baldeacao(Linha1, PontoBaldeacao, Linha2) :-
    format("~n  ⇄  COM BALDEAÇÃO~n"),
    format("     1ª Linha : ~w~n", [Linha1]),
    format("     Baldeação: ~w~n", [PontoBaldeacao]),
    format("     2ª Linha : ~w~n", [Linha2]),
    format("     Desembarque no CI/UFPB~n").

% listar_pontos/0 — lista todos os pontos cadastrados (sem duplicatas)
listar_pontos :-
    format("~n=== PONTOS CADASTRADOS ===~n"),
    format("Use exatamente esses nomes em: consultar('Nome do Ponto').~n~n"),
    findall(P, ponto_da_linha(P, _), Todos),
    sort(Todos, Unicos),
    forall(member(P, Unicos), format("  ~w~n", [P])).


% =============================================================
%  EXEMPLOS:
%
%  ?- consultar('Orla de Tambaú').
%  ?- consultar('Av. Dom Pedro II (Centro)').
%  ?- consultar('UFPB - Campus I (Castelo Branco)').
%  ?- consultar('Bessa').
%  ?- consultar('Val Paraíso').
%  ?- consultar('Mangabeira IV').
%  ?- listar_pontos.
% =============================================================