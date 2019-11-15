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
testBoard4([
    [0, 0, 1, 0, 1, 1, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 1, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 1, 1, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 1, 1, 0, 0],
    [0, 0, 0, 0, 0, 0, 1, 1, 0, 0],
    [0, 0, 1, 1, 1, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]]).
testBoard5([ 
    [0, 0, 0, 0, 0, 0, 0, 1, 1, 0],
    [0, 0, 0, 0, 0, 0, 1, 1, 0, 0],
    [0, 0, 0, 0, 0, 1, 1, 0, 0, 0],
    [0, 0, 0, 0, 1, 1, 0, 0, 0, 0],
    [0, 0, 0, 1, 1, 0, 0, 0, 0, 0],
    [0, 0, 1, 1, 0, 0, 0, 0, 0, 0],
    [0, 1, 1, 0, 0, 0, 0, 0, 0, 0],
    [1, 1, 0, 0, 0, 0, 0, 0, 0, 0],
    [1, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]]).
testAxialSymmetry :-
    testBoard1(Board),
    printBoard(Board),
    getBlockPositions(Board, 1, 3, 2, NewBoard, [], Pos),
    printBoard(NewBoard),
    write('old pos : '), write(Pos), nl,
    axialSymmetryPositions(Board, Pos, 0, 2, NewPos),
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

testValidMoves :-
    testBoard4(Board),
    printBoard(Board),
    valid_moves(Board, 1, ListOfMoves),
    write(ListOfMoves), nl.

testBestMove :-
    testBoard4(Board),
    printBoard(Board),
    choose_move(Board, 1, 2, Move),
    write(Move), nl.
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

/*
getAllChunks(Board, Piece, Chunks) :-
    getAllChunks(Board, 0, 0, Piece, Chunks).
getAllChunks(_Board, 9, 9, _Piece, []).
getAllChunks(Board, Row, Column, Piece, Chunks) :-
    getMatrixItem(Board, Row, Column, Block),
    Piece == Block,
    !,
    getBlockPositions(Board, Piece, Row, Column, NewBoard, [], Positions),
    nextCell(Row, Column, NewRow, NewColumn),
    getAllChunks(NewBoard, NewRow, NewColumn, Piece, NewChunks),
    append([Positions], NewChunks, Chunks).
getAllChunks(Board, Row, Column, Piece, Chunks) :-
    nextCell(Row, Column, NewRow, NewColumn),
    getAllChunks(Board, NewRow, NewColumn, Piece, Chunks).

nextCell(OldRow, 9, Row, 0) :-
    Row is OldRow + 1.
nextCell(OldRow, OldColumn, OldRow, Column) :-
    Column is OldColumn + 1.    
*/

/*
validMove(Board, Piece, 2, Row, Column, HAxis, VAxis, NewPositions, ValidMove) :-
    between(0, 9, Row),
    between(0, 9, Column),
    between(0, 8, HAxis),
    between(0, 8, VAxis),
    getBlockPositions(Board, Row, Column, Piece, Positions),
    pointSymmetryPositions(Board, Positions, HAxis, VAxis, NewPositions),
    Axes = HAxis-VAxis,
    ValidMove = Row-Column-2-Axes.
validMove(Board, Piece, Symmetry, Row, Column, Axis, NewPositions, ValidMove) :-
    between(0, 1, Symmetry),
    between(0, 9, Row),
    between(0, 9, Column),
    between(0, 8, Axis),
    getBlockPositions(Board, Row, Column, Piece, Positions),
    axialSymmetryPositions(Board, Positions, Symmetry, Axis, NewPositions),
    ValidMove = Row-Column-Symmetry-Axis.
*/ 
/*
move(Board, Move, Piece, NewBoard) :-
    %write(Move), nl,
    Row-Column-Symmetry-Axes = Move,
    HAxis-VAxis = Axes,
    %write(Row), write(' '), write(Column), write(' '), write(Symmetry), write(' '), write(HAxis), write(' '), write(VAxis), nl,
    validMove(Board, Piece, Symmetry, Row, Column, HAxis, VAxis, Positions, _ValidMove),
    %write(Positions), nl,
    updateBoard(Board, Positions, Piece, NewBoard).
move(Board, Move, Piece, NewBoard) :-
    Row-Column-Symmetry-Axis = Move,
    validMove(Board, Piece, Symmetry, Row, Column, Axis, Positions, _ValidMove),
    %write(Positions), nl,
    updateBoard(Board, Positions, Piece, NewBoard).
*/

/*
% Player - 1 or 2 (it's actually the player piece)
valid_moves(Board, Piece, ListOfMoves) :-
    validAxial(Board, Piece, Moves1),
    validPoint(Board, Piece, Moves2),
    append(Moves1, Moves2, ListOfMoves),
    length(ListOfMoves, Length),
    Length > 0.

validAxial(Board, Piece, Moves) :-
    setof(Move, validMove(Board, Piece, Symmetry, Row, Column, Axis, _, Move), Moves).
validAxial(_, _, []).

validPoint(Board, Piece, Moves) :-
    setof(Move, validMove(Board, Piece, 2, Row, Column, HAxis, VAxis, _, Move), Moves).
validPoint(_, _, []).
*/