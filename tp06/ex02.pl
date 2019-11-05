% Given a list and the name of a term with arity of 1,
% a list is returned with exactly the same elements but
% the ones that make the term true appear first
separate(Elements, Term, Result) :-
    sep(Elements, Term, List1, List2),
    append(List1, List2, Result).

% Base case
sep([], _, [], []).
% When the element makes the term true
sep([H|T], Term, [RH|RT], List2) :-
    G =.. [Term, H], G,
    !,
    RH is H,
    sep(T, Term, RT, List2).
% When the element makes the term false
sep([H|T], Term, List1, [RH|RT]) :-
    RH is H,
    sep(T, Term, List1, RT).


isZero(N) :-
    N =:= 0.