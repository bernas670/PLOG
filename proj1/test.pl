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
testBoard3([ 
    [1, 1, 1, 1, 1, 0, 0, 0, 0, 0],
    [1, 1, 1, 1, 1, 0, 0, 0, 0, 0],
    [1, 1, 1, 1, 1, 0, 0, 0, 0, 0],
    [1, 1, 1, 1, 1, 0, 0, 0, 0, 0],
    [1, 1, 1, 1, 1, 0, 0, 0, 0, 0],
    [1, 1, 1, 1, 1, 0, 0, 0, 0, 0],
    [1, 1, 1, 1, 1, 0, 0, 0, 0, 0],
    [1, 1, 1, 1, 1, 0, 0, 0, 0, 0],
    [1, 1, 1, 1, 1, 0, 0, 0, 0, 0],
    [1, 1, 1, 1, 1, 0, 0, 0, 0, 0]]).

testAxialSymmetry :-
    testBoard1(Board),
    printBoard(Board),
    getBlockPositions(Board, 1, 3, 2, NewBoard, [], Pos),
    printBoard(NewBoard),
    write('old pos : '), write(Pos), nl,
    axialSymmetryPositions(Board, Pos, 'H', 2, NewPos),
    write('new pos : '), write(NewPos), nl.

testPos :- 
    testBoard2(Board),
    printBoard(Board),
    getBlockPositions(Board, 2, 1, 1, NewBoard, [], Pos),
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

% test the getChunk term
testChunk :- 
    testBoard2(Board),
    printBoard(Board),
    getChunk(Board, 'P', 1, Positions),
    nl, write(Positions), nl.

testAllChunks :-
    testBoard1(Board),
    printBoard(Board),
    getAllChunks(Board, 1, Chunks),
    nl, write(Chunks), nl.

testValidAxial :-
    testBoard3(Board),
    printBoard(Board),
    getAllChunks(Board, 1, Chunks),
    nl, write(Chunks), nl,
    getListItem(Chunks, 0, Chunk),
    findall(X, axialSymmetryPositions(Board, Chunk, _, _, X), Moves),
    nl, write(Moves), nl.

% test getBlockPositions(Board, Block, Row, Column, Positions)
testBlockPos :-
    testBoard2(Board),
    printBoard(Board),
    getBlockPositions(Board, 1, 0, 0, Positions),
    nl, write(Positions), nl.

testGenerateCoords :-
    testBoard2(Board),
    printBoard(Board),
    generateCoords(Board, Row, Col),
    write('row : '), write(Row), write(' col : '), write(Col), nl,
    setMatrixItem(Board, Row, Col, 3, NewBoard),
    printBoard(NewBoard).

testCastles :-
    initialBoard(Board),
    addCastles(Board, 'P', 'P', NewBoard),
    printBoard(NewBoard).

testStartGame :-
    startGame('P', 'P').

testRead :-
    read(Input),
    write(Input).


/*

A failed try at refactoring getBlockPositions :(

blockPos(Board, Block, Row, Column, Positions) :-
    % check if the coords are valid
    Row >= 0, Row =< 9, Column >= 0, Column =< 9,
    !,
    getMatrixItem(Board, Row, Column, Piece),
    Piece == Block,
    !,
    setMatrixItem(Board, Row, Column, 0, NewBoard),

    Row1 is Row + 1,            % up
    (blockPos(NewBoard, Block, Row1, Column, Positions1); true),
    Row2 is Row - 1,            % down
    (blockPos(NewBoard, Block, Row2, Column, Positions2); true),
    Column1 is Column + 1,      % right
    (blockPos(NewBoard, Block, Row, Column1, Positions3); true),
    Column2 is Column - 1,      % left
    (blockPos(NewBoard, Block, Row, Column2, Positions4); true)
*/
