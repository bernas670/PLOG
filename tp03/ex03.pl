/* base case : when an empty list is appended to another list,
 the latter stays the same */
myappend([], L, L).
/* the recursive call places the head of the L1 on the head of L3,
 at the end (when the base case occurs) */
myappend([X|L1], L2, [X|L3]) :-
    myappend(L1, L2, L3).


/*
1) myappend([1,2], [3,4], X)   X = [1|...]
2) myappend([2], [3,4], X)     X = [2|...]
3) myappend([], [3,4], X)      X = [3,4]
2)                             X = [2,3,4]
1)                             X = [1,2,3,4]
*/