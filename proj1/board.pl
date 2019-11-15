% TODO: make the board size dynamic

% Initial state of the board
initialBoard([ 
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
    [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]]).

% Piece's name
pieceName(0, 'Empty Cell').
pieceName(1, 'Player Piece').
pieceName(2, 'Player Piece').
pieceName(3, 'Castle').

% Piece's colors
pieceColor(0, black).      % empty slot
pieceColor(1, red).        % player 1 pieces
pieceColor(2, cyan).       % player 2 pieces
pieceColor(3, white).      % castle

% Print the board
printBoard(Board) :- 
    nl,
    ansi_format([bg(black)], '                                                            ', []), nl,
    ansi_format([bg(black)], '       01   02   03   04   05   06   07   08   09   10      ', []), nl,
    ansi_format([bg(black)], '     ┼────┼────┼────┼────┼────┼────┼────┼────┼────┼────┼    ', []), nl,
    printMatrix(Board, 1, 97),
    ansi_format([bg(black)], '          r    q    p    o    n    m    l    k    j         ', []), nl,
    ansi_format([bg(black)], '                                                            ', []), nl,
    value(Board, 1, P1), value(Board, 2, P2),
    ansi_format([bg(black)], '     Scores         1 : ~d           2 : ~d                 ', [P1, P2]), nl,
    ansi_format([bg(black)], '                                                            ', []), nl,
    nl.

value(Board,Player,Value):-
    countItemsMatrix(Board,Player,Value).

% Print the contents of the matrix
printMatrix([], _, _).
printMatrix([Line|Tail], LineIndex, AxisLetter) :-
    ansi_format([bg(black)], '  ~|~`0t~d~2+', [LineIndex]),
    printLine(Line),
    printDivider(AxisLetter),
    NewLineIndex is LineIndex + 1,
    NewAxisLetter is AxisLetter + 1,
    printMatrix(Tail, NewLineIndex, NewAxisLetter).

% Print the horizontal divider
printDivider(AxisLetter) :-
    AxisLetter < 106,
    !,
    nl, ansi_format([bg(black)], '     ┼────┼────┼────┼────┼────┼────┼────┼────┼────┼────┼ ~c  ', [AxisLetter]), nl.
printDivider(_AxisLetter) :-
    nl, ansi_format([bg(black)], '     ┼────┼────┼────┼────┼────┼────┼────┼────┼────┼────┼    ', []), nl.

% Print a line
printLine([]) :-
    ansi_format([bg(black)], ' │    ', []).    
printLine([Cell|Tail]) :-
    ansi_format([bg(black)], ' │ ', []),
    printCell(Cell),
    printLine(Tail).

% Print a cell with the corresponding color
printCell(Cell) :-
    pieceColor(Cell, Color),
    ansi_format([bg(Color)], '  ', []).

% Update the board by changing the cells on the given positions
updateBoard(Board, [], _Piece, Board).
updateBoard(Board, [HPos|TPos], Piece, NewBoard) :-
    getListItem(HPos, 0, Row),
    getListItem(HPos, 1, Column),
    setMatrixItem(Board, Row, Column, Piece, NewBoard1),
    updateBoard(NewBoard1, TPos, Piece, NewBoard).
