% =============================================================
%  testes/testes.pl — Testes completos do GPS CI/UFPB
%  Versão 2.0 — Atualizado para o modelo de dados v2
%
%  Como rodar (a partir da raiz do projeto CI-MAPS):
%    $ swipl testes/testes.pl
%
%  Categorias de teste:
%    1. Rotas diretas — cada linha que vai ao CI
%    2. Rotas com baldeacao — todas as combinacoes cadastradas
%    3. Cobertura de paradas — todas as paradas tem alguma rota
%    4. Integridade dos dados — linhas e baldeacoes consistentes
%    5. IDs inexistentes — nao devem retornar rota
%    6. Destino ja e o CI — caso especial (p013 / p014)
% =============================================================

:- consult('src/regras').

% -------------------------------------------------------------
%  INFRAESTRUTURA DE TESTES
% -------------------------------------------------------------
:- dynamic contagem_ok/1.
:- dynamic contagem_falhou/1.
contagem_ok(0).
contagem_falhou(0).

passar(Nome) :-
    retract(contagem_ok(N)), N1 is N + 1, assert(contagem_ok(N1)),
    format("  [OK]     ~w~n", [Nome]).

falhar(Nome) :-
    retract(contagem_falhou(N)), N1 is N + 1, assert(contagem_falhou(N1)),
    format("  [FALHOU] ~w~n", [Nome]).

checar(Nome, Goal) :-
    ( call(Goal) -> passar(Nome) ; falhar(Nome) ).

secao(Titulo) :-
    format("~n--------------------------------------------------~n"),
    format(" ~w~n", [Titulo]),
    format("--------------------------------------------------~n").


% =============================================================
%  1. ROTAS DIRETAS
%     Cada parada de uma linha direta ao CI deve retornar
%     rota_direta com o codigo correto da linha.
%
%  Mapeamento de IDs (dados v2):
%    p001 — Terminal Distrito Mangabeira
%    p002 — Av. Hilton Souto Maior / Shopping Mangabeira
%    p003 — Rua Josefa Taveira (Mangabeira)
%    p004 — Rua Benicio de Oliveira Lima (Mangabeira)
%    p005 — Av. Vasco da Gama (Rangel)
%    p006 — Parque Solon de Lucena / Lagoa
%    p009 — Av. Nossa Senhora da Penha (Penha)
%    p010 — Rodovia PB-008 / Seixas
%    p011 — Vila dos Pescadores (Penha)
%    p012 — Av. da Falesia (Penha/Seixas)
%    p013 — HU / Girador UFPB (Bancarios)
%    p014 — Entorno UFPB / Bancarios
%    p015 — Av. Dom Pedro II (Castelo Branco)
%    p016 — Av. Nossa Senhora de Fatima (Torre)
%    p017 — Av. Camilo de Holanda (Centro)
%    p019 — Av. Epitacio Pessoa (Tambau)
%    p025 — Av. Gov Antonio da Silva Mariz (Altiplano)
%    p026 — Av. Joao Cirilo da Silva (Altiplano)
%    p027 — Terminal Altiplano
%    p028 — Av. Mons Odilon Coutinho (Altiplano)
%    p031 — Terminal Patricia Tomaz (Cidade Verde)
%    p033 — Av. Jatoba (Cidade Verde)
%    p034 — Rua Walfredo Macedo Brandao (Bancarios)
%    p035 — Rua Banc Sergio Guerra (Bancarios)
%    p036 — Av. Pres Castelo Branco
%    p052 — Rua Diogenes Chianca (Mangabeira/Geisel)
%    p053 — Rua Jose Firmino Ferreira (Bancarios)
%    p054 — Av. Dom Pedro II / viaduto (Castelo Branco Norte)
%    p055 — Av. Dom Pedro II / Zoobotanico (Castelo Branco)
%    p056 — Av. Dom Pedro II / Campus V UFPB
%    p057 — Av. Epitacio Pessoa / Busto Epitacio (Tambauzinho)
%    p058 — Rua Eng Jose Rufino Rodrigues (Bancarios)
%    p059 — Via Expressa Padre Ze / Girador UFPB (linha 527)
%    p060 — Av. Dom Pedro II / trecho 527 (Castelo Branco)
% =============================================================

