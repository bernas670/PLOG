% Solves the puzzle with the corresponding number, prints the solution 
% and the execution time and returns the solved board
% 
% Number - number of the puzzle to solve
% Board - solved puzzle board
solve_puzzle(Number, Board) :-
    puzzle(Number, Col, Row),
    format('~nPuzzle Nr ~d~n~n', [Number]),
    statistics(walltime, [Start, _]),
    solve_puzzle([], Col, Row, Board),
    statistics(walltime, [End, _]),
    print_board(Board, Col, Row),
    Time is End - Start,
    format('~nExecution time : ~3d s~n~n', [Time]).

% Solves a puzzle with the provided hints
% 
% LOptions - labeling options
% Col - list of column hints
% Row - list of row hints
% Board - solution for the puzzle
solve_puzzle(LOptions, Col, Row, Board) :-
    length(Col, ColSize),
    length(Row, RowSize),

    generate_board(ColSize, RowSize, Board),

    append(Board, FlatBoard),
    domain(FlatBoard, 0, 1),
    
    % iterate through the rows and apply the restrictions
    itr_line(Row, Board, RowSize, (-2)-(-2)),
    transpose(Board, TBoard),
    % iterate through the columns and apply the restrictions
    itr_line(Col, TBoard, ColSize, (-2)-(-2)),
    
    labeling(LOptions, FlatBoard).

% Iterate through the board and apply restrictions
itr_line([], [], _Length, _Pos).
itr_line([HRow|TRow], [HBoard|TBoard], Length, InPos) :-
    NumZeros is Length - 2,
    % each line can only contain two 1s and the rest must be filled with 0s
    global_cardinality(HBoard, [0-NumZeros, 1-2]),
    space_rest(HRow, HBoard, InPos, OutPos),
    itr_line(TRow, TBoard, Length, OutPos).

% In each line the 1s must have at least one 0 between them, however when a 
% distance is defined on the hints list that restriction is applied. Also, 
% each 1 must be surrounded by 0s. 
% 
% Space - spacing between the 1s
% Line - line that the restrictions will be applied to
% InPos - tuple containing the positions of the 1s on the previous line
% OutPos - tuple containing the positions of the 1s on the current line
space_rest(Space, Line, PrvPos, OutPos) :-
    var(Space), !,
    element(CurIPos, Line, 1),
    element(CurFPos, Line, 1),

    CurFPos - CurIPos #> 1,

    surround_rest(CurIPos-CurFPos, PrvPos, OutPos).
space_rest(Space, Line, PrvPos, OutPos) :-
    element(CurIPos, Line, 1),
    element(CurFPos, Line, 1),
    
    NSpace is Space + 1,
    CurFPos - CurIPos #= NSpace,

    surround_rest(CurIPos-CurFPos, PrvPos, OutPos).

% Each 1 must be surrounded by 0s. This predicate applies this restriction 
% to the current line by calculating the positions in which the 1s cannot 
% be placed in through the positions where the 1s of the previous lines 
% where placed
% 
% CurPos - tuple containing the positions of the 1s for the current line
% PrvPos - tuple containing the positions of the 1s on the previous line
% OutPos - tuple containing the final positions for the 1s on the current line
surround_rest(CurPos, PrvPos, OutPos) :-
    CurIPos-CurFPos = CurPos,
    PrvIPos-PrvFPos = PrvPos,

    CurIPos #< PrvFPos - 1 #\/ CurIPos #> PrvFPos + 1,
    CurIPos #< PrvIPos - 1 #\/ CurIPos #> PrvIPos + 1,

    CurFPos #< PrvIPos - 1 #\/ CurFPos #> PrvIPos + 1,
    CurFPos #< PrvFPos - 1 #\/ CurFPos #> PrvFPos + 1,

    OutPos = CurIPos-CurFPos.

% Generates an empty board, a list of lists, with the desired number 
% of rows (number of lists) and rows (length of the lists)
% 
% NumCols - number of columns
% NumRows - number of rows
% Board - the generated board
generate_board(NumCols, NumRows, Board) :-
    length_list(NumRows, Board),
    maplist(length_list(NumCols), Board).
length_list(Int, List) :-
    length(List, Int).
