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

% Returns a list of positions (NewPositions) with the coordinates of 
getBlockPositions(Board, Block, Row, Column, NewBoard, Positions, NewPositions) :-
    Row >= 0, Row =< 9,
    Column >= 0, Column =< 9,
    !,
    getMatrixItem(Board, Row, Column, Item),
    % check if the cell on the given position contains the expected piece
    ((Block == Item) ->
        (   % if the pieces match keep searching
            setMatrixItem(Board, Row, Column, 0, NewBoard1),
            append([Row], [Column], Coords),
            append([Coords], Positions, NewPositions1),
            % check the cell bellow
            Row1 is Row + 1,
            getBlockPositions(NewBoard1, Block, Row1, Column, NewBoard2, NewPositions1, NewPositions2),
            % check the cell above
            Row2 is Row - 1,
            getBlockPositions(NewBoard2, Block, Row2, Column, NewBoard3, NewPositions2, NewPositions3),
            %check the cell to the right
            Column1 is Column + 1,
            getBlockPositions(NewBoard3, Block, Row, Column1, NewBoard4, NewPositions3, NewPositions4),
            % check the cell to the left
            Column2 is Column - 1,
            getBlockPositions(NewBoard4, Block, Row, Column2, NewBoard, NewPositions4, NewPositions)
        );
        (   % in case they don't match return 
            copyMatrix(Board, NewBoard),
            copyList(Positions, NewPositions)
        )
    ).

% If the Row or Column parameters are invalid return
getBlockPositions(Board, _Block, _Row, _Column, NewBoard, Positions, NewPositions) :-
    copyMatrix(Board, NewBoard),
    copyList(Positions, NewPositions).

%   ------------------------------------
%      FUNCTIONS FOR TESTING PURPOSES
%   ------------------------------------
%   TODO: remove these when done testing

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
    getBlockPositions(Board, 2, 8, 2, NewBoard, [], Pos),
    write('Result'), nl,
    printBoard(NewBoard),
    write(Pos).


