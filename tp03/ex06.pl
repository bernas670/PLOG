/* a) */
delete_one(X, List, Result) :-
    append(L1, [X|L2], List),
    append(L1, L2, Result).

/* b) */
delete_all(_, [], []).
delete_all(X, [X|T], Result) :-
    delete_all(X, T, Result).
delete_all(X, [H|T], [H|R]) :-
    dif(X, H),
    delete_all(X, T, R).

/* c) */
delete_all_list([H|T], List, Result) :-
    delete_all(H, List, Result),
    delete_all_list(T, Result, Result).