testar_rotas_diretas :-
    secao("1. ROTAS DIRETAS"),

    % --- Linha 301 — Mangabeira Pedro II Direto ---
    checar('[301] Terminal Mangabeira (p001) tem rota direta',
        rota_direta(p001, '301')),
    checar('[301] Josefa Taveira (p003) tem rota direta',
        rota_direta(p003, '301')),
    checar('[301] Corredor Bancarios p034 tem rota direta',
        rota_direta(p034, '301')),
    checar('[301] Corredor Bancarios p035 tem rota direta',
        rota_direta(p035, '301')),
    checar('[301] Entorno UFPB p014 tem rota direta',
        rota_direta(p014, '301')),
    checar('[301] Girador UFPB p013 tem rota direta',
        rota_direta(p013, '301')),
    checar('[301] Av. Dom Pedro II p015 tem rota direta',
        rota_direta(p015, '301')),
    checar('[301] Lagoa p006 tem rota direta',
        rota_direta(p006, '301')),
    checar('[301] TIV p007 tem rota direta',
        rota_direta(p007, '301')),

    % --- Linha 302 — Cidade Verde ---
    checar('[302] Terminal Patricia Tomaz p031 tem rota direta',
        rota_direta(p031, '302')),
    checar('[302] Av. Jatoba p033 tem rota direta',
        rota_direta(p033, '302')),
    checar('[302] Girador UFPB p013 tem rota direta',
        rota_direta(p013, '302')),
    checar('[302] Entorno UFPB p014 tem rota direta',
        rota_direta(p014, '302')),
    checar('[302] Av. Dom Pedro II p015 tem rota direta',
        rota_direta(p015, '302')),
    checar('[302] TIV p007 tem rota direta',
        rota_direta(p007, '302')),

    % --- Linha 303 — Cidade Verde / Pedro II [v2] ---
    checar('[303] Terminal Patricia Tomaz p031 tem rota direta',
        rota_direta(p031, '303')),
    checar('[303] Girador UFPB p013 tem rota direta',
        rota_direta(p013, '303')),
    checar('[303] Dom Pedro II viaduto p054 tem rota direta',
        rota_direta(p054, '303')),
    checar('[303] Dom Pedro II Zoobotanico p055 tem rota direta',
        rota_direta(p055, '303')),
    checar('[303] Dom Pedro II Campus V p056 tem rota direta',
        rota_direta(p056, '303')),
    checar('[303] TIV p007 tem rota direta',
        rota_direta(p007, '303')),

    % --- Linha 304 — Bancarios / Castelo Branco - Pedro II ---
    checar('[304] Terminal Mangabeira p001 tem rota direta',
        rota_direta(p001, '304')),
    checar('[304] Hilton Souto Maior p002 tem rota direta',
        rota_direta(p002, '304')),
    checar('[304] Entorno UFPB p014 tem rota direta',
        rota_direta(p014, '304')),
    checar('[304] Girador UFPB p013 tem rota direta',
        rota_direta(p013, '304')),
    checar('[304] Dom Pedro II viaduto p054 tem rota direta',
        rota_direta(p054, '304')),
    checar('[304] Dom Pedro II Zoobotanico p055 tem rota direta',
        rota_direta(p055, '304')),
    checar('[304] Dom Pedro II Campus V p056 tem rota direta',
        rota_direta(p056, '304')),
    checar('[304] TIV p007 tem rota direta',
        rota_direta(p007, '304')),

    % --- Linha 517 — Mangabeira Cidade Verde Epitacio ---
    checar('[517] Terminal Patricia Tomaz p031 tem rota direta',
        rota_direta(p031, '517')),
    checar('[517] Girador UFPB p013 tem rota direta',
        rota_direta(p013, '517')),
    checar('[517] Entorno UFPB p014 tem rota direta',
        rota_direta(p014, '517')),
    checar('[517] Av. Epitacio p019 tem rota direta',
        rota_direta(p019, '517')),
    checar('[517] Lagoa p006 tem rota direta',
        rota_direta(p006, '517')),

    % --- Linha 518 — Bancarios / Epitacio [v2] ---
    checar('[518] Girador UFPB p013 tem rota direta',
        rota_direta(p013, '518')),
    checar('[518] Entorno UFPB p014 tem rota direta',
        rota_direta(p014, '518')),
    checar('[518] Busto Epitacio p057 tem rota direta',
        rota_direta(p057, '518')),
    checar('[518] Acesso Bancarios p058 tem rota direta',
        rota_direta(p058, '518')),
    checar('[518] Av. Epitacio p019 tem rota direta',
        rota_direta(p019, '518')),
    checar('[518] TIV p007 tem rota direta',
        rota_direta(p007, '518')),

    % --- Linha 523 — Colinas do Sul / Epitacio ---
    checar('[523] Girador UFPB p013 tem rota direta',
        rota_direta(p013, '523')),
    checar('[523] Entorno UFPB p014 tem rota direta',
        rota_direta(p014, '523')),
    checar('[523] Av. Epitacio p019 tem rota direta',
        rota_direta(p019, '523')),
    checar('[523] Lagoa p006 tem rota direta',
        rota_direta(p006, '523')),

    % --- Linha 527 — Castelo Branco / Epitacio [v2] ---
    checar('[527] Via Expressa Padre Ze p059 tem rota direta',
        rota_direta(p059, '527')),
    checar('[527] Girador UFPB p013 tem rota direta',
        rota_direta(p013, '527')),
    checar('[527] Entorno UFPB p014 tem rota direta',
        rota_direta(p014, '527')),
    checar('[527] Dom Pedro II trecho 527 p060 tem rota direta',
        rota_direta(p060, '527')),
    checar('[527] Av. Epitacio p019 tem rota direta',
        rota_direta(p019, '527')),
    checar('[527] TIV p007 tem rota direta',
        rota_direta(p007, '527')).


