:- include('board.pl').
:- include('input.pl').
:- include('symmetry.pl').
:- include('utilities.pl').

% Start of the game, takes the players('P' or 'C') as arguments as well as
% their levels in case the player is a computer(1 or 2)
startGame(Player1, P1Level, Player2, P2Level) :-
    initialBoard(InitialBoard),
    printBoard(InitialBoard),
    addCastles(InitialBoard, Player1, Player2, CastleBoard),
    addStartPieces(CastleBoard, Player1, Player2, StartPiecesBoard),
    gameLoop(StartPiecesBoard, Player1, P1Level, Player2, P2Level).

% Checks if the game is over, when both players have no moves left,
% and returns the winner in case the game is over
game_over(Board, Winner):-
    \+valid_moves(Board, 1, _),
    \+valid_moves(Board, 2, _),
    !,
    value(Board, 1, V1),
    value(Board, 2, V2),
    getWinner(V1, V2, Winner).

% Gets the winner of the game
% Returns 0 when a draw occurs, 1 when player 1 wins and 2 when player 2 wins
getWinner(Points1, Points2, 1) :-
    Points1 > Points2.
getWinner(Points1, Points2, 2) :-
    Points2 > Points1.
getWinner(_Points1, _Points2, 0).

% Print the result of the game(draw, player 1 won, player 2 won)
printWinner(0) :-
    ansi_format([bg(black), fg(red)], '   ┼────────────────────────────────────────────────────┼   ', []), nl,
    ansi_format([bg(black), fg(red)], '   │                   It\'s a draw...                   │   ', []), nl,
    ansi_format([bg(black), fg(red)], '   ┼────────────────────────────────────────────────────┼   ', []), nl.
printWinner(Winner) :-
    ansi_format([bg(black), fg(red)], '   ┼────────────────────────────────────────────────────┼   ', []), nl,
    ansi_format([bg(black), fg(red)], '   │                    PLAYER ~w WON                    │   ', [Winner]), nl,
    ansi_format([bg(black), fg(red)], '   ┼────────────────────────────────────────────────────┼   ', []), nl.


% When the game is over print the winner
gameLoop(Board, _Player1, _P1Level, _Player2, _P2Level) :-
    game_over(Board, Winner),
    printWinner(Winner). 
% Loop during which the players make their moves, one move for each.
% When a player has no moves left he passes the turn to the other player
gameLoop(Board, Player1, P1Level, Player2, P2Level) :-
    playerTurn(Board, Player1, P1Level, 1, NewBoard1),
    playerTurn(NewBoard1, Player2, P2Level, 2, NewBoard2),
    % if there are no moves left game_over, else keep playing
    gameLoop(NewBoard2, Player1, P1Level, Player2, P2Level).

% Player turn
playerTurn(Board, 'P', _Level, Piece, NewBoard) :-
    % check if the player has any moves left
    valid_moves(Board, Piece, _ValidMoves),
    % get a block to make the symmetry
    getBlock(Board, Piece, Row, Column),
    % ask for the symmetry
    askSymmetry(Symmetry, Axes),
    Move = Row-Column-Symmetry-Axes,
    % make the move if possible
    move(Board, Move, Piece, NewBoard),
    printMove(Move, Piece),
    printBoard(NewBoard).
% Computer turn 
playerTurn(Board, 'C', Level, Piece, NewBoard) :-
    % choose the best move, according to the level
    choose_move(Board, Piece, Level, Move),
    move(Board, Move, Piece, NewBoard),
    printMove(Move, Piece),
    printBoard(NewBoard).
% When the player/computer has no moves left print this message
playerTurn(Board, _Player, _Level, Piece, Board) :-
    ansi_format([bg(red), fg(white)], '                 PLAYER ~d Has no moves left                 ', [Piece]), nl.

% Used to print the moves
symmetryType(0, 'Horizontal').
symmetryType(1, 'Vertical').
symmetryType(2, 'Point').
% Print the the move the player made on his turn
printMove(Move, PlayerNumber) :-
    Row-Column-Symmetry-Axes = Move,
    symmetryType(Symmetry, SType),
    RealRow is Row + 1,
    RealColumn is Column + 1,
    ansi_format([bg(black), fg(red)], '         Player ~d  Block : [~|~`0t~d~2+, ~|~`0t~d~2+] ~w : ~w         ', [PlayerNumber, RealRow, RealColumn, SType, Axes]), nl.

% Choose the move for the level 1 computer
choose_move(Board, Piece, 1, Move) :-
    % get the list of valid moves
    valid_moves(Board, Piece, ValidMoves),
    % choose a random move from the list
    random_member(Move, ValidMoves).

% Choose the move for the level 2 computer
choose_move(Board, Piece, 2, Move) :-
    % get the list of valid moves
    valid_moves(Board, Piece, ValidMoves),
    % get the move that places the most pieces on the board
    getBestMove(Board, Piece, ValidMoves, Move).

