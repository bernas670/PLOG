:-use_module(library(clpfd)).

price(Price) :-
    A in 1..9,
    B in 0..9,

    Total #= A * 1000 + 670 + B,
    Total #= 72 * Price,

    labeling([], [A, B, Price]).
