% =============================================================
% dados_v2.pl — Base de conhecimento do GPS CI/UFPB
% Versão 2.0 — Revisada e ampliada com base na realidade SEMOB-JP
%
% Modelo:
%   parada(Id, Rua, Referencia, Bairro, Sentido).
%   linha(Codigo, Nome).
%   passa_por(Linha, IdParada).
%   linha_vai_ao_ci(CodigoLinha).
%   ponto_de_baldeacao(IdParada, LinhaQueChega, LinhaQueSai).
%   horario_primeira_viagem(CodigoLinha, Sentido, Hora).
%   horario_ultima_viagem(CodigoLinha, Sentido, Hora).
%   opera_nos_dias(CodigoLinha, Dias).
%   tipo_linha(CodigoLinha, Tipo).
%   acessibilidade_parada(IdParada, TipoRecurso).
%
% NOTAS DE REVISÃO (v1 → v2):
%   [CORRIGIDO]  Linha 304 renomeada: era 'Bancarios/Castelo Branco - Pedro II',
%                agora reflete itinerário real via Dom Pedro II / Campus V
%   [ADICIONADO] Linha 303 — Cidade Verde / Pedro II (irmã da 302, via Dom Pedro II)
%   [ADICIONADO] Linha 518 — Bancarios / Epitacio (substituta da antiga 5310)
%   [ADICIONADO] Linha 527 — Castelo Branco / Epitacio (criada em 2022 para UFPB)
%   [ADICIONADO] Paradas p054..p070 cobrindo novos corredores
%   [ADICIONADO] Fatos de horário, dias de operação, tipo e acessibilidade
%   [ADICIONADO] linha_vai_ao_ci para 303, 518, 527
%   [ADICIONADO] Baldeações envolvendo 518 e 527
%   [CORRIGIDO]  Referência p013 ajustada para incluir 'Girador UFPB / Via Expressa Padre Ze'
%   [CORRIGIDO]  Sentido de p029 ajustado; girador é ponto de retorno real
% =============================================================


% =============================================================
% PARADAS
% parada(+Id, +Rua, +Referencia, +Bairro, +Sentido)
% Sentido: bairro_centro = da origem ao Centro/Varadouro/Epitacio
%          centro_bairro = retorno
%          circular     = linha sem sentido fixo
% =============================================================

% --- Mangabeira ---
parada(p001, 'Av. dos Escoteiros', 'Terminal Distrito Mangabeira', 'Mangabeira', 'bairro_centro').
parada(p002, 'Av. Hilton Souto Maior', 'Shopping Mangabeira / retorno Quadramares', 'Mangabeira', 'bairro_centro').
parada(p003, 'Rua Josefa Taveira', 'Corredor comercial de Mangabeira', 'Mangabeira', 'bairro_centro').
parada(p004, 'Rua Benicio de Oliveira Lima', 'Acesso interno de Mangabeira', 'Mangabeira', 'bairro_centro').

% --- Rangel ---
parada(p005, 'Av. Vasco da Gama', 'Corredor do Rangel', 'Rangel', 'bairro_centro').

% --- Centro / Lagoa ---
parada(p006, 'Parque Solon de Lucena', 'Lagoa / Plataformas TIL', 'Centro', 'bairro_centro').
parada(p007, 'Terminal de Integracao do Varadouro', 'Terminal de Integracao do Varadouro (TIV)', 'Varadouro', 'bairro_centro').
parada(p008, 'Av. Sanhaua', 'Acesso ao Varadouro', 'Varadouro', 'bairro_centro').

% --- Penha / Seixas ---
parada(p009, 'Av. Nossa Senhora da Penha', 'Terminal Penha', 'Penha', 'bairro_centro').
parada(p010, 'Rodovia PB-008', 'Acesso Seixas/Penha', 'Penha', 'bairro_centro').
parada(p011, 'Rua Comerc Jose Gomes dos Santos', 'Vila dos Pescadores / Penha', 'Penha', 'bairro_centro').
parada(p012, 'Av. da Falesia', 'Orla da Penha/Seixas', 'Penha', 'bairro_centro').

