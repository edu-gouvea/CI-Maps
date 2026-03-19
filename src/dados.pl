% =============================================================
%  dados.pl — Base de conhecimento do GPS CI/UFPB
%  Contém todos os fatos: pontos, linhas e baldeações
% =============================================================

% -------------------------------------------------------------
%  ponto_da_linha(+PontoDeOnibus, +NumeroDaLinha)
%  Indica que um ponto é servido por uma linha.
% -------------------------------------------------------------

% LINHA 203 — Mangabeira VII ↔ José Américo ↔ Rangel ↔ Terminal Varadouro
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
% CORREÇÃO: adicionado o Terminal Quadramares, que é o destino final da linha 207
ponto_da_linha('Terminal Quadramares - LIQ (Mangabeira VII)', '207'). 
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

% LINHA 517 — Mangabeira / Cidade Verde ↔ Av. Epitácio Pessoa
ponto_da_linha('Mangabeira Shopping',                         '517').
ponto_da_linha('Av. Epitácio Pessoa (Manaíra)',               '517').
ponto_da_linha('Av. Epitácio Pessoa (Tambaú)',                '517').
ponto_da_linha('Av. Epitácio Pessoa (Bancários)',             '517').
ponto_da_linha('Av. Hilton Souto Maior (Mangabeira VII)',     '517').

% LINHA 521 — Manaíra Shopping / Bessa
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

% LINHA 510 — Val Paraíso via Tambaú ↔ Terminal Varadouro
ponto_da_linha('Terminal de Integração Varadouro',            '510').
ponto_da_linha('Av. Epitácio Pessoa (Tambaú)',                '510').
ponto_da_linha('Orla de Tambaú',                             '510').
ponto_da_linha('Val Paraíso',                                '510').


% -------------------------------------------------------------
%  linha_vai_ao_ci(+NumeroDaLinha)
%  Linhas que param no Terminal Quadramares (CI/UFPB)
% -------------------------------------------------------------
linha_vai_ao_ci('203').
linha_vai_ao_ci('207').
linha_vai_ao_ci('304').
linha_vai_ao_ci('508').
linha_vai_ao_ci('520').


% -------------------------------------------------------------
%  nome_linha(+NumeroDaLinha, -NomeDescritivo)
%  Nome legível de cada linha para exibição ao usuário
% -------------------------------------------------------------
nome_linha('203', 'Mangabeira VII / José Américo / Rangel ↔ Terminal Varadouro').
nome_linha('207', 'Penha Via Seixas / Mangabeira ↔ Terminal Varadouro').
nome_linha('304', 'Mangabeira Shopping / Bancários / Castelo Branco ↔ Pedro II').
nome_linha('508', 'Penha Via Jacarapé / Cabo Branco / Tambaú ↔ Mangabeira').
nome_linha('520', 'Altiplano / Tambaú / Bancários ↔ Terminal Varadouro').
nome_linha('301', 'Mangabeira IV / Castelo Branco ↔ Terminal Varadouro').
nome_linha('302', 'Cidade Verde / Castelo Branco ↔ Terminal Varadouro').
nome_linha('510', 'Val Paraíso / Tambaú ↔ Terminal Varadouro').
nome_linha('517', 'Mangabeira Shopping / Bancários ↔ Manaíra').
nome_linha('521', 'Bessa / Manaíra Shopping ↔ Bancários').


% -------------------------------------------------------------
%  ponto_de_baldeacao(+Ponto, +LinhaQueChega, +LinhaQueSai)
%  Onde é possível trocar de linha rumo ao CI
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