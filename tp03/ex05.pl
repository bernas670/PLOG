/* a) */
is_member(X, [X|_]) :- !.
is_member(X, [_|T]) :-
    is_member(X, T).

/* b) this is the definition of being a member of a list,
 because some list appended to another list which as X as its
 head definetely contains X */
member(X, L) :- 
    append(_, [X|_], L).
/*
member(2, [1,2,3]).
       A    B
append(_, [X|_], L) -> this is the definition

1) A = []       B = [1,2,3]      X = 1
2) A = []       B = [2,3]        X = 1,2
3) A = []       B = [3]          X = 1,2,3
*/

/* c) */
last(L, X) :-
    append(_, [X], L).

/* d) */
nth_elem([X|_], 1, X) :- !.
nth_elem([_|T], Index, Element) :-
    N is (Index - 1),
    nth_elem(T, N, Element).