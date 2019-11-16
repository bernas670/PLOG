% Start of the game, takes the players('P' or 'C') as arguments as well as
% their levels in case the player is a computer(1 or 2)
startGame(Player1, P1Level, Player2, P2Level) :-
    initialBoard(InitialBoard),
    printBoard(InitialBoard),
    addCastles(InitialBoard, Player1, Player2, CastleBoard),
    addStartPieces(CastleBoard, Player1, Player2, StartPiecesBoard),
    gameLoop(StartPiecesBoard, Player1, P1Level, Player2, P2Level).

game_over(Board, Winner):-
    \+valid_moves(Board, 1, _),
    \+valid_moves(Board, 2, _),
    !,
    value(Board, 1, V1),
    value(Board, 2, V2),
    getWinner(V1, V2, Winner).

getWinner(Points1, Points2, 1) :-
    Points1 > Points2.
getWinner(Points1, Points2, 2) :-
    Points2 > Points1.
getWinner(_Points1, _Points2, 0).

printWinner(0, _, _) :-
    write('draw').
printWinner(1, Player1, _) :-
    write('player1').
printWinner(2, _, Player2) :-
    write('player2').


gameLoop(Board, Player1, _P1Level, Player2, _P2Level) :-
    game_over(Board, Winner),
    printWinner(Winner, Player1, Player2).
gameLoop(Board, Player1, P1Level, Player2, P2Level) :-
    playerTurn(Board, Player1, P1Level, 1, NewBoard1),
    playerTurn(NewBoard1, Player2, P2Level, 2, NewBoard2),
    % TODO: check if the players have moves left
    % if there are no moves left game_over, else keep playing
    gameLoop(NewBoard2, Player1, P1Level, Player2, P2Level).

% playerTurn(Board, Player, PlayerLevel, Piece, NewBoard)
playerTurn(Board, 'P', _Level, Piece, NewBoard) :-
    valid_moves(Board, Piece, _ValidMoves),
    getBlock(Board, Piece, Row, Column),
    askSymmetry(Symmetry, Axes),
    Move = Row-Column-Symmetry-Axes,
    move(Board, Move, Piece, NewBoard),
    printMove(Move, 'P', Piece),
    printBoard(NewBoard).
playerTurn(Board, 'C', Level, Piece, NewBoard) :-
    choose_move(Board, Piece, Level, Move),
    move(Board, Move, Piece, NewBoard),
    printMove(Move, 'C', Piece),
    printBoard(NewBoard).
playerTurn(Board, Player, _Level, Piece, Board) :-
    ansi_format([bg(red), fg(white)], '                 ~w ~d Has no moves left                      ', [Player, Piece]), nl.

printMove(Move, Player, PlayerNumber) :-
    Row-Column-Symmetry-Axes = Move,
    ansi_format([bg(red), fg(white)], '                 ~w ~d  SYMMETRY : ~d                      ', [Player, PlayerNumber, Symmetry]), nl.


% choose_move(Board, Piece, Level, Move)
choose_move(Board, Piece, 1, Move) :-
    valid_moves(Board, Piece, ValidMoves),
    random_member(Move, ValidMoves).

choose_move(Board, Piece, 2, Move) :-
    valid_moves(Board, Piece, ValidMoves),
    getBestMove(Board, Piece, ValidMoves, Move).

getMoveValue(Board, Piece, Move, Value) :-
    Row-Column-_Symmetry-_Axes = Move,
    getBlockPositions(Board, Row, Column, Piece, Positions),
    length(Positions, Value).

getBestMove(_Board, _Piece, [BMove], BMove) :-
    !.
getBestMove(Board, Piece, [HMove|TMove], BMove) :-
    getMoveValue(Board, Piece, HMove, HValue),
    getBestMove(Board, Piece, TMove, BMove),    
    getMoveValue(Board, Piece, BMove, BValue),
    BValue >= HValue,
    !.
getBestMove(_, _, [HMove|_], HMove) :-
    !.


