
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
    printMatrix(Board, 1, 65),
    ansi_format([bg(black)], '          R    Q    P    O    N    M    L    K    J         ', []), nl,
    ansi_format([bg(black)], '                                                            ', []), nl,
    nl.

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
    nl,
    ansi_format([bg(black)], '     ┼────┼────┼────┼────┼────┼────┼────┼────┼────┼────┼ ~c  ', [AxisLetter]),
    nl.

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


% TEST THE DISPLAY METHOD ON THE INITIAL BOARD
testPrint :- initialBoard(Board), printBoard(Board).

