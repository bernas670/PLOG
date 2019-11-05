% a)
functor2(Term, F, Arity) :-
    Term =.. [F|Args],
    length(Args, Arity).

% b)
arg2(N, Term, Arg) :-
    Term =.. [_|Arguments],
    position(N, Arguments, Arg).

% Get the element at the Nth position
position(1, [X|_], X).
position(N, [_|T], X) :-
    N1 is N - 1,
    position(N, T, X).