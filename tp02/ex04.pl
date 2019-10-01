fibonacci(0, 1).
fibonacci(1, 1).
fibonacci(N, F) :-
    N > 1,
    N1 is N - 1, fibonacci(N1, F1), 
    N2 is N - 2, fibonacci(N2, F2),
    F is F1 + F2.


factorial(0, 1).
factorial(N, F) :-
    N > 0,
    N1 is N - 1, factorial(N1, F1),
    F is N * F1.


factorial2(N, F) :- factorial_2(N, F, 1).

factorial_2(1, F, F).
factorial_2(N, F, Acc) :- 
    N > 1,
    N1 is N - 1,
    Acc1 is Acc * N,
    factorial_2(N1, F, Acc1).