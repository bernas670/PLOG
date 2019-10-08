
/* this is the definition of being a member of a list,
 because some list appended to another list which as X as its
 head definetely contains X */
member(X, L) :- append(_, [X|_], L).

/*
member(2, [1,2,3]).
       A    B
append(_, [X|_], L) -> this is the definition


1) A = []       B = [1,2,3]      X = 1
2) A = []       B = [2,3]        X = 1,2
3) A = []       B = [3]          X = 1,2,3

*/