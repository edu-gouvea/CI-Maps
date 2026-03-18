% =============================================================
%  testes/testes.pl — Testes completos do GPS CI/UFPB
%
%  Como rodar (a partir da raiz do projeto CI-MAPS):
%    $ swipl testes/testes.pl
%
%  Categorias de teste:
%    1. Rotas diretas — cada linha que vai ao CI
%    2. Rotas com baldeacao — todas as combinacoes cadastradas
%    3. Cobertura de pontos — todos os pontos tem alguma rota
%    4. Integridade dos dados — linhas e baldeacoes consistentes
%    5. Pontos inexistentes — nao devem retornar rota
%    6. Destino ja e o CI — caso especial
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
%     Cada ponto cadastrado em uma linha direta ao CI
%     deve retornar rota_direta com a linha correta.
% =============================================================

testar_rotas_diretas :-
    secao("1. ROTAS DIRETAS"),

    % --- Linha 203 ---
    checar('[203] Terminal Quadramares tem rota direta',
        rota_direta('Terminal Quadramares - LIQ (Mangabeira VII)', '203')),
    checar('[203] Av. Hilton Souto Maior tem rota direta',
        rota_direta('Av. Hilton Souto Maior (Mangabeira VII)', '203')),
    checar('[203] Av. Vasco da Gama tem rota direta',
        rota_direta('Av. Vasco da Gama (Mangabeira)', '203')),
    checar('[203] Av. Josefa Taveira tem rota direta',
        rota_direta('Av. Josefa Taveira (Mangabeira)', '203')),
    checar('[203] Av. Benicio de Oliveira Lima tem rota direta',
        rota_direta('Av. Benicio de Oliveira Lima (Mangabeira)', '203')),
    checar('[203] Rua Jose Ananias tem rota direta',
        rota_direta('Rua José Ananias (José Américo)', '203')),
    checar('[203] Av. Campos Sales tem rota direta',
        rota_direta('Av. Campos Sales (Rangel)', '203')),
    checar('[203] Av. Cruz das Armas tem rota direta',
        rota_direta('Av. Cruz das Armas (Rangel)', '203')),
    checar('[203] Terminal Varadouro tem rota direta',
        rota_direta('Terminal de Integração Varadouro', '203')),
    checar('[203] Av. Sanhaua Marco Zero tem rota direta',
        rota_direta('Av. Sanhauá - Marco Zero (Centro)', '203')),

    % --- Linha 207 ---
    checar('[207] Av. Nossa Senhora da Penha tem rota direta',
        rota_direta('Av. Nossa Senhora da Penha (Penha)', '207')),
    checar('[207] Praia de Seixas tem rota direta',
        rota_direta('Praia de Seixas (Seixas)', '207')),
    checar('[207] Av. Hilton Souto Maior tem rota direta',
        rota_direta('Av. Hilton Souto Maior (Mangabeira VII)', '207')),
    checar('[207] Av. Vasco da Gama tem rota direta',
        rota_direta('Av. Vasco da Gama (Mangabeira)', '207')),
    checar('[207] Av. Campos Sales tem rota direta',
        rota_direta('Av. Campos Sales (Rangel)', '207')),
    checar('[207] Terminal Varadouro tem rota direta',
        rota_direta('Terminal de Integração Varadouro', '207')),

    % --- Linha 304 ---
    checar('[304] Terminal Quadramares tem rota direta',
        rota_direta('Terminal Quadramares - LIQ (Mangabeira VII)', '304')),
    checar('[304] Mangabeira Shopping tem rota direta',
        rota_direta('Mangabeira Shopping', '304')),
    checar('[304] Av. Epitacio Bancarios tem rota direta',
        rota_direta('Av. Epitácio Pessoa (Bancários)', '304')),
    checar('[304] Av. Joao Mauricio tem rota direta',
        rota_direta('Av. João Mauricio (Bancários)', '304')),
    checar('[304] UFPB Campus I tem rota direta',
        rota_direta('UFPB - Campus I (Castelo Branco)', '304')),
    checar('[304] Av. Dom Pedro II tem rota direta',
        rota_direta('Av. Dom Pedro II (Centro)', '304')),
    checar('[304] Terminal Varadouro tem rota direta',
        rota_direta('Terminal de Integração Varadouro', '304')),

    % --- Linha 508 ---
    checar('[508] Terminal Quadramares tem rota direta',
        rota_direta('Terminal Quadramares - LIQ (Mangabeira VII)', '508')),
    checar('[508] Mangabeira Shopping tem rota direta',
        rota_direta('Mangabeira Shopping', '508')),
    checar('[508] Av. Epitacio Bancarios tem rota direta',
        rota_direta('Av. Epitácio Pessoa (Bancários)', '508')),
    checar('[508] Av. Epitacio Tambau tem rota direta',
        rota_direta('Av. Epitácio Pessoa (Tambaú)', '508')),
    checar('[508] Orla de Tambau tem rota direta',
        rota_direta('Orla de Tambaú', '508')),
    checar('[508] Av. Epitacio Cabo Branco tem rota direta',
        rota_direta('Av. Epitácio Pessoa (Cabo Branco)', '508')),
    checar('[508] Praia de Jacarape tem rota direta',
        rota_direta('Praia de Jacarapé', '508')),
    checar('[508] Av. Nossa Senhora da Penha tem rota direta',
        rota_direta('Av. Nossa Senhora da Penha (Penha)', '508')),

    % --- Linha 520 ---
    checar('[520] Terminal Quadramares tem rota direta',
        rota_direta('Terminal Quadramares - LIQ (Mangabeira VII)', '520')),
    checar('[520] Mangabeira Shopping tem rota direta',
        rota_direta('Mangabeira Shopping', '520')),
    checar('[520] Av. Epitacio Bancarios tem rota direta',
        rota_direta('Av. Epitácio Pessoa (Bancários)', '520')),
    checar('[520] Av. Epitacio Tambau tem rota direta',
        rota_direta('Av. Epitácio Pessoa (Tambaú)', '520')),
    checar('[520] Altiplano Cabo Branco tem rota direta',
        rota_direta('Altiplano Cabo Branco', '520')),
    checar('[520] Terminal Varadouro tem rota direta',
        rota_direta('Terminal de Integração Varadouro', '520')).


