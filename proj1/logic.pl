% Start the game
startGame(Player1, Player2) :-
    initialBoard(InitialBoard),
    printBoard(InitialBoard),
    addCastles(InitialBoard, CastleBoard, Player1, Player2),
    addStartPieces(CastleBoard, StartPiecesBoard, Player1, Player2),
    gameLoop(StartPiecesBoard, Player1, Player2).

% The game loop 
gameLoop(Board, Player1, Player2) :-
    playerTurn(Board, Player1, 1, NewBoard1),
    playerTurn(NewBoard1, Player2, 2, NewBoard2),
    % TODO: check if the players have moves left
    % if there are no moves left game_over, else keep playing
    gameLoop(NewBoard2, Player1, Player2).


% playerTurn(Board, Player, Piece, NewBoard)
playerTurn(Board, 'P', Piece, NewBoard) :-
    % TODO: get valid moves
    % if there are valid moves play, else pass turn
    getChunk(Board, 'P', Piece, Positions),
    askSymmetry(Symmetry),
    makeSymmetry(Board, 'P', Symmetry, Positions, NewPositions),
    updateBoard(Board, NewPositions, Piece, NewBoard),
    printBoard(NewBoard).


% getChunk(Board, Player, Piece, Positions)
getChunk(Board, 'P', Piece, Positions) :-
    ansi_format([bg(black)], '            PLAYER ~d : Choose one of your blocks            ', [Piece]), nl,
    askCoords(Row, Column),
    (
    getBlockPositions(Board, Row, Column, Piece, Positions)
    % TODO: check if the chunk has any valid moves
    );(
    getChunk(Board, 'P', Piece, Positions)
    ).

% Player - 1 or 2 (it's actually the player piece)
valid_moves(Board, Piece, ListOfMoves) :-
    getAllChunks(Board, Piece, Chunks).

    % get all of the chunks
    % getAllChunks
    % for each chunk, check all the possible moves

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



% TODO: do the loop to ask until a valid symmetry is entered
% getSymmetry(Board, Player, Positions, NewPositions)

% makeSymmetry(Board, Player, Symmetry, Positions, NewBoard)
% Horizontal Axial Symmetry
makeSymmetry(Board, 'P', 1, Positions, NewPositions) :-
    % TODO: check if there are any valid moves with an horizontal axis
    askAxis(Axis, 'Horizontal'),
    axialSymmetryPositions(Board, Positions, 'H', Axis, NewPositions);
    makeSymmetry(Board, 'P', 1, Positions, NewPositions).

% Vertical Axial Symmetry
makeSymmetry(Board, 'P', 2, Positions, NewPositions) :-
    % TODO: check if there are any valid moves with an horizontal axis
    askAxis(Axis, 'Vertical'),
    axialSymmetryPositions(Board, Positions, 'V', Axis, NewPositions);
    makeSymmetry(Board, 'P', 2, Positions, NewPositions).
    

% Point Symmetry
makeSymmetry(Board, 'P', 3, Positions, NewPositions) :-
    % TODO: check if there are any valid moves with an horizontal axis    
    askPoint(HAxis, VAxis),
    pointSymmetryPositions(Board, Positions, HAxis, VAxis, NewPositions);
    makeSymmetry(Board, 'P', 3, Positions, NewPositions).
    

% TODO: change where invalid move occurs
invalidMove :- nl, write('invalid move'), nl.

/*
valid_moves(Board, PlayerPiece, ListOfMoves)
*/

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
    );(
        ansi_format([bg(black), fg(red)], '             This cell is occupied! Try again...            ', []), nl,
        printBoard(Board),
        placePiece(Board, NewBoard, Piece, Player)
    )),
    printBoard(NewBoard).

% Is true if the cell is empty
isEmpty(Board, Row, Column) :-
    getMatrixItem(Board, Row, Column, Piece),
    Piece == 0.

getBlockPositions(Board, Row, Column, Block, Positions) :-
    getMatrixItem(Board, Row, Column, Piece),
    Piece == Block,
    getBlockPositions(Board, Block, Row, Column, _NewBoard, [], Positions).
% Returns a list of positions (NewPositions) with the coordinates of the blocks
% Positions must be an empty list
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
getBlockPositions(Board, _Block, _Row, _Column, Board, Positions, Positions).

value(Board,Player,Value):-
    countItemsMatrix(Board,Player,Value).

gameOver(Board,Winner):-
    value(Board,1,C1),
    value(Board,2,C2),
    (   C1 > C2 ->
    ansi_format([bg(black), fg(red)], '                         PLAYER 1 WON :D                         ',[]), nl
    ;   C1 =:= C2 ->
    ansi_format([bg(black), fg(red)], '                         ITS A DRAW :S                         ',[]), nl
    ;   ansi_format([bg(black), fg(red)], '                     PLAYER 2 WON :D                         ',[]), nl
    ),
    % TODO: remove this, it's only here because of the singleton warning
    write(Winner), nl.
