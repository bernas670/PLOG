% Start the game
startGame(Player1, Player2) :-
    initialBoard(InitialBoard),
    printBoard(InitialBoard),
    addCastles(InitialBoard, CastleBoard, Player1, Player2),
    addStartPieces(CastleBoard, StartPiecesBoard, Player1, Player2),
    % TODO: remove the write, it's only here because of the singleton error
    write(StartPiecesBoard),
    nl, nl, write('Exit'), nl, nl.

% TODO:
addCastles(_, _, _, 'C') :-
    nl, ansi_format([bg(black), fg(red)], '                       Under construction :)                       ', []), nl.

addCastles(Board, NewBoard, 'P', 'P') :-
    placePiece(Board, NewBoard1, 3, '1'),
    placePiece(NewBoard1, NewBoard2, 3, '1'),
    placePiece(NewBoard2, NewBoard3, 3, '2'),    
    placePiece(NewBoard3, NewBoard, 3, '2').

addStartPieces(Board, NewBoard, 'P', 'P') :-
    placePiece(Board, NewBoard1, 1, '1'),
    placePiece(NewBoard1, NewBoard, 2, '2').

% Prompts the player to place a Piece on the board
placePiece(Board, NewBoard, Piece, Player) :-
    ansi_format([bg(black), fg(red)], '                         PLAYER ~w                         ', [Player]), nl,
    pieceName(Piece, PieceName),
    ansi_format([bg(black), fg(red)], '                       Place ~w                       ', [PieceName]), nl,    
    askCoords(Row, Column),
    ((
        isEmpty(Board, Row, Column),
        setMatrixItem(Board, Row, Column, Piece, NewBoard),
        RealRow is Row + 1,
        RealColumn is Column + 1,
        ansi_format([bg(black), fg(red)], '    PLAYER ~w placed a ~w on [row, col] : [~d, ~d]    ', [Player, PieceName, RealRow, RealColumn])
    );
    (
        ansi_format([bg(black), fg(red)], '             This cell is occupied! Try again...            ', []), nl,
        printBoard(Board),
        placePiece(Board, NewBoard, Piece, Player)
    )),
    printBoard(NewBoard).

% Is true if the cell is empty
isEmpty(Board, Row, Column) :-
    getMatrixItem(Board, Row, Column, Piece),
    Piece == 0.

% TODO: get list with the block positions
getBlockPositions(Board, Block, Row, Column, NewBoard) :-
    Row >= 0, Row =< 9,
    Column >= 0, Column =< 9,
    !,
    getMatrixItem(Board, Row, Column, Item),
    ((Block == Item) ->
        (
            nl, ansi_format([bg(cyan), fg(white)], '             Row : ~d  Column : ~d            ', [Row, Column]), nl,
            setMatrixItem(Board, Row, Column, 0, NewBoard1),

            nl, ansi_format([bg(black), fg(red)], '             Row : ~d  Column : ~d            ', [Row, Column]), nl,    
            Row1 is Row + 1,
            ansi_format([bg(black), fg(red)], 'it ... Row : ~d  Column : ~d            ', [Row1, Column]), nl,
            getBlockPositions(NewBoard1, Block, Row1, Column, NewBoard2),
        
            nl, ansi_format([bg(black), fg(red)], '             Row : ~d  Column : ~d            ', [Row, Column]), nl,    
            Row2 is Row - 1,
            ansi_format([bg(black), fg(red)], 'it ... Row : ~d  Column : ~d            ', [Row2, Column]), nl,
            getBlockPositions(NewBoard2, Block, Row2, Column, NewBoard3),
        
            nl, ansi_format([bg(black), fg(red)], '             Row : ~d  Column : ~d            ', [Row, Column]), nl,    
            Column1 is Column + 1,
            ansi_format([bg(black), fg(red)], 'it ... Row : ~d  Column : ~d            ', [Row, Column1]), nl,
            getBlockPositions(NewBoard3, Block, Row, Column1, NewBoard4),
        
            nl, ansi_format([bg(black), fg(red)], '             Row : ~d  Column : ~d            ', [Row, Column]), nl,                
            Column2 is Column - 1,
            ansi_format([bg(black), fg(red)], 'it ... Row : ~d  Column : ~d            ', [Row, Column2]), nl, 
            getBlockPositions(NewBoard4, Block, Row, Column2, NewBoard)

        );
        (
            copyMatrix(Board, NewBoard)
        )
    ).

getBlockPositions(Board, _, _, _, NewBoard) :-
    copyMatrix(Board, NewBoard).


finalBoard([ 
    [0, 1, 1, 0, 2, 1, 1, 2, 2, 3],
    [0, 1, 1, 0, 2, 1, 1, 2, 2, 0],
    [0, 0, 0, 0, 2, 1, 1, 1, 1, 0],
    [1, 1, 1, 1, 2, 3, 0, 2, 2, 0],
    [1, 1, 1, 1, 0, 0, 0, 2, 2, 0],
    [0, 0, 2, 2, 0, 0, 2, 2, 0, 0],
    [2, 2, 0, 3, 0, 0, 0, 3, 0, 0],
    [2, 2, 1, 1, 1, 1, 1, 1, 1, 1],
    [2, 2, 2, 2, 0, 0, 2, 2, 0, 0],
    [2, 2, 2, 2, 0, 0, 2, 2, 0, 0]]).

testPos :- 
    finalBoard(Board),
    printBoard(Board),
    getBlockPositions(Board, 2, 8, 2, NewBoard),
    write('Result'), nl,
    printBoard(NewBoard).