% =============================================================
%  2. ROTAS COM BALDEACAO
%     Cada combinacao Origem -> Linha1 -> Ponto -> Linha2 -> CI
% =============================================================

testar_baldeacoes :-
    secao("2. ROTAS COM BALDEACAO"),

    % --- Via Terminal Varadouro (linha 301) ---
    checar('[301->203] Mangabeira IV via Varadouro',
        rota_com_baldeacao('Mangabeira IV', '301',
            'Terminal de Integração Varadouro', '203')),
    checar('[301->207] Mangabeira IV via Varadouro',
        rota_com_baldeacao('Mangabeira IV', '301',
            'Terminal de Integração Varadouro', '207')),
    checar('[301->203] UFPB Campus I via Varadouro',
        rota_com_baldeacao('UFPB - Campus I (Castelo Branco)', '301',
            'Terminal de Integração Varadouro', '203')),
    checar('[301->207] UFPB Campus I via Varadouro',
        rota_com_baldeacao('UFPB - Campus I (Castelo Branco)', '301',
            'Terminal de Integração Varadouro', '207')),
    checar('[301->203] Av. Dom Pedro II via Varadouro',
        rota_com_baldeacao('Av. Dom Pedro II (Centro)', '301',
            'Terminal de Integração Varadouro', '203')),
    checar('[301->207] Av. Dom Pedro II via Varadouro',
        rota_com_baldeacao('Av. Dom Pedro II (Centro)', '301',
            'Terminal de Integração Varadouro', '207')),

    % --- Via Terminal Varadouro (linha 302) ---
    checar('[302->203] Cidade Verde via Varadouro',
        rota_com_baldeacao('Cidade Verde', '302',
            'Terminal de Integração Varadouro', '203')),
    checar('[302->207] Cidade Verde via Varadouro',
        rota_com_baldeacao('Cidade Verde', '302',
            'Terminal de Integração Varadouro', '207')),
    checar('[302->203] UFPB Campus I via Varadouro',
        rota_com_baldeacao('UFPB - Campus I (Castelo Branco)', '302',
            'Terminal de Integração Varadouro', '203')),
    checar('[302->207] Av. Dom Pedro II via Varadouro',
        rota_com_baldeacao('Av. Dom Pedro II (Centro)', '302',
            'Terminal de Integração Varadouro', '207')),

    % --- Via Terminal Varadouro (linha 510) ---
    checar('[510->203] Val Paraiso via Varadouro',
        rota_com_baldeacao('Val Paraíso', '510',
            'Terminal de Integração Varadouro', '203')),
    checar('[510->207] Val Paraiso via Varadouro',
        rota_com_baldeacao('Val Paraíso', '510',
            'Terminal de Integração Varadouro', '207')),
    checar('[510->203] Orla de Tambau via Varadouro',
        rota_com_baldeacao('Orla de Tambaú', '510',
            'Terminal de Integração Varadouro', '203')),
    checar('[510->207] Av. Epitacio Tambau via Varadouro',
        rota_com_baldeacao('Av. Epitácio Pessoa (Tambaú)', '510',
            'Terminal de Integração Varadouro', '207')),

    % --- Via Bancarios (linha 521) ---
    checar('[521->304] Bessa via Bancarios',
        rota_com_baldeacao('Bessa', '521',
            'Av. Epitácio Pessoa (Bancários)', '304')),
    checar('[521->508] Bessa via Bancarios',
        rota_com_baldeacao('Bessa', '521',
            'Av. Epitácio Pessoa (Bancários)', '508')),
    checar('[521->520] Bessa via Bancarios',
        rota_com_baldeacao('Bessa', '521',
            'Av. Epitácio Pessoa (Bancários)', '520')),
    checar('[521->304] Manaira Shopping via Bancarios',
        rota_com_baldeacao('Manaíra Shopping', '521',
            'Av. Epitácio Pessoa (Bancários)', '304')),
    checar('[521->508] Manaira Shopping via Bancarios',
        rota_com_baldeacao('Manaíra Shopping', '521',
            'Av. Epitácio Pessoa (Bancários)', '508')),
    checar('[521->520] Manaira Shopping via Bancarios',
        rota_com_baldeacao('Manaíra Shopping', '521',
            'Av. Epitácio Pessoa (Bancários)', '520')),
    checar('[521->304] Av. Epitacio Manaira via Bancarios',
        rota_com_baldeacao('Av. Epitácio Pessoa (Manaíra)', '521',
            'Av. Epitácio Pessoa (Bancários)', '304')),
    checar('[521->508] Av. Epitacio Manaira via Bancarios',
        rota_com_baldeacao('Av. Epitácio Pessoa (Manaíra)', '521',
            'Av. Epitácio Pessoa (Bancários)', '508')),
    checar('[521->304] Av. Flavio Ribeiro Coutinho via Bancarios',
        rota_com_baldeacao('Av. Flávio Ribeiro Coutinho (Manaíra)', '521',
            'Av. Epitácio Pessoa (Bancários)', '304')),
    checar('[521->508] Av. Flavio Ribeiro Coutinho via Bancarios',
        rota_com_baldeacao('Av. Flávio Ribeiro Coutinho (Manaíra)', '521',
            'Av. Epitácio Pessoa (Bancários)', '508')),

    % --- Via Mangabeira Shopping (linha 517) ---
    checar('[517->304] Av. Epitacio Manaira via Mangabeira Shopping',
        rota_com_baldeacao('Av. Epitácio Pessoa (Manaíra)', '517',
            'Mangabeira Shopping', '304')),
    checar('[517->508] Av. Epitacio Manaira via Mangabeira Shopping',
        rota_com_baldeacao('Av. Epitácio Pessoa (Manaíra)', '517',
            'Mangabeira Shopping', '508')),
    checar('[517->520] Av. Epitacio Manaira via Mangabeira Shopping',
        rota_com_baldeacao('Av. Epitácio Pessoa (Manaíra)', '517',
            'Mangabeira Shopping', '520')),
    checar('[517->304] Av. Epitacio Tambau via Mangabeira Shopping',
        rota_com_baldeacao('Av. Epitácio Pessoa (Tambaú)', '517',
            'Mangabeira Shopping', '304')),
    checar('[517->508] Av. Epitacio Tambau via Mangabeira Shopping',
        rota_com_baldeacao('Av. Epitácio Pessoa (Tambaú)', '517',
            'Mangabeira Shopping', '508')),
    checar('[517->520] Av. Epitacio Tambau via Mangabeira Shopping',
        rota_com_baldeacao('Av. Epitácio Pessoa (Tambaú)', '517',
            'Mangabeira Shopping', '520')),
    checar('[517->304] Av. Epitacio Bancarios via Mangabeira Shopping',
        rota_com_baldeacao('Av. Epitácio Pessoa (Bancários)', '517',
            'Mangabeira Shopping', '304')),
    checar('[517->508] Av. Epitacio Bancarios via Mangabeira Shopping',
        rota_com_baldeacao('Av. Epitácio Pessoa (Bancários)', '517',
            'Mangabeira Shopping', '508')).