% =============================================================
%  2. ROTAS COM BALDEACAO
%     Cada combinacao Origem -> Linha1 -> IdBaldeacao -> Linha2 -> CI
% =============================================================

testar_baldeacoes :-
    secao("2. ROTAS COM BALDEACAO"),

    % --- Via TIV p007 (linha 101) ---
    checar('[101->301] Colinas (p038) via TIV',
        rota_com_baldeacao(p038, '101', p007, '301')),
    checar('[101->302] Colinas (p038) via TIV',
        rota_com_baldeacao(p038, '101', p007, '302')),
    checar('[101->303] Colinas (p038) via TIV',
        rota_com_baldeacao(p038, '101', p007, '303')),
    checar('[101->304] Colinas (p038) via TIV',
        rota_com_baldeacao(p038, '101', p007, '304')),
    checar('[101->301] Vasco da Gama (p005) via TIV',
        rota_com_baldeacao(p005, '101', p007, '301')),
    checar('[101->304] Jaguaribe (p042) via TIV',
        rota_com_baldeacao(p042, '101', p007, '304')),

    % --- Via TIV p007 (linha 402) ---
    checar('[402->301] Terminal Miramar (p043) via TIV',
        rota_com_baldeacao(p043, '402', p007, '301')),
    checar('[402->302] Terminal Miramar (p043) via TIV',
        rota_com_baldeacao(p043, '402', p007, '302')),
    checar('[402->303] Terminal Miramar (p043) via TIV',
        rota_com_baldeacao(p043, '402', p007, '303')),
    checar('[402->304] Praca Tito Silva (p037) via TIV',
        rota_com_baldeacao(p037, '402', p007, '304')),
    checar('[402->301] Av. Juarez Tavora (p045) via TIV',
        rota_com_baldeacao(p045, '402', p007, '301')),

    % --- Via TIV p007 (linha 510) ---
    checar('[510->301] Terminal Val Paraiso (p024) via TIV',
        rota_com_baldeacao(p024, '510', p007, '301')),
    checar('[510->302] Terminal Val Paraiso (p024) via TIV',
        rota_com_baldeacao(p024, '510', p007, '302')),
    checar('[510->303] Terminal Val Paraiso (p024) via TIV',
        rota_com_baldeacao(p024, '510', p007, '303')),
    checar('[510->304] Terminal Val Paraiso (p024) via TIV',
        rota_com_baldeacao(p024, '510', p007, '304')),
    checar('[510->301] Av. Joao Mauricio p022 via TIV',
        rota_com_baldeacao(p022, '510', p007, '301')),
    checar('[510->304] Largo Tambau p066 via TIV',
        rota_com_baldeacao(p066, '510', p007, '304')),

    % --- Via TIV p007 (linha 508) ---
    checar('[508->301] Penha (p009) via TIV',
        rota_com_baldeacao(p009, '508', p007, '301')),
    checar('[508->302] Penha (p009) via TIV',
        rota_com_baldeacao(p009, '508', p007, '302')),
    checar('[508->303] Orla Penha p012 via TIV',
        rota_com_baldeacao(p012, '508', p007, '303')),
    checar('[508->304] Portal do Sol p063 via TIV',
        rota_com_baldeacao(p063, '508', p007, '304')),

    % --- Via TIV p007 (linha 518) [v2] ---
    checar('[518->301] Girador UFPB p013 via TIV',
        rota_com_baldeacao(p013, '518', p007, '301')),
    checar('[518->302] Busto Epitacio p057 via TIV',
        rota_com_baldeacao(p057, '518', p007, '302')),

    % --- Via Epitacio/Praca Independencia p018 (linha 510) ---
    checar('[510->517] Val Paraiso (p024) via p018',
        rota_com_baldeacao(p024, '510', p018, '517')),
    checar('[510->523] Val Paraiso (p024) via p018',
        rota_com_baldeacao(p024, '510', p018, '523')),
    checar('[510->518] Val Paraiso (p024) via p018',
        rota_com_baldeacao(p024, '510', p018, '518')),
    checar('[510->527] Val Paraiso (p024) via p018',
        rota_com_baldeacao(p024, '510', p018, '527')),

    % --- Via Epitacio/Praca Independencia p018 (linha 521) ---
    checar('[521->517] Terminal Bessa (p023) via p018',
        rota_com_baldeacao(p023, '521', p018, '517')),
    checar('[521->523] Terminal Bessa (p023) via p018',
        rota_com_baldeacao(p023, '521', p018, '523')),
    checar('[521->518] Terminal Bessa (p023) via p018',
        rota_com_baldeacao(p023, '521', p018, '518')),
    checar('[521->527] Terminal Bessa (p023) via p018',
        rota_com_baldeacao(p023, '521', p018, '527')),
    checar('[521->517] Manaira p021 via p018',
        rota_com_baldeacao(p021, '521', p018, '517')),
    checar('[521->523] Av. Gov Flavio p022 via p018',
        rota_com_baldeacao(p022, '521', p018, '523')),

    % --- Via Epitacio/Praca Independencia p018 (linha 508) ---
    checar('[508->517] Penha (p009) via p018',
        rota_com_baldeacao(p009, '508', p018, '517')),
    checar('[508->523] Orla Penha p012 via p018',
        rota_com_baldeacao(p012, '508', p018, '523')),

    % --- Via Girador UFPB p013 (linha 517) ---
    checar('[517->301] Av. Epitacio p019 via p013',
        rota_com_baldeacao(p019, '517', p013, '301')),
    checar('[517->302] Av. Jatoba p033 via p013',
        rota_com_baldeacao(p033, '517', p013, '302')),
    checar('[517->303] Av. Castelo Branco p036 via p013',
        rota_com_baldeacao(p036, '517', p013, '303')),

    % --- Via Girador UFPB p013 (linha 523) ---
    checar('[523->301] Colinas II p049 via p013',
        rota_com_baldeacao(p049, '523', p013, '301')),
    checar('[523->302] Geisel p069 via p013',
        rota_com_baldeacao(p069, '523', p013, '302')),
    checar('[523->303] Colinas p039 via p013',
        rota_com_baldeacao(p039, '523', p013, '303')),

    % --- Via Girador UFPB p013 (linha 518 <-> 527) [v2] ---
    checar('[518->527] Busto Epitacio p057 via p013',
        rota_com_baldeacao(p057, '518', p013, '527')),
    checar('[527->518] Via Expressa Padre Ze p059 via p013',
        rota_com_baldeacao(p059, '527', p013, '518')),

    % --- Via Hilton Souto Maior p002 ---
    checar('[203->520] Terminal Mangabeira p001 via p002',
        rota_com_baldeacao(p001, '203', p002, '520')),
    checar('[203->508] Terminal Mangabeira p001 via p002',
        rota_com_baldeacao(p001, '203', p002, '508')),
    checar('[207->520] Penha p009 via p002',
        rota_com_baldeacao(p009, '207', p002, '520')),
    checar('[207->508] Penha p009 via p002',
        rota_com_baldeacao(p009, '207', p002, '508')),
    checar('[302->520] Patricia Tomaz p031 via p002',
        rota_com_baldeacao(p031, '302', p002, '520')),
    checar('[304->520] Terminal Mangabeira p001 via p002',
        rota_com_baldeacao(p001, '304', p002, '520')).


