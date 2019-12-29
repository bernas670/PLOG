print_board(Board, Col, Row) :-
    write('     '),
    print_col(Col),
    write('    |'),
    print_line(Col),
    print_row(Row, Board),
    !.

print_row([], []).
print_row([HRow|TRow], [HBoard|TBoard]) :-
    var(HRow),
    format('    |', []),
    print_elems(HBoard),
    format('    |', []),
    print_line(HBoard),
    print_row(TRow, TBoard).
print_row([HRow|TRow], [HBoard|TBoard]) :-
    format('~|~`0t~d~3+ |', [HRow]),
    print_elems(HBoard),
    format('    |', []),
    print_line(HBoard),
    print_row(TRow, TBoard).

print_col([]) :- nl.
print_col([H|T]) :-
    var(H),
    write('    '),
    print_col(T).
print_col([H|T]) :-
    format('~|~`0t~d~3+ ', [H]),
    print_col(T).

print_line([]) :- nl.
print_line([_|T]) :-
    format('---|', []),
    print_line(T).

print_elems([]) :- nl.
print_elems([H|T]) :-
    var(H),
    format('  ', []),
    print_elems(T).
print_elems([H|T]) :-
    format(' ~d |', [H]),
    print_elems(T).