% --- Bancários / UFPB ---
% [CORRIGIDO v2] Referencia ampliada para incluir o Girador e a Via Expressa Padre Ze
parada(p013, 'Rua Tab Estanislau Eloy / Via Expressa Padre Ze', 'HU/UFPB — Girador Campus I', 'Bancarios', 'bairro_centro').
parada(p014, 'Rua Empre Joao Rodrigues Alves', 'Entorno UFPB / Bancarios', 'Bancarios', 'bairro_centro').

% --- Castelo Branco ---
parada(p015, 'Av. Dom Pedro II', 'Corredor Pedro II / Acesso UFPB e Centro Administrativo', 'Castelo Branco', 'bairro_centro').

% --- Torre ---
parada(p016, 'Av. Nossa Senhora de Fatima', 'Trecho proximo ao Centro', 'Torre', 'bairro_centro').

% --- Centro (corredor) ---
parada(p017, 'Av. Camilo de Holanda', 'Centro', 'Centro', 'bairro_centro').

% --- Tambauzinho / Tambau / Epitacio ---
parada(p018, 'Praca da Independencia', 'Praca da Independencia — Tambauzinho', 'Tambauzinho', 'bairro_centro').
parada(p019, 'Av. Pres Epitacio Pessoa', 'Corredor principal da Epitacio', 'Tambau', 'bairro_centro').

% --- Manaira ---
parada(p020, 'Av. Joao Mauricio', 'Orla de Manaira', 'Manaira', 'bairro_centro').
parada(p021, 'Av. Senador Ruy Carneiro', 'Ligacao Manaira - Epitacio', 'Manaira', 'bairro_centro').
parada(p022, 'Av. Gov Flavio Ribeiro Coutinho', 'Corredor de Manaira/Bessa', 'Manaira', 'bairro_centro').

% --- Bessa ---
parada(p023, 'Terminal de Integracao do Bessa', 'Terminal de Integracao do Bessa (TIB)', 'Bessa', 'bairro_centro').
parada(p024, 'Terminal Val Paraiso', 'Terminal Val Paraiso', 'Bessa', 'bairro_centro').

% --- Altiplano / Cabo Branco ---
parada(p025, 'Av. Gov Antonio da Silva Mariz', 'Acesso Altiplano/Cabo Branco', 'Altiplano', 'bairro_centro').
parada(p026, 'Av. Joao Cirilo da Silva', 'Corredor do Altiplano', 'Altiplano', 'bairro_centro').
parada(p027, 'Terminal Altiplano', 'Terminal Altiplano', 'Altiplano', 'bairro_centro').
parada(p028, 'Av. Mons Odilon Coutinho', 'Corredor do Altiplano', 'Altiplano', 'bairro_centro').
% [CORRIGIDO v2] Girador é ponto de retorno/controle da linha 520
parada(p029, 'Girador Estacao Ciencias', 'Estacao Ciencias — ponto de retorno linha 520', 'Altiplano', 'circular').
parada(p030, 'Av. Panoramica/PB-008', 'Trecho panoramico Altiplano', 'Altiplano', 'bairro_centro').

% --- Cidade Verde ---
parada(p031, 'Terminal Patricia Tomaz', 'Terminal Patricia Tomaz', 'Cidade Verde', 'bairro_centro').
parada(p032, 'Rua das Tres Marias', 'Acesso ao Terminal Patricia Tomaz', 'Cidade Verde', 'bairro_centro').
parada(p033, 'Av. Jatoba', 'Corredor Cidade Verde', 'Cidade Verde', 'bairro_centro').

% --- Bancários (corredor) ---
parada(p034, 'Rua Walfredo Macedo Brandao', 'Corredor dos Bancarios', 'Bancarios', 'bairro_centro').
parada(p035, 'Rua Banc Sergio Guerra', 'Corredor dos Bancarios', 'Bancarios', 'bairro_centro').

% --- Castelo Branco (corredor) ---
parada(p036, 'Av. Pres Castelo Branco', 'Corredor / Acesso Castelo Branco', 'Castelo Branco', 'bairro_centro').

% --- Miramar ---
parada(p037, 'Praca Tito Silva', 'Praca Tito Silva — Miramar', 'Miramar', 'bairro_centro').