% =============================================================
%  3. COBERTURA DE PONTOS
%     Todo ponto em dados.pl deve ter ALGUMA rota ao CI.
% =============================================================

testar_cobertura :-
    secao("3. COBERTURA - todos os pontos tem rota"),
    findall(P, ponto_da_linha(P, _), Todos),
    sort(Todos, Pontos),
    forall(
        member(P, Pontos),
        checar(P, existe_rota(P))
    ).


% =============================================================
%  4. INTEGRIDADE DOS DADOS
%     Verificacoes de consistencia da base de conhecimento.
% =============================================================

testar_integridade :-
    secao("4. INTEGRIDADE DOS DADOS"),

    % Linhas diretas ao CI devem ter o terminal Quadramares cadastrado
    checar('[integridade] Linha 203 tem ponto no CI',
        ponto_da_linha('Terminal Quadramares - LIQ (Mangabeira VII)', '203')),
    checar('[integridade] Linha 207 tem ponto no CI',
        ponto_da_linha('Terminal Quadramares - LIQ (Mangabeira VII)', '207')),
    checar('[integridade] Linha 304 tem ponto no CI',
        ponto_da_linha('Terminal Quadramares - LIQ (Mangabeira VII)', '304')),
    checar('[integridade] Linha 508 tem ponto no CI',
        ponto_da_linha('Terminal Quadramares - LIQ (Mangabeira VII)', '508')),
    checar('[integridade] Linha 520 tem ponto no CI',
        ponto_da_linha('Terminal Quadramares - LIQ (Mangabeira VII)', '520')),

    % Pontos de baldeacao devem existir em dados.pl
    checar('[integridade] Terminal Varadouro existe como ponto',
        ponto_da_linha('Terminal de Integração Varadouro', _)),
    checar('[integridade] Bancarios existe como ponto',
        ponto_da_linha('Av. Epitácio Pessoa (Bancários)', _)),
    checar('[integridade] Mangabeira Shopping existe como ponto',
        ponto_da_linha('Mangabeira Shopping', _)),

    % A linha que chega ao ponto de baldeacao deve parar nesse ponto
    checar('[integridade] Linha 301 para no Terminal Varadouro',
        ponto_da_linha('Terminal de Integração Varadouro', '301')),
    checar('[integridade] Linha 302 para no Terminal Varadouro',
        ponto_da_linha('Terminal de Integração Varadouro', '302')),
    checar('[integridade] Linha 510 para no Terminal Varadouro',
        ponto_da_linha('Terminal de Integração Varadouro', '510')),
    checar('[integridade] Linha 521 para nos Bancarios',
        ponto_da_linha('Av. Epitácio Pessoa (Bancários)', '521')),
    checar('[integridade] Linha 517 para no Mangabeira Shopping',
        ponto_da_linha('Mangabeira Shopping', '517')),

    % Linhas de baldeacao NAO devem ir direto ao CI
    checar('[integridade] Linha 301 NAO vai ao CI diretamente',
        \+ linha_vai_ao_ci('301')),
    checar('[integridade] Linha 302 NAO vai ao CI diretamente',
        \+ linha_vai_ao_ci('302')),
    checar('[integridade] Linha 510 NAO vai ao CI diretamente',
        \+ linha_vai_ao_ci('510')),
    checar('[integridade] Linha 517 NAO vai ao CI diretamente',
        \+ linha_vai_ao_ci('517')),
    checar('[integridade] Linha 521 NAO vai ao CI diretamente',
        \+ linha_vai_ao_ci('521')),

    % Linhas diretas devem estar marcadas como linha_vai_ao_ci
    checar('[integridade] 203 marcada como vai ao CI', linha_vai_ao_ci('203')),
    checar('[integridade] 207 marcada como vai ao CI', linha_vai_ao_ci('207')),
    checar('[integridade] 304 marcada como vai ao CI', linha_vai_ao_ci('304')),
    checar('[integridade] 508 marcada como vai ao CI', linha_vai_ao_ci('508')),
    checar('[integridade] 520 marcada como vai ao CI', linha_vai_ao_ci('520')).


