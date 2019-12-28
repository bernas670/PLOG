labeling_test(Number, Options, Board) :-
    puzzle(Number, Col, Row),
    format('~nPuzzle Nr ~d~n~n', [Number]),
    statistics(walltime, [Start, _]),
    solve_puzzle(Options, Col, Row, Board),
    statistics(walltime, [End, _]),
    print_board(Board, Col, Row),
    Time is End - Start,
    format('~nExecution time : ~3d s~n~n', [Time]).

labeling_test(Options) :-
    it_test(Options, 1).
    
it_test(Options, Number) :-
    puzzle(Number, Col, Row),
    statistics(walltime, [Start, _]),
    solve_puzzle(Options, Col, Row, _), !,
    statistics(walltime, [End, _]),
    Time is End - Start,
    format('puzzle: ~|~`0t~d~2+ time : ~3d s~n', [Number, Time]),
    NNumber is Number + 1, !,
    it_test(Options, NNumber).