% --- Colinas do Sul / Grotão ---
parada(p038, 'Terminal de Integracao Colinas', 'Terminal de Integracao Colinas do Sul', 'Colinas do Sul', 'bairro_centro').
parada(p039, 'Rua Joaquim Monteiro da Franca', 'Corredor Colinas do Sul', 'Colinas do Sul', 'bairro_centro').
parada(p040, 'Rodovia BR-101', 'Trecho BR-101 / Grotao', 'Grotao', 'bairro_centro').
parada(p041, 'Av. Cruz das Armas', 'Corredor Cruz das Armas', 'Cruz das Armas', 'bairro_centro').
parada(p042, 'Av. dos Tabajaras', 'Trecho central Jaguaribe', 'Jaguaribe', 'bairro_centro').

% --- Miramar / Expedicionários / Torre ---
parada(p043, 'Terminal do Mercado de Miramar', 'Terminal do Mercado de Miramar', 'Miramar', 'bairro_centro').
parada(p044, 'Av. Expedicionarios', 'Corredor dos Expedicionarios', 'Expedicionarios', 'bairro_centro').
parada(p045, 'Av. Juarez Tavora', 'Corredor da Torre', 'Torre', 'bairro_centro').
parada(p046, 'Av. Rui Barbosa', 'Trecho Torre/Tambauzinho', 'Torre', 'bairro_centro').
parada(p047, 'Av. Min Jose Americo de Almeida', 'Beira Rio', 'Torre', 'bairro_centro').
parada(p048, 'Av. Duarte da Silveira', 'Acesso Centro', 'Centro', 'bairro_centro').

% --- Colinas II / Geisel ---
parada(p049, 'Terminal Colinas II', 'Terminal Colinas II', 'Colinas do Sul', 'bairro_centro').
parada(p050, 'Rua Jose de Carvalho Costa Filho', 'Acesso Colinas II', 'Colinas do Sul', 'bairro_centro').
parada(p051, 'Av. Valdemar Galdino Naziazeno', 'Corredor Geisel/Colinas', 'Geisel', 'bairro_centro').
parada(p052, 'Rua Diogenes Chianca', 'Corredor Mangabeira/Geisel', 'Mangabeira', 'bairro_centro').
parada(p053, 'Rua Jose Firmino Ferreira', 'Trecho Bancarios', 'Bancarios', 'bairro_centro').

% =============================================================
% PARADAS ADICIONADAS NA v2
% =============================================================

% --- Castelo Branco (corredor Dom Pedro II — linhas 303, 304, 527) ---
parada(p054, 'Av. Dom Pedro II', 'Proximo ao viaduto / Castelo Branco Norte', 'Castelo Branco', 'bairro_centro').
parada(p055, 'Av. Dom Pedro II', 'Em frente ao Parque Estadual Zoobotanico', 'Castelo Branco', 'bairro_centro').
parada(p056, 'Av. Dom Pedro II', 'Acesso ao Campus V UFPB / Mangabeira', 'Castelo Branco', 'bairro_centro').

% --- Bancários (linha 518 — corredor Epitacio/Bancarios) ---
parada(p057, 'Av. Pres Epitacio Pessoa', 'Proximo ao Busto Epitacio — sentido Bancarios', 'Tambauzinho', 'bairro_centro').
parada(p058, 'Rua Engenheiro Jose Rufino Rodrigues', 'Acesso aos Bancarios via Epitacio', 'Bancarios', 'bairro_centro').

% --- Linha 527 (Castelo Branco / Epitacio — exclusiva UFPB) ---
parada(p059, 'Via Expressa Padre Ze', 'Girador UFPB — ponto de controle linha 527', 'Bancarios', 'bairro_centro').
parada(p060, 'Av. Dom Pedro II', 'Trecho Castelo Branco — linha 527', 'Castelo Branco', 'bairro_centro').

% --- Altiplano / Cabo Branco complementares ---
parada(p061, 'Av. Cabo Branco', 'Orla de Cabo Branco', 'Cabo Branco', 'bairro_centro').
parada(p062, 'Av. Atlas', 'Corredor Altiplano / Acesso ao Portal do Sol', 'Altiplano', 'bairro_centro').

