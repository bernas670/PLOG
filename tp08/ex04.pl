:-use_module(library(clpfd)).


%      S E N D
%  +   M O R E
% -------------
%    M O N E Y

% a)
send_more_money(Vars) :-
    Vars = [S, E, N, D, M, O, R, Y],
    domain(Vars, 0, 9),
    all_distinct(Vars),
    S #\= 0,
    M #= 1,
    M * 10000 + O * 1000 + N * 100 + E * 10 + Y #= S * 1000 + E * 100 + N * 10 + D + M * 1000 + O * 100 + R * 10 + E,
    labeling([], Vars).

better_smm(Vars) :-

    domain([C1, C2, C3])

