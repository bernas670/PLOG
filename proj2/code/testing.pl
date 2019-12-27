
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