% --- Portal do Sol (linha 508 — itinerario alterado 2022) ---
parada(p063, 'Rua Mauricio de Araujo Gama Filho', 'Portal do Sol — novo trecho linha 508', 'Portal do Sol', 'bairro_centro').

% --- Miramar / corredor 402 complementar ---
parada(p064, 'Av. Pres Getulio Vargas', 'Corredor Getulio Vargas / Miramar', 'Miramar', 'bairro_centro').

% --- Cruz das Armas complementar ---
parada(p065, 'Rua Beaurepaire Rohan', 'Trecho Cruz das Armas / acesso ao corredor 101', 'Cruz das Armas', 'bairro_centro').

% --- Tambaú complementar (linha 510) ---
parada(p066, 'Av. Joao Mauricio', 'Largo de Tambau — terminal provisorio linha 510', 'Tambau', 'bairro_centro').

% --- Centro Administrativo / PMJP ---
parada(p067, 'Av. Camilo de Holanda', 'Centro Administrativo Municipal', 'Centro', 'bairro_centro').

% --- Valentina (linha 1500 referenciada indiretamente) ---
parada(p068, 'Av. Hilton Souto Maior', 'Valentina de Figueiredo — trecho norte', 'Valentina', 'bairro_centro').

% --- Geisel (acesso linha 523) ---
parada(p069, 'Av. Valdemar Galdino Naziazeno', 'Geisel / acesso residencial', 'Geisel', 'bairro_centro').

% --- Cristo Redentor (baldeacao regional) ---
parada(p070, 'Av. Santa Catarina', 'Corredor Cristo Redentor', 'Cristo', 'bairro_centro').


% =============================================================
% LINHAS
% linha(+Codigo, +Nome)
% =============================================================

linha('101', 'Grotao / Colinas do Sul').
linha('203', 'Mangabeira / Rangel').
linha('207', 'Penha').
% [ADICIONADO v2] Linha 303 — Cidade Verde/Pedro II (confirmada pela SEMOB)
linha('303', 'Cidade Verde / Pedro II').
% [CORRIGIDO v2] Nome alinhado ao itinerario real: passa pelo Campus V via Dom Pedro II
linha('301', 'Mangabeira Pedro II - Direto').
linha('302', 'Cidade Verde').
linha('304', 'Bancarios / Castelo Branco - Pedro II').
linha('402', 'Torre').
linha('508', 'Cabo Branco / Penha').
linha('510', 'Tambau via Tamandare').
% [ADICIONADO v2] Linha 518 — Bancarios/Epitacio (substituta da 5310, confirmada SEMOB)
linha('518', 'Bancarios / Epitacio').
linha('517', 'Mangabeira Cidade Verde Epitacio').
linha('520', 'Altiplano / Epitacio').
linha('521', 'Manaira / Bessa').
linha('523', 'Colinas do Sul / Epitacio').
% [ADICIONADO v2] Linha 527 — Castelo Branco/Epitacio (criada em 2022, foco UFPB)
linha('527', 'Castelo Branco / Epitacio').


% =============================================================
% passa_por(+Linha, +IdParada)
% =============================================================

% --- 101 — Grotao / Colinas do Sul ---
passa_por('101', p038).
passa_por('101', p039).
passa_por('101', p040).
passa_por('101', p041).
passa_por('101', p065).
passa_por('101', p005).
passa_por('101', p042).
passa_por('101', p006).
passa_por('101', p007).

% --- 203 — Mangabeira / Rangel ---
passa_por('203', p001).
passa_por('203', p002).
passa_por('203', p003).
passa_por('203', p004).
passa_por('203', p052).
passa_por('203', p005).
passa_por('203', p006).

% --- 207 — Penha ---
passa_por('207', p009).
passa_por('207', p011).
passa_por('207', p010).
passa_por('207', p002).
passa_por('207', p003).
passa_por('207', p004).
passa_por('207', p052).
passa_por('207', p005).
passa_por('207', p006).

% --- 301 — Mangabeira Pedro II Direto ---
passa_por('301', p001).
passa_por('301', p003).
passa_por('301', p034).
passa_por('301', p035).
passa_por('301', p014).
passa_por('301', p013).
passa_por('301', p015).
passa_por('301', p016).
passa_por('301', p017).
passa_por('301', p006).
passa_por('301', p007).

