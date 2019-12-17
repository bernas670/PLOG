:-use_module(library(clpfd)).

:- include('puzzles.pl').



solve(Col, Row, Vars) :-
    length(Col, ColSize),
    length(Row, RowSize),

    Area is ColSize * RowSize,
    length(Board, Area),    
    domain(Board, 0, 1),

    


test(Board) :-
    puzzle1(Col, Row),
    solve(Col, Row, Board).