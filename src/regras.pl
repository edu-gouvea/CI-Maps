% =============================================================
%  regras.pl — Regras de inferência do GPS CI/UFPB
%  Contém toda a lógica de busca de rotas
% =============================================================

:- consult(dados).

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

