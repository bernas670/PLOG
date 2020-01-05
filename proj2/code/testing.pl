% Predicate used for collecting data about varying labeling 
% options for one puzzle
% 
% Number - puzzle's number
% Options - labeling options
% Iterations - number of times the puzzle solver is executed
labeling_test(Number, Options, Iterations) :-
    get_puzzle_times(Number, Iterations, Options, Times),
    write(Times), nl,
    sumlist(Times, SumTimes),
    length(Times, Length),
    Average is round(SumTimes / Length),
    format('Average : ~3d s ~n', [Average]).

% Predicate used for collecting data about varying labeling 
% options for all puzzles, saves the output to the file data.txt
% 
% Options - labeling options
% Iterations - number of times the solver is executed for each puzzle
labeling_test(Options, Iterations) :-
    data_path(Path),
    open(Path, append, Stream),
    format(Stream, '~n ----==== ', []), write(Stream, Options), format(Stream, ' ====---- ~n', []),
    it_test(Stream, Iterations, Options, 1),
    close(Stream).

% Get a list of execution times for a puzzle
% 
% PuzzleNumber - number of the puzzle that will be solved
% Iteration - number of the iteration
% Options - labeling options
% Times - list of execution times
get_puzzle_times(_, 0, _, []) :- !.
get_puzzle_times(PuzzleNumber, Iteration, Options, [HTime|TTime]) :-
    puzzle(PuzzleNumber, Col, Row),
    statistics(walltime, [Start, _]),
    solve_puzzle(Options, Col, Row, _),
    statistics(walltime, [End, _]),
    HTime is End - Start,
    NIteration is Iteration - 1,
    get_puzzle_times(PuzzleNumber, NIteration, Options, TTime).

% 
it_test(Stream, Iterations, Options, Number) :-
    get_puzzle_times(Number, Iterations, Options, Times),
    sumlist(Times, SumTimes),
    length(Times, Length),
    Average is round(SumTimes / Length),
    format(Stream, '~3d~n', [Average]),

    NNumber is Number + 1, !,
    it_test(Stream, Iterations, Options, NNumber).
it_test(_, _, _, _).
    
data_path(Path) :-
    current_directory(Dir),
    atom_concat(Dir, 'data.txt', Path).