% =============================================================
%  3. COBERTURA DE PARADAS
%     Toda parada cadastrada em passa_por/2 deve ter alguma rota.
%     Paradas puramente de retorno/controle (p029) são exceção
%     justificada e marcadas explicitamente.
% =============================================================

testar_cobertura :-
    secao("3. COBERTURA - todas as paradas tem rota"),
    % Paradas de controle/retorno sem rota ao CI (esperado):
    PararasExcecao = [p029],
    findall(Id, passa_por(_, Id), Todos),
    sort(Todos, Paradas),
    forall(
        (member(Id, Paradas), \+ member(Id, PararasExcecao)),
        checar(Id, existe_rota(Id))
    ),
    forall(
        member(Id, PararasExcecao),
        checar(Id, \+ existe_rota(Id))
    ).


% =============================================================
%  4. INTEGRIDADE DOS DADOS
%     Verificacoes de consistencia da base de conhecimento.
% =============================================================

testar_integridade :-
    secao("4. INTEGRIDADE DOS DADOS"),

    % Linhas que vao ao CI devem ter paradas cadastradas
    checar('[integridade] Linha 301 tem paradas em passa_por', passa_por('301', _)),
    checar('[integridade] Linha 302 tem paradas em passa_por', passa_por('302', _)),
    checar('[integridade] Linha 303 tem paradas em passa_por', passa_por('303', _)),
    checar('[integridade] Linha 304 tem paradas em passa_por', passa_por('304', _)),
    checar('[integridade] Linha 517 tem paradas em passa_por', passa_por('517', _)),
    checar('[integridade] Linha 518 tem paradas em passa_por', passa_por('518', _)),
    checar('[integridade] Linha 523 tem paradas em passa_por', passa_por('523', _)),
    checar('[integridade] Linha 527 tem paradas em passa_por', passa_por('527', _)),

    % Pontos de baldeacao devem existir como parada
    checar('[integridade] TIV p007 existe como parada', parada(p007, _, _, _, _)),
    checar('[integridade] Praca Independencia p018 existe como parada', parada(p018, _, _, _, _)),
    checar('[integridade] Girador UFPB p013 existe como parada', parada(p013, _, _, _, _)),
    checar('[integridade] Hilton Souto Maior p002 existe como parada', parada(p002, _, _, _, _)),
    checar('[integridade] Lagoa p006 existe como parada', parada(p006, _, _, _, _)),

    % A linha que chega ao ponto de baldeacao deve parar nesse ponto
    checar('[integridade] Linha 101 para no TIV p007', passa_por('101', p007)),
    checar('[integridade] Linha 402 para no TIV p007', passa_por('402', p007)),
    checar('[integridade] Linha 510 para no TIV p007', passa_por('510', p007)),
    checar('[integridade] Linha 508 para no TIV p007', passa_por('508', p007)),
    checar('[integridade] Linha 521 para na Praca Independencia p018', passa_por('521', p018)),
    checar('[integridade] Linha 510 para na Praca Independencia p018', passa_por('510', p018)),
    checar('[integridade] Linha 517 para no Girador UFPB p013', passa_por('517', p013)),
    checar('[integridade] Linha 523 para no Girador UFPB p013', passa_por('523', p013)),
    checar('[integridade] Linha 203 para em Hilton Souto Maior p002', passa_por('203', p002)),
    checar('[integridade] Linha 207 para em Hilton Souto Maior p002', passa_por('207', p002)),

    % Linhas de baldeacao NAO devem ir direto ao CI
    checar('[integridade] Linha 101 NAO vai ao CI diretamente', \+ linha_vai_ao_ci('101')),
    checar('[integridade] Linha 402 NAO vai ao CI diretamente', \+ linha_vai_ao_ci('402')),
    checar('[integridade] Linha 510 NAO vai ao CI diretamente', \+ linha_vai_ao_ci('510')),
    checar('[integridade] Linha 521 NAO vai ao CI diretamente', \+ linha_vai_ao_ci('521')),
    checar('[integridade] Linha 203 NAO vai ao CI diretamente', \+ linha_vai_ao_ci('203')),
    checar('[integridade] Linha 207 NAO vai ao CI diretamente', \+ linha_vai_ao_ci('207')),

    % Linhas diretas devem estar marcadas como linha_vai_ao_ci
    checar('[integridade] 301 marcada como vai ao CI', linha_vai_ao_ci('301')),
    checar('[integridade] 302 marcada como vai ao CI', linha_vai_ao_ci('302')),
    checar('[integridade] 303 marcada como vai ao CI', linha_vai_ao_ci('303')),
    checar('[integridade] 304 marcada como vai ao CI', linha_vai_ao_ci('304')),
    checar('[integridade] 517 marcada como vai ao CI', linha_vai_ao_ci('517')),
    checar('[integridade] 518 marcada como vai ao CI', linha_vai_ao_ci('518')),
    checar('[integridade] 523 marcada como vai ao CI', linha_vai_ao_ci('523')),
    checar('[integridade] 527 marcada como vai ao CI', linha_vai_ao_ci('527')),

    % nome_linha/2 funciona para todas as linhas cadastradas
    checar('[integridade] nome_linha funciona para 301', nome_linha('301', _)),
    checar('[integridade] nome_linha funciona para 518', nome_linha('518', _)),
    checar('[integridade] nome_linha funciona para 527', nome_linha('527', _)),

    % parada_info/2 funciona para paradas chave
    checar('[integridade] parada_info funciona para p013', parada_info(p013, _)),
    checar('[integridade] parada_info funciona para p007', parada_info(p007, _)).


