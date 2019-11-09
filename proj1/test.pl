% This file only contains terms used to test the functionalities

testBoard1([
    [0, 0, 1, 0, 2, 1, 0, 2, 0, 3],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 1, 1, 2, 3, 0, 0, 0, 0],
    [0, 0, 1, 1, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 2, 2, 0, 0],
    [0, 0, 0, 3, 0, 0, 0, 3, 0, 0],
    [0, 0, 1, 1, 1, 1, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 2, 2, 0, 0],
    [0, 0, 0, 0, 0, 0, 2, 2, 0, 0]]).
testBoard2([ 
    [1, 1, 1, 0, 2, 1, 1, 2, 2, 3],
    [0, 1, 1, 0, 2, 1, 1, 2, 2, 0],
    [0, 0, 0, 0, 2, 1, 1, 1, 1, 0],
    [1, 1, 1, 1, 2, 3, 0, 2, 2, 0],
    [1, 1, 1, 1, 0, 0, 0, 2, 2, 0],
    [0, 0, 2, 2, 0, 2, 2, 2, 0, 0],
    [2, 2, 2, 3, 0, 0, 0, 3, 0, 0],
    [2, 2, 1, 1, 1, 1, 1, 1, 1, 1],
    [2, 2, 2, 2, 1, 1, 2, 2, 0, 0],
    [2, 2, 2, 2, 1, 1, 2, 2, 0, 0]]).

testAxialSymmetry :-
    testBoard1(Board),
    printBoard(Board),
    getBlockPositions(Board, 1, 3, 2, NewBoard, [], Pos),
    printBoard(NewBoard),
    write(Pos), nl,
    axialSymmetryPositions(Board, Pos, 'H', 2, NewPos),
    write(NewPos), nl.

testPos :- 
    testBoard2(Board),
    printBoard(Board),
    getBlockPositions(Board, 2, 8, 2, NewBoard, [], Pos),
    write('Result'), nl,
    printBoard(NewBoard),
    write(Pos).

testValue:-
    testBoard2(Board),
    printBoard(Board),
    gameOver(Board,Winner),
    write(Winner), nl.

testPrint :- 
    initialBoard(Board), 
    printBoard(Board).

testBoardUpdate :-
    initialBoard(Board),
    printBoard(Board),
    updateBoard(Board, [[0,1],[0,2],[1,1],[1,2]], 1, NewBoard),
    printBoard(NewBoard).
