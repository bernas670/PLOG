:-use_module(library(clpfd)).
:-use_module(library(lists)).

:- include('puzzles.pl').
:- include('display.pl').



solve(Number) :-
    puzzle(Number, Col, Row),
    format('~nPuzzle Nr ~d~n~n', [Number]),
    statistics(runtime, _),
    solve_puzzle(Col, Row),
    statistics(runtime, [_, Time|_]),
    format('~nExecution time : ~d ms~n~n', [Time]).


solve_puzzle(Col, Row) :-
    length(Col, ColSize),
    length(Row, RowSize),

    generate_board(ColSize, RowSize, Board),

    append(Board, FlatBoard),
    domain(FlatBoard, 0, 1),

% TODO: try messing around with the starting coordinates
    itr_line(Row, Board, RowSize, (-2)-(-2)),
    transpose(Board, TBoard),
    itr_line(Col, TBoard, ColSize, (-2)-(-2)),

% TODO: change labeling
    labeling([], FlatBoard),
    print_board(Board, Col, Row).
    

itr_line([], [], _Length, _Pos).
itr_line([HRow|TRow], [HBoard|TBoard], Length, InPos) :-
    NumZeros is Length - 2,
    global_cardinality(HBoard, [0-NumZeros, 1-2]),
    space_rest(HRow, HBoard, InPos, OutPos),
    itr_line(TRow, TBoard, Length, OutPos).


% Space - spacing between the 1s
% Line - line that the restrictions will be applied to
% InPos - tuple containing the positions of the 1s on the previous line
% OutPos - tuple containing the positions of the 1s on the current line
space_rest(Space, Line, InPos, OutPos) :-
    var(Space),
    element(IPos, Line, 1),
    element(FPos, Line, 1),
    FPos - IPos #> 1,

% TODO: encapsulate this part
    % get tuple content
    InIPos-InFPos = InPos,

    IPos #\= InIPos - 1, IPos #\= InIPos + 1, 
    IPos #\= InFPos - 1, IPos #\= InFPos + 1, 
    
    FPos #\= InIPos - 1, FPos #\= InIPos + 1, 
    FPos #\= InFPos - 1, FPos #\= InFPos + 1, 

    % create output tuple 
    OutPos = IPos - FPos.
space_rest(Space, Line, InPos, OutPos) :-
    element(IPos, Line, 1),
    element(FPos, Line, 1),
    NSpace is Space + 1,
    FPos - IPos #= NSpace,

    % get tuple content
    InIPos-InFPos = InPos,

    IPos #\= InIPos - 1, IPos #\= InIPos + 1, 
    IPos #\= InFPos - 1, IPos #\= InFPos + 1, 
    
    FPos #\= InIPos - 1, FPos #\= InIPos + 1, 
    FPos #\= InFPos - 1, FPos #\= InFPos + 1, 

    % create output tuple 
    OutPos = IPos - FPos.

generate_board(Cols, Rows, Board) :-
    length_list(Rows, Board),
    maplist(length_list(Cols), Board).

length_list(Int, List) :-
    length(List, Int).