% =============================================================
%  5. IDs INEXISTENTES
%     IDs incorretos ou inventados nao devem retornar rota.
% =============================================================

testar_inexistentes :-
    secao("5. IDs INEXISTENTES (devem falhar corretamente)"),

    checar('[inexistente] p999 nao tem rota direta',
        \+ rota_direta(p999, _)),
    checar('[inexistente] p999 nao tem baldeacao',
        \+ rota_com_baldeacao(p999, _, _, _)),
    checar('[inexistente] p999 nao tem existe_rota',
        \+ existe_rota(p999)),
    checar('[inexistente] atom inventado nao tem rota',
        \+ existe_rota(paradaInventada)),
    checar('[inexistente] string antiga nao funciona como ID',
        \+ rota_direta('Orla de Tambaú', _)),
    checar('[inexistente] string antiga nao funciona como ID 2',
        \+ rota_direta('Av. Epitácio Pessoa (Bancários)', _)),
    checar('[inexistente] linha inexistente nao vai ao CI',
        \+ linha_vai_ao_ci('999')),
    checar('[inexistente] linha antiga 508 nao vai ao CI',
        \+ linha_vai_ao_ci('508')),
    checar('[inexistente] linha antiga 520 nao vai ao CI',
        \+ linha_vai_ao_ci('520')).