% Gets the number of pieces that the parsed move
% would place on the board if executed
getMoveValue(Board, Piece, Move, Value) :-
    Row-Column-_Symmetry-_Axes = Move,
    getBlockPositions(Board, Row, Column, Piece, Positions),
    length(Positions, Value).

% Gets the best move for the level 2 computer
% From a list of moves it chooses the one that would place the
% most pieces on the board in that play.
getBestMove(_Board, _Piece, [BMove], BMove) :- !.
getBestMove(Board, Piece, [HMove|TMove], BMove) :-
    getMoveValue(Board, Piece, HMove, HValue),
    getBestMove(Board, Piece, TMove, BMove),    
    getMoveValue(Board, Piece, BMove, BValue),
    BValue >= HValue,
    !.
getBestMove(_, _, [HMove|_], HMove) :- !.


% Prompt the player to introduce the coordinates of one of his blocks
% Only exits when the player inputs valid coordinates
getBlock(Board, Piece, Row, Column) :-
    ansi_format([bg(black)], '            PLAYER ~d : Choose one of your blocks            ', [Piece]), nl,
    askCoords(Row, Column),
    getMatrixItem(Board, Row, Column, Block),
    Piece == Block.
getBlock(Board, Piece, Row, Column) :-
    ansi_format([bg(black), fg(red)], '   ┼────────────────────────────────────────────────────┼   ', []), nl,
    ansi_format([bg(black), fg(red)], '   │                   Invalid block!                   │   ', []), nl,
    ansi_format([bg(black), fg(red)], '   ┼────────────────────────────────────────────────────┼   ', []), nl,
    getBlock(Board, Piece, Row, Column).

% Get the list of all valid moves for a player
valid_moves(Board, Piece, ListOfMoves) :-
    findall(Move, validMove(Board, Piece, _Symmetry, _Row, _Column, _Axes, _, Move), ListOfMoves),
    length(ListOfMoves, Length),
    Length > 0.

% Check if a move is valid and return the positions of the new blocks
validMove(Board, Piece, Symmetry, Row, Column, Axes, NewPositions, ValidMove) :-
    between(0, 9, Row),
    between(0, 9, Column),
    between(0, 2, Symmetry),
    getBlockPositions(Board, Row, Column, Piece, Positions),
    symmetry(Board, Positions, Symmetry, Axes, NewPositions),
    ValidMove = Row-Column-Symmetry-Axes.    

% Check if a move is valid and, if it is, execute it
move(Board, Move, Piece, NewBoard) :-
    Row-Column-Symmetry-Axes = Move,
    validMove(Board, Piece, Symmetry, Row, Column, Axes, Pos, _),
    updateBoard(Board, Pos, Piece, NewBoard).

% Add all the starting castles
addCastles(Board, Player1, Player2, NewBoard) :-
    placePiece(Board, Player1, 1, 3, NewBoard1),
    placePiece(NewBoard1, Player1, 1, 3, NewBoard2),
    placePiece(NewBoard2, Player2, 2, 3, NewBoard3),
    placePiece(NewBoard3, Player2, 2, 3, NewBoard).

% Add all the starting pieces
addStartPieces(Board, Player1, Player2, NewBoard) :-
    placePiece(Board, Player1, 1, 1, NewBoard1),
    placePiece(NewBoard1, Player2, 2, 2, NewBoard).

% Prompts the player to place a Piece on the board
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

% The computer places a piece in a random valid position on the board
placePiece(Board, 'C', PlayerNumber, Piece, NewBoard) :-
    pieceName(Piece, PieceName),
    generateCoords(Board, Row, Column),
    setMatrixItem(Board, Row, Column, Piece, NewBoard),
    RealRow is Row + 1, RealColumn is Column + 1,
    ansi_format([bg(black), fg(red)], '          PLAYER ~d : Placed a ~w [~d, ~d]         ', [PlayerNumber, PieceName, RealRow, RealColumn]), nl,
    printBoard(NewBoard).

% Generate random coordinates, the cell on those coordinates must be empty
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

% Returns a list of positions (NewPositions) with the coordinates of the blocks connected
% to the one with coordinates [Row, Column]
getBlockPositions(Board, Row, Column, Block, Positions) :-
    getMatrixItem(Board, Row, Column, Piece),
    Piece == Block,
    getBlockPositions(Board, Block, Row, Column, _NewBoard, [], Positions).
% Positions must be an empty list
getBlockPositions(Board, Block, Row, Column, NewBoard, Positions, NewPositions) :-
    % check if the coordinates are valid
    between(0, 9, Row),
    between(0, 9, Column),
    getMatrixItem(Board, Row, Column, Item),
    % check if the cell on the given position contains the expected piece
    Block == Item, !,
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
    getBlockPositions(NewBoard4, Block, Row, Column2, NewBoard, NewPositions4, NewPositions).
% If the Row or Column parameters are invalid return
getBlockPositions(Board, _Block, _Row, _Column, Board, Positions, Positions).