% --- 302 — Cidade Verde ---
passa_por('302', p031).
passa_por('302', p032).
passa_por('302', p033).
passa_por('302', p002).
passa_por('302', p034).
passa_por('302', p035).
passa_por('302', p014).
passa_por('302', p013).
passa_por('302', p015).
passa_por('302', p016).
passa_por('302', p017).
passa_por('302', p006).
passa_por('302', p007).

% --- 303 — Cidade Verde / Pedro II [ADICIONADO v2] ---
% Trajeto: Terminal Patricia Tomaz → Cidade Verde → Bancarios → Pedro II → Lagoa → TIV
passa_por('303', p031).
passa_por('303', p033).
passa_por('303', p034).
passa_por('303', p035).
passa_por('303', p014).
passa_por('303', p013).
passa_por('303', p054).
passa_por('303', p055).
passa_por('303', p056).
passa_por('303', p006).
passa_por('303', p007).

% --- 304 — Bancarios / Castelo Branco - Pedro II ---
passa_por('304', p001).
passa_por('304', p002).
passa_por('304', p014).
passa_por('304', p013).
passa_por('304', p054).
passa_por('304', p055).
passa_por('304', p056).
passa_por('304', p015).
passa_por('304', p016).
passa_por('304', p017).
passa_por('304', p006).
passa_por('304', p007).

% --- 402 — Torre ---
passa_por('402', p043).
passa_por('402', p037).
passa_por('402', p064).
passa_por('402', p044).
passa_por('402', p045).
passa_por('402', p046).
passa_por('402', p047).
passa_por('402', p048).
passa_por('402', p006).
passa_por('402', p007).

% --- 508 — Cabo Branco / Penha (com novo trecho Portal do Sol — 2022) ---
passa_por('508', p009).
passa_por('508', p012).
passa_por('508', p063).
passa_por('508', p010).
passa_por('508', p002).
passa_por('508', p025).
passa_por('508', p061).
passa_por('508', p062).
passa_por('508', p026).
passa_por('508', p028).
passa_por('508', p019).
passa_por('508', p018).
passa_por('508', p006).
passa_por('508', p007).

% --- 510 — Tambau via Tamandare ---
passa_por('510', p024).
passa_por('510', p022).
passa_por('510', p020).
passa_por('510', p066).
passa_por('510', p019).
passa_por('510', p018).
passa_por('510', p006).
passa_por('510', p007).

% --- 517 — Mangabeira Cidade Verde Epitacio ---
passa_por('517', p031).
passa_por('517', p033).
passa_por('517', p003).
passa_por('517', p034).
passa_por('517', p035).
passa_por('517', p014).
passa_por('517', p013).
passa_por('517', p036).
passa_por('517', p037).
passa_por('517', p019).
passa_por('517', p018).
passa_por('517', p006).

% --- 518 — Bancarios / Epitacio [ADICIONADO v2] ---
% Substituta da 5310; ida/volta pela Av. Epitacio Pessoa
passa_por('518', p013).
passa_por('518', p014).
passa_por('518', p035).
passa_por('518', p057).
passa_por('518', p058).
passa_por('518', p019).
passa_por('518', p018).
passa_por('518', p006).
passa_por('518', p007).

% --- 520 — Altiplano / Epitacio ---
passa_por('520', p002).
passa_por('520', p025).
passa_por('520', p026).
passa_por('520', p027).
passa_por('520', p028).
passa_por('520', p029).
passa_por('520', p030).

% --- 521 — Manaira / Bessa ---
passa_por('521', p023).
passa_por('521', p022).
passa_por('521', p021).
passa_por('521', p020).
passa_por('521', p019).
passa_por('521', p018).
passa_por('521', p006).

% --- 523 — Colinas do Sul / Epitacio ---
passa_por('523', p049).
passa_por('523', p050).
passa_por('523', p039).
passa_por('523', p051).
passa_por('523', p069).
passa_por('523', p052).
passa_por('523', p053).
passa_por('523', p014).
passa_por('523', p013).
passa_por('523', p036).
passa_por('523', p037).
passa_por('523', p019).
passa_por('523', p018).
passa_por('523', p006).