% getChunk(Board, Player, Piece, Positions)
getBlock(Board, Piece, Row, Column) :-
    ansi_format([bg(black)], '            PLAYER ~d : Choose one of your blocks            ', [Piece]), nl,
    askCoords(Row, Column),
    getMatrixItem(Board, Row, Column, Block),
    Piece == Block.
getBlock(Board, Piece, Row, Column) :-
    % TODO: error message
    getBlock(Board, Piece, Row, Column).


valid_moves(Board, Piece, ListOfMoves) :-
    findall(Move, validMove(Board, Piece, Symmetry, Row, Column, Axes, _, Move), ListOfMoves),
    length(ListOfMoves, Length),
    Length > 0.


validMove(Board, Piece, Symmetry, Row, Column, Axes, NewPositions, ValidMove) :-
    between(0, 9, Row),
    between(0, 9, Column),
    between(0, 2, Symmetry),
    getBlockPositions(Board, Row, Column, Piece, Positions),
    symmetry(Board, Positions, Symmetry, Axes, NewPositions),
    ValidMove = Row-Column-Symmetry-Axes.    



move(Board, Move, Piece, NewBoard) :-
    Row-Column-Symmetry-Axes = Move,
    validMove(Board, Piece, Symmetry, Row, Column, Axes, Pos, _),
    updateBoard(Board, Pos, Piece, NewBoard).


% TODO: do the loop to ask until a valid symmetry is entered
% getSymmetry(Board, Player, Positions, NewPositions)

addCastles(Board, Player1, Player2, NewBoard) :-
    placePiece(Board, Player1, 1, 3, NewBoard1),
    placePiece(NewBoard1, Player1, 1, 3, NewBoard2),
    placePiece(NewBoard2, Player2, 2, 3, NewBoard3),
    placePiece(NewBoard3, Player2, 2, 3, NewBoard).

addStartPieces(Board, Player1, Player2, NewBoard) :-
    placePiece(Board, Player1, 1, 1, NewBoard1),
    placePiece(NewBoard1, Player2, 2, 2, NewBoard).

% Prompts the player to place a Piece on the board
% placePiece(Board, Player, Piece, NewBoard)
placePiece(Board, 'P', PlayerNumber, Piece, NewBoard) :-
    ansi_format([bg(black), fg(red)], '                         PLAYER ~d                         ', [PlayerNumber]), nl,
    pieceName(Piece, PieceName),
    ansi_format([bg(black), fg(red)], '                       Place ~w                       ', [PieceName]), nl,    
    askCoords(Row, Column),
    isEmpty(Board, Row, Column),
    setMatrixItem(Board, Row, Column, Piece, NewBoard),
    RealRow is Row + 1, RealColumn is Column + 1,
    ansi_format([bg(black), fg(red)], '          PLAYER ~d : Placed a ~w [~d, ~d]         ', [PlayerNumber, PieceName, RealRow, RealColumn]), nl,
    printBoard(NewBoard).
placePiece(Board, 'P', PlayerNumber, Piece, NewBoard) :-
    ansi_format([bg(black), fg(red)], '             This cell is occupied! Try again...            ', []), nl,
    placePiece(Board, 'P', PlayerNumber, Piece, NewBoard).


placePiece(Board, 'C', PlayerNumber, Piece, NewBoard) :-
    pieceName(Piece, PieceName),
    generateCoords(Board, Row, Column),
    setMatrixItem(Board, Row, Column, Piece, NewBoard),
    RealRow is Row + 1, RealColumn is Column + 1,
    ansi_format([bg(black), fg(red)], '          COMPUTER ~d : Placed a ~w [~d, ~d]         ', [PlayerNumber, PieceName, RealRow, RealColumn]), nl,
    printBoard(NewBoard).

generateCoords(Board, Row, Column) :-
    random(0, 10, Row),
    random(0, 10, Column),
    isEmpty(Board, Row, Column).
generateCoords(Board, Row, Column) :-
    generateCoords(Board, Row, Column).


% Is true if the cell is empty
isEmpty(Board, Row, Column) :-
    getMatrixItem(Board, Row, Column, Piece),
    Piece == 0.


% FIXME: refactor this code
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


