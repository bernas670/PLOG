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