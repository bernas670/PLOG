%PROBLEMAS DE OTIMIZAÇÃO
:-use_module(library(clpfd)).

%exercicio proposto na aula - otimização de eletrodomésticos

% eletrodomestico     %duração       %recurso
%       1                 16             2
%       2                  6             9
%       3                 13             3
%       4                  7             7
%       5                  5            10
%       6                 18             1                
%       7                  4            11

%recurso total =< 13
%objetivo: nunca ultrapassando o valor limite do recurso, otimizar o tempo para realizar todas as tarefas



schedule(Ss, End) :-
    Ss= [S1,S2,S3,S4,S5,S6,S7],
    Es= [E1,E2,E3,E4,E5,E6,E7],
    Tasks= [
        task(S1, 16, E1,   2,  1),
        task(S2, 6, E2,  9,  2),
        task(S3, 13, E3,  3,  3),
        task(S4,  7, E4,  7,  4),
        task(S5, 5, E5, 10,  5),
        task(S6, 18, E6, 1,  6),
        task(S7,  4, E7, 11,  7)
        ],
    domain(Ss, 1, 30),
    maximum(End, Es),
    cumulative(Tasks, [limit(13)]),
    labeling([minimize(End)], Ss).

%Exercicio da ficha de exercicios
%Prob2: CARTEIRO PREGUIÇOSO
%tem de acabar obrigatoriamente na casa nº6


soma_dist([X, Y | R], Dist):-
    Dist #= abs(X-Y) + RDist,
    soma_dist([Y| R], RDist).
soma_dist([_], 0).

carteiro_preguicoso(Visitas, D):-
    length(Visitas, 10),
    domain(Visitas, 1, 10),
    all_distinct(Visitas),
    element(10, Visitas, 6),
    circuit(Visitas), %visitar todos os nós exatamente um vez
    soma_dist(Visitas, D),
    labeling([maximize(D)], Visitas).