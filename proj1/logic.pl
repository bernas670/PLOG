% Start the game
startGame(Player1, Player2) :-
    initialBoard(InitialBoard),
    printBoard(InitialBoard),
    addCastles(InitialBoard, CastleBoard, Player1, Player2),
    addStartPieces(CastleBoard, StartPiecesBoard, Player1, Player2),
    % TODO: remove this, it's only here because of the singleton warning
    write(StartPiecesBoard).

/*
    gameLoop(StartPiecesBoard, Player1, Player2). % loop that will occur until there is a winner

gameLoop(Board, Player1, Player2) :-
    makeMove(Board, Player1, NewBoard, 1),
    makeMove(NewBoard, Player2, NewBoard2, 2),
    gameLoop(NewBoard2, Player1, Player2).

% TODO:
makeMove(_Board, 'C', _NewBoard, _PlayerPiece) :-
    nl, ansi_format([bg(black), fg(red)], '                       Under construction :)                       ', []), nl.

makeMove(Board, 'P', NewBoard, PlayerPiece) :-
    valid_moves(Board, PlayerPiece, ListOfMoves),
    write(ListOfMoves), nl,
    ansi_format([bg(black), fg(red)], '                       Place ~w                       ', [Player]), nl,
    pieceName(PlayerPiece, PieceName),
    ansi_format([bg(black), fg(red)], '                       Place ~w                       ', [PieceName]), nl,
    askCoords(Row, Column),
    getBlockPositions(Board, PlayerPiece, Row, Column, NewBoard, [], Positions), % not sure if newboard is needed
    askAxis(Axis, String),
    % verificar que é possível efetuar a simetria, tendo atenção a tres parametros:
    % -> primeiro, que o eixo de simetria não se encontro "dentro" da ilha de blocos a fazer a transformação
    % -> em segundo, que ao fazer as simetrias nenhum bloco fique fora do tabuleiro
    % -> em terceiro, se os dois anteriores se se verificarem, os blocos após a simetria não podem ocupar celulas ja ocupadas
    axialSymmetryPositions() ou pointSymmetryPositions() consoante o escolhido na interface do axis
    updateBOard() usando novas coordenadas.
    


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
getBlockPositions(Board, _Block, _Row, _Column, NewBoard, Positions, NewPositions) :-
    copyMatrix(Board, NewBoard),
    copyList(Positions, NewPositions).



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