% =============================================================
%  5. PONTOS INEXISTENTES
%     Nomes incorretos ou inventados nao devem retornar rota.
% =============================================================

testar_inexistentes :-
    secao("5. PONTOS INEXISTENTES (devem falhar corretamente)"),

    checar('[inexistente] Rua inventada nao tem rota direta',
        \+ rota_direta('Rua Inventada 999', _)),
    checar('[inexistente] Rua inventada nao tem baldeacao',
        \+ rota_com_baldeacao('Rua Inventada 999', _, _, _)),
    checar('[inexistente] Rua inventada nao tem existe_rota',
        \+ existe_rota('Rua Inventada 999')),
    checar('[inexistente] Tambau sem acento nao funciona',
        \+ rota_direta('Orla de Tambau', _)),
    checar('[inexistente] Bancarios sem acento nao funciona',
        \+ rota_direta('Av. Epitacio Pessoa (Bancarios)', _)),
    checar('[inexistente] Linha inexistente nao vai ao CI',
        \+ linha_vai_ao_ci('999')),
    checar('[inexistente] Cidade de fora nao tem rota',
        \+ existe_rota('Recife')),
    checar('[inexistente] String vazia nao tem rota',
        \+ existe_rota('')).


% =============================================================
%  6. CASO ESPECIAL — ORIGEM JA E O CI
%     Quem ja esta no CI tambem encontra rota (trivialmente).
% =============================================================

testar_caso_ci :-
    secao("6. CASO ESPECIAL - origem ja e o CI"),

    checar('[CI] Terminal Quadramares tem rota direta pela 203',
        rota_direta('Terminal Quadramares - LIQ (Mangabeira VII)', '203')),
    checar('[CI] Terminal Quadramares tem rota direta pela 304',
        rota_direta('Terminal Quadramares - LIQ (Mangabeira VII)', '304')),
    checar('[CI] Terminal Quadramares tem rota direta pela 508',
        rota_direta('Terminal Quadramares - LIQ (Mangabeira VII)', '508')),
    checar('[CI] Terminal Quadramares tem rota direta pela 520',
        rota_direta('Terminal Quadramares - LIQ (Mangabeira VII)', '520')),
    checar('[CI] existe_rota funciona para o proprio CI',
        existe_rota('Terminal Quadramares - LIQ (Mangabeira VII)')).


% =============================================================
%  EXECUTAR TODOS OS TESTES
% =============================================================

:- format("~n==================================================~n"),
   format(" SUITE DE TESTES - GPS CI/UFPB~n"),
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