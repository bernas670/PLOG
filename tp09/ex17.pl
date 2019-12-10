:-use_module(library(clpfd)).


% 1 = Blue, 2 = Yellow, 3 = Green, 4 = Red


fila(L) :-
    length(L, 12), domain(L, 1, 4),

    % limit the number of cars by color
    global_cardinality(L, [1-3, 2-4, 3-2, 4-3]),

    % the first and last cars have the same color
    element(1, L, FLC), element(12, L, FLC),
    % the second and second to last cars have the same color
    element(2, L, SSC), element(11, L, SSC),
    % the fifth car is blue
    element(5, L, 1),

    % guarantee that all sets of three consecutive cars have distinct colors
    three(L),

    four(L, 1),

    labeling([], L).
    



% checks if all sets of three consecutive elements are distinct
% when the list has only two elements return true
three([_, _]).
three([A, B, C|T]) :-
    all_distinct([A, B, C]),
    three([B, C|T]).


four([_, _, _], 0).
four([A, B, C, D|T], N) :-
    four([B, C, D|T], NC),
    N #= NC + V,
    (A #= 2 #/\ B #= 3 #/\ C #= 4 #/\ D #= 1) #<=> V.
    
