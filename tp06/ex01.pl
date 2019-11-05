map2([], _, []).
map2([H|T], Term, [RH|RT]) :-
    G =.. [Term, H, RH], G,
    map2(T, Term, RT).


% Terms used in the examples
square(X, Y) :-
    Y is X * X.

duplicate(X, Y) :-
    Y is 2 * X.