% --- 527 — Castelo Branco / Epitacio [ADICIONADO v2] ---
% 12 viagens diárias (seg–sex, 6h–18h40). Girador UFPB → Castelo Branco → Epitacio → TIV
passa_por('527', p059).
passa_por('527', p013).
passa_por('527', p014).
passa_por('527', p060).
passa_por('527', p054).
passa_por('527', p036).
passa_por('527', p019).
passa_por('527', p018).
passa_por('527', p006).
passa_por('527', p007).


% =============================================================
% LINHAS QUE LEVAM AO ENTORNO DO CI / UFPB (Campus I)
% Critério: passam por p013 (HU/Girador UFPB) ou p014 (entorno UFPB)
% =============================================================

linha_vai_ao_ci('301').
linha_vai_ao_ci('302').
linha_vai_ao_ci('303').  % [ADICIONADO v2]
linha_vai_ao_ci('304').
linha_vai_ao_ci('517').
linha_vai_ao_ci('518').  % [ADICIONADO v2]
linha_vai_ao_ci('523').
linha_vai_ao_ci('527').  % [ADICIONADO v2]


% =============================================================
% PONTOS DE BALDEACAO
% ponto_de_baldeacao(+IdParada, +LinhaQueChega, +LinhaQueSai)
% =============================================================

% --- Terminal do Varadouro (TIV) — p007 ---
ponto_de_baldeacao(p007, '101', '301').
ponto_de_baldeacao(p007, '101', '302').
ponto_de_baldeacao(p007, '101', '303').   % [ADICIONADO v2]
ponto_de_baldeacao(p007, '101', '304').
ponto_de_baldeacao(p007, '402', '301').
ponto_de_baldeacao(p007, '402', '302').
ponto_de_baldeacao(p007, '402', '303').   % [ADICIONADO v2]
ponto_de_baldeacao(p007, '402', '304').
ponto_de_baldeacao(p007, '510', '301').
ponto_de_baldeacao(p007, '510', '302').
ponto_de_baldeacao(p007, '510', '303').   % [ADICIONADO v2]
ponto_de_baldeacao(p007, '510', '304').
ponto_de_baldeacao(p007, '508', '301').
ponto_de_baldeacao(p007, '508', '302').
ponto_de_baldeacao(p007, '508', '303').   % [ADICIONADO v2]
ponto_de_baldeacao(p007, '508', '304').
ponto_de_baldeacao(p007, '518', '301').   % [ADICIONADO v2]
ponto_de_baldeacao(p007, '518', '302').   % [ADICIONADO v2]
ponto_de_baldeacao(p007, '527', '101').   % [ADICIONADO v2]
ponto_de_baldeacao(p007, '527', '402').   % [ADICIONADO v2]
ponto_de_baldeacao(p007, '527', '510').   % [ADICIONADO v2]

% --- Epitacio / Praca da Independencia — p018 ---
ponto_de_baldeacao(p018, '510', '517').
ponto_de_baldeacao(p018, '510', '523').
ponto_de_baldeacao(p018, '521', '517').
ponto_de_baldeacao(p018, '521', '523').
ponto_de_baldeacao(p018, '508', '517').
ponto_de_baldeacao(p018, '508', '523').
ponto_de_baldeacao(p018, '510', '518').   % [ADICIONADO v2]
ponto_de_baldeacao(p018, '521', '518').   % [ADICIONADO v2]
ponto_de_baldeacao(p018, '510', '527').   % [ADICIONADO v2]
ponto_de_baldeacao(p018, '521', '527').   % [ADICIONADO v2]

% --- HU / Girador UFPB — p013 ---
ponto_de_baldeacao(p013, '517', '301').
ponto_de_baldeacao(p013, '517', '302').
ponto_de_baldeacao(p013, '517', '303').   % [ADICIONADO v2]
ponto_de_baldeacao(p013, '523', '301').
ponto_de_baldeacao(p013, '523', '302').
ponto_de_baldeacao(p013, '523', '303').   % [ADICIONADO v2]
ponto_de_baldeacao(p013, '518', '527').   % [ADICIONADO v2]
ponto_de_baldeacao(p013, '527', '518').   % [ADICIONADO v2]

