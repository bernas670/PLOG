print_board([]).
print_board(Board, Col, Row) :-
    write('   '),
    print_elems(Col),
    print_row(Row, Board).

print_row([], []).
print_row([HRow|TRow], [HBoard|TBoard]) :-
    var(HRow),
    format('  |', []),
    print_elems(HBoard),
    print_row(TRow, TBoard).
print_row([HRow|TRow], [HBoard|TBoard]) :-
    format('~d |', [HRow]),
    print_elems(HBoard),
    print_row(TRow, TBoard).

    
print_elems([]) :- nl.
print_elems([H|T]) :-
    var(H),
    format('  ', []),
    print_elems(T).
print_elems([H|T]) :-
    format(' ~d', [H]),
    print_elems(T).
