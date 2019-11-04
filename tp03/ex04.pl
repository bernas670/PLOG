inverter(Lista, ListaInvertida) :-
    rev(Lista, [], ListaInvertida).

rev([], R, R).
rev([H|T], S, R) :-
    rev(T, [H|S], R).
