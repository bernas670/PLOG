% Generate a random puzzle. Solves an empty puzzle of the desired size using the 
% random variable and value labeling options and, after coming to a solution,
% randomly selects columns and rows and generates the hints for that solution.
% 
% Size - the size of the puzzle
% NumHints - the desired number of hints
generate1(PuzzleNumber, Size, NumHints) :-
    % generate the Col and Row hints
    length(Col, Size),
    length(Row, Size),

    solve_puzzle([down, variable(selRandom), value(selRandom)], Col, Row, Board),
    generate_hints(NumHints, Col, Row, Board),
    print_board(Board, Col, Row),
    save_puzzle(PuzzleNumber, Col, Row).

% Generate the desired number of hints for a puzzle. Each time randomly chooses if the 
% hint will be placed on the row or column.
% 
% Number - the desired number of hints
% Col - list of hints for the columns
% Row - list of hints for the rows
% Board - a solved puzzle
generate_hints(0, _, _, _).
generate_hints(Number, Col, Row, Board) :-
    random(0, 2, Rand),
    generate_hint(Rand, Col, Row, Board),
    NNumber is Number - 1,
    generate_hints(NNumber, Col, Row, Board).

% Generates and hint for the columns
generate_hint(0, Col, _Row, Board) :-
    transpose(Board, TBoard),
    calc_hint(Col, TBoard).
% Generates and hint for the rows
generate_hint(1, _Col, Row, Board) :-
    calc_hint(Row, Board).

% Calcultates the hint for a certain row or column
% 
% Hints - the list of hints
% Board - a solved puzzle
calc_hint(Hints, Board) :-
    length(Hints, Length),
    random(0, Length, Index),
    nth0(Index, Board, Line),

    nth0(Index, Hints, Dist),
    var(Dist), !,

    nth0(IPos, Line, 1, RestLine),
    nth0(FPos, RestLine, 1),

    calc_dist(Dist, IPos, FPos).

% Calculates the distance between two positions
% 
% Dist - the calculated distance
% IPos - Position 1
% FPos - Position 2
calc_dist(Dist, IPos, FPos) :-
    IPos > FPos, !,
    Dist is IPos - FPos - 1.
calc_dist(Dist, IPos, FPos) :-
    Dist is FPos - IPos.

% Select a random variable
selRandom(ListOfVars, Var, Rest):-
    random_select(Var, ListOfVars, Rest).

% Select a random value
selRandom(Var, _Rest, BB0, BB1) :-
    fd_set(Var, Set), 
    fdset_to_list(Set, List), 
    random_member(Value,List),
    (
        first_bound(BB0, BB1), Var#= Value;
        later_bound(BB0, BB1), Var#\= Value 
    ).

generate2(PuzzleNumber, Size, NumHints).

puzzle_path(Path) :-
    current_directory(Dir),
    atom_concat(Dir, 'puzzles.pl', Path).

save_puzzle(PuzzleNumber, Col, Row) :-
    puzzle_path(PuzzlePath),
    Term =.. ['puzzle', PuzzleNumber, Col, Row],
    open(PuzzlePath, append, Stream),
    write(Stream, '\n'),
    write_term(Stream, Term, []),
    write(Stream, '.\n'),
    close(Stream),
    format('Puzzle number ~d saved successfuly!~n', [PuzzleNumber]),
    reconsult(PuzzlePath).
