print_board_rec([], _, _).
print_board_rec([L|T], N, Axis) :-
    format('~|~`0t~d~2+', [N]),
    print_line(L),
    print_separator(N, Axis),
    N1 is N + 1,
    Axis1 is Axis + 1,
    print_board_rec(T, N1, Axis1).

print_separator(10, _) :-
    format('~n   ┼────┼────┼────┼────┼────┼────┼────┼────┼────┼────┼ ~n').
print_separator(N, A) :-
    N < 10,
    format('~n   ┼────┼────┼────┼────┼────┼────┼────┼────┼────┼────┼ ~c~n', [A]).


print_board(B) :-
    write('     01   02   03   04   05   06   07   08   09   10   '), nl,
    write('   ┼────┼────┼────┼────┼────┼────┼────┼────┼────┼────┼ '), nl,
    print_board_rec(B, 1, 65),
    write('        R    Q    P    O    N    M    L    K    J      '), nl.


print_line([]) :-
    write(' │ ').
print_line([C|L]) :-
    write(' │ '),
    print_cell(C),
    print_line(L).

print_cell(C) :-
    tr(C, P),
    piece_color(C, RGB),
    ansi_format([bg(RGB)], '~w', [P]).

tr(0, '  ').    /* empty slot */
tr(1, '  ').    /* player 1 pieces */
tr(2, '  ').    /* player 2 pieces */
tr(3, '  ').    /* castle */

piece_color(0, black).
piece_color(1, red).
piece_color(2, cyan).
piece_color(3, white).

initBoard([ [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 1, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 2, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 3, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 1, 0, 0, 0, 0, 0],
            [0, 0, 0, 0, 0, 0, 0, 0, 0, 0]]).

start :- initBoard(B), print_board(B).