% =============================================================
%  6. CASO ESPECIAL — ORIGEM JA E O CI
%     Paradas do entorno do CI (p013, p014) devem encontrar
%     rota direta (trivialmente, pois já estão no destino).
% =============================================================

testar_caso_ci :-
    secao("6. CASO ESPECIAL - origem ja e o entorno do CI"),

    checar('[CI] Girador UFPB p013 tem rota direta pela 301',
        rota_direta(p013, '301')),
    checar('[CI] Girador UFPB p013 tem rota direta pela 302',
        rota_direta(p013, '302')),
    checar('[CI] Girador UFPB p013 tem rota direta pela 303',
        rota_direta(p013, '303')),
    checar('[CI] Girador UFPB p013 tem rota direta pela 304',
        rota_direta(p013, '304')),
    checar('[CI] Girador UFPB p013 tem rota direta pela 517',
        rota_direta(p013, '517')),
    checar('[CI] Girador UFPB p013 tem rota direta pela 518',
        rota_direta(p013, '518')),
    checar('[CI] Girador UFPB p013 tem rota direta pela 527',
        rota_direta(p013, '527')),
    checar('[CI] Entorno UFPB p014 tem rota direta pela 301',
        rota_direta(p014, '301')),
    checar('[CI] Entorno UFPB p014 tem rota direta pela 304',
        rota_direta(p014, '304')),
    checar('[CI] existe_rota funciona para p013',
        existe_rota(p013)),
    checar('[CI] existe_rota funciona para p014',
        existe_rota(p014)).


% =============================================================
%  EXECUTAR TODOS OS TESTES
% =============================================================

:- format("~n==================================================~n"),
   format(" SUITE DE TESTES - GPS CI/UFPB  v2~n"),
   format("==================================================~n"),
   testar_rotas_diretas,
   testar_baldeacoes,
   testar_cobertura,
   testar_integridade,
   testar_inexistentes,
   testar_caso_ci,
   contagem_ok(OK),
   contagem_falhou(F),
   Total is OK + F,
   format("~n==================================================~n"),
   format(" RESULTADO FINAL~n"),
   format("==================================================~n"),
   format(" Passou : ~w testes~n", [OK]),
   format(" Falhou : ~w testes~n", [F]),
   format(" Total  : ~w testes~n", [Total]),
   format("==================================================~n~n"),
   halt.