% --- Shopping Mangabeira / Av. Hilton Souto Maior — p002 ---
ponto_de_baldeacao(p002, '203', '520').
ponto_de_baldeacao(p002, '203', '508').
ponto_de_baldeacao(p002, '207', '520').
ponto_de_baldeacao(p002, '207', '508').
ponto_de_baldeacao(p002, '302', '520').
ponto_de_baldeacao(p002, '304', '520').   % [ADICIONADO v2]

% --- Lagoa / Parque Solon de Lucena — p006 ---
% Ponto de baldeacao central entre linhas que passam pela Lagoa
ponto_de_baldeacao(p006, '101', '510').   % [ADICIONADO v2]
ponto_de_baldeacao(p006, '101', '402').   % [ADICIONADO v2]
ponto_de_baldeacao(p006, '402', '510').   % [ADICIONADO v2]
ponto_de_baldeacao(p006, '518', '101').   % [ADICIONADO v2]
ponto_de_baldeacao(p006, '527', '101').   % [ADICIONADO v2]
ponto_de_baldeacao(p006, '523', '510').   % [ADICIONADO v2]


% =============================================================
% HORÁRIOS (primeira e última viagem)
% horario_primeira_viagem(+CodigoLinha, +Sentido, +Hora)
% horario_ultima_viagem(+CodigoLinha, +Sentido, +Hora)
% Hora no formato HH:MM
% Sentido: bairro_centro | centro_bairro
% =============================================================

horario_primeira_viagem('101', bairro_centro, '05:30').
horario_ultima_viagem('101',   bairro_centro, '22:00').
horario_primeira_viagem('203', bairro_centro, '05:30').
horario_ultima_viagem('203',   bairro_centro, '22:30').
horario_primeira_viagem('207', bairro_centro, '05:30').
horario_ultima_viagem('207',   bairro_centro, '22:00').
horario_primeira_viagem('301', bairro_centro, '05:00').
horario_ultima_viagem('301',   bairro_centro, '22:20').  % operacao noturna UFPB
horario_primeira_viagem('302', bairro_centro, '05:00').
horario_ultima_viagem('302',   bairro_centro, '22:20').  % operacao noturna UFPB
horario_primeira_viagem('303', bairro_centro, '05:00').
horario_ultima_viagem('303',   bairro_centro, '22:20').  % operacao noturna UFPB
horario_primeira_viagem('304', bairro_centro, '05:00').
horario_ultima_viagem('304',   bairro_centro, '22:00').
horario_primeira_viagem('402', bairro_centro, '05:30').
horario_ultima_viagem('402',   bairro_centro, '22:00').
horario_primeira_viagem('508', bairro_centro, '05:30').
horario_ultima_viagem('508',   bairro_centro, '22:00').
horario_primeira_viagem('510', bairro_centro, '05:00').
horario_ultima_viagem('510',   bairro_centro, '22:50').  % ampliado por demanda UFPB
horario_primeira_viagem('517', bairro_centro, '05:00').
horario_ultima_viagem('517',   bairro_centro, '22:00').
horario_primeira_viagem('518', bairro_centro, '05:00').
horario_ultima_viagem('518',   bairro_centro, '22:20').  % operacao noturna UFPB
horario_primeira_viagem('520', bairro_centro, '06:00').
horario_ultima_viagem('520',   bairro_centro, '19:00').
horario_primeira_viagem('521', bairro_centro, '05:30').
horario_ultima_viagem('521',   bairro_centro, '22:00').
horario_primeira_viagem('523', bairro_centro, '05:00').
horario_ultima_viagem('523',   bairro_centro, '22:50').  % ampliado por demanda UFPB
% [ADICIONADO v2] Linha 527: seg-sex apenas, 12 viagens diárias (6h–18h40)
horario_primeira_viagem('527', bairro_centro, '06:00').
horario_ultima_viagem('527',   bairro_centro, '18:40').


% =============================================================
% DIAS DE OPERAÇÃO
% opera_nos_dias(+CodigoLinha, +Dias)
% Dias: uteis | sabados | domingos_feriados | diario
% =============================================================

