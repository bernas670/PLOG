:-use_module(library(clpfd)).
:-use_module(library(lists)).
:-use_module(library(random)).

:- include('puzzles.pl').
:- include('display.pl').



solve_puzzle(Number, Board) :-
    puzzle(Number, Col, Row),
    format('~nPuzzle Nr ~d~n~n', [Number]),
    statistics(walltime, [Start, _]),
    solve_puzzle([min], Col, Row, Board),
    statistics(walltime, [End, _]),
    print_board(Board, Col, Row),
    Time is End - Start,
    format('~nExecution time : ~3d s~n~n', [Time]).

solve_puzzle(LOptions, Col, Row, Board) :-
    length(Col, ColSize),
    length(Row, RowSize),

    generate_board(ColSize, RowSize, Board),

    append(Board, FlatBoard),
    domain(FlatBoard, 0, 1),
    
    itr_line(Row, Board, RowSize, (-2)-(-2)),
    transpose(Board, TBoard),
    itr_line(Col, TBoard, ColSize, (-2)-(-2)),
    
    labeling(LOptions, FlatBoard).

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

surround_rest(CurPos, PrvPos, OutPos) :-
    CurIPos-CurFPos = CurPos,
    PrvIPos-PrvFPos = PrvPos,

    CurIPos #< PrvFPos - 1 #\/ CurIPos #> PrvFPos + 1,
    CurIPos #< PrvIPos - 1 #\/ CurIPos #> PrvIPos + 1,

    CurFPos #< PrvIPos - 1 #\/ CurFPos #> PrvIPos + 1,
    CurFPos #< PrvFPos - 1 #\/ CurFPos #> PrvFPos + 1,

    OutPos = CurIPos-CurFPos.

generate_board(Cols, Rows, Board) :-
    length_list(Rows, Board),
    maplist(length_list(Cols), Board).

length_list(Int, List) :-
    length(List, Int).

selRandom(ListOfVars, Var, Rest):-
    random_select(Var, ListOfVars, Rest).