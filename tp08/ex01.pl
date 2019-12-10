:-use_module(library(clpfd)).

magic(Square, Side) :-
    Area is Side * Side,
    length(Square, Area),
    domain(Square, 1, Area),
    all_distinct(Square),
    write('error here'), nl,
    write(Square), nl,
    check_sums(Square, Side),
    write('error here'), nl,
    labeling([], Square).

check_sums(List, NumElems) :-
    selectn(NumElems, List, NewList, RestList),
    sum_list(NewList, ListSum),
    write('Sum : '), write(ListSum), nl,
    check_sums(RestList, NumElems, ListSum).
check_sums([], _, _).
check_sums(List, NumElems, Sum) :-
    selectn(NumElems, List, NewList, RestList),
    sum_list(NewList, ListSum),
    write('Sum : '), write(ListSum), nl,
    ListSum #= Sum,
    check_sums(RestList, NumElems, Sum).    

selectn(0, List, [], List).
selectn(N, [HList|TList], [HList|TNew], Rest) :-
    NN is N - 1,
    get_first_n(NN, TList, TNew, Rest).

sum_list([], 0).
sum_list([H|T], Sum) :-
    sum_list(T, NSum),
    Sum is NSum + H.