opera_nos_dias('101',  diario).
opera_nos_dias('203',  diario).
opera_nos_dias('207',  diario).
opera_nos_dias('301',  diario).
opera_nos_dias('302',  diario).
opera_nos_dias('303',  diario).
opera_nos_dias('304',  diario).
opera_nos_dias('402',  diario).
opera_nos_dias('508',  diario).
opera_nos_dias('510',  diario).
opera_nos_dias('517',  diario).
% [ADICIONADO v2] 518 opera nos dias úteis; confirmar sábado na SEMOB
opera_nos_dias('518',  uteis).
opera_nos_dias('520',  uteis).
opera_nos_dias('521',  diario).
opera_nos_dias('523',  uteis).
% [ADICIONADO v2] 527 exclusivamente dias úteis (conforme portaria SEMOB 2022)
opera_nos_dias('527',  uteis).


% =============================================================
% TIPO DE LINHA
% tipo_linha(+CodigoLinha, +Tipo)
% Tipo: convencional | expresso | universitario | circular | alimentador
% =============================================================

tipo_linha('101', convencional).
tipo_linha('203', convencional).
tipo_linha('207', convencional).
tipo_linha('301', convencional).
tipo_linha('302', convencional).
tipo_linha('303', convencional).
tipo_linha('304', convencional).
tipo_linha('402', convencional).
tipo_linha('508', convencional).
tipo_linha('510', convencional).
tipo_linha('517', convencional).
tipo_linha('518', universitario).  % [ADICIONADO v2] foco Bancarios/UFPB–Epitacio
tipo_linha('520', convencional).
tipo_linha('521', convencional).
tipo_linha('523', convencional).
tipo_linha('527', universitario).  % [ADICIONADO v2] criada especificamente para UFPB


% =============================================================
% ACESSIBILIDADE NAS PARADAS
% acessibilidade_parada(+IdParada, +TipoRecurso)
% Recursos: rampa | piso_tatil | abrigo | painelEletronico | banheiro
% =============================================================

acessibilidade_parada(p007, rampa).
acessibilidade_parada(p007, piso_tatil).
acessibilidade_parada(p007, abrigo).
acessibilidade_parada(p007, painelEletronico).
acessibilidade_parada(p007, banheiro).
acessibilidade_parada(p006, rampa).
acessibilidade_parada(p006, piso_tatil).
acessibilidade_parada(p006, abrigo).
acessibilidade_parada(p006, painelEletronico).
acessibilidade_parada(p001, abrigo).
acessibilidade_parada(p001, rampa).
acessibilidade_parada(p013, abrigo).
acessibilidade_parada(p013, piso_tatil).
acessibilidade_parada(p023, abrigo).
acessibilidade_parada(p023, rampa).
acessibilidade_parada(p027, abrigo).
acessibilidade_parada(p031, abrigo).
acessibilidade_parada(p031, rampa).
acessibilidade_parada(p038, abrigo).
acessibilidade_parada(p038, rampa).
acessibilidade_parada(p043, abrigo).
acessibilidade_parada(p043, rampa).
acessibilidade_parada(p049, abrigo).


% =============================================================
% CONSULTAS RÁPIDAS (referência de uso)
% =============================================================
%
%  Linhas que passam por uma parada:
%    ?- passa_por(L, p013).
%
%  Paradas de uma linha:
%    ?- passa_por('527', P), parada(P, Rua, Ref, Bairro, _).
%
%  Linhas que vão ao CI/UFPB:
%    ?- linha_vai_ao_ci(L), linha(L, Nome).
%
%  Baldeacao a partir de uma linha no TIV:
%    ?- ponto_de_baldeacao(p007, '510', Saida).
%
%  Linhas que operam à noite e vão ao CI:
%    ?- linha_vai_ao_ci(L), horario_ultima_viagem(L, bairro_centro, H), H @>= '22:00'.
%
%  Paradas com rampa de acessibilidade:
%    ?- acessibilidade_parada(P, rampa), parada(P, _, Ref, Bairro, _).
%
%  Linhas que operam só nos dias úteis:
%    ?- opera_nos_dias(L, uteis), linha(L, Nome).
%
%  Tipo universitário:
%    ?- tipo_linha(L, universitario), linha(L, Nome).
% =============================================================