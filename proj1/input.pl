askCoords(Row, Column) :-
    askCoord(Row, 'Row'),
    askCoord(Column, 'Column').

askCoord(Coord, String) :-
    % FIXME: spacing on the print
    ansi_format([bg(black)], '    ~w  ', [String]),
    read(Input),
    validateCoord(Input, Coord, String).

validateCoord(01, Coord, _String) :- Coord is 0.
validateCoord(02, Coord, _String) :- Coord is 1.
validateCoord(03, Coord, _String) :- Coord is 2.
validateCoord(04, Coord, _String) :- Coord is 3.
validateCoord(05, Coord, _String) :- Coord is 4.
validateCoord(06, Coord, _String) :- Coord is 5.
validateCoord(07, Coord, _String) :- Coord is 6.
validateCoord(08, Coord, _String) :- Coord is 7.
validateCoord(09, Coord, _String) :- Coord is 8.
validateCoord(10, Coord, _String) :- Coord is 9.
validateCoord(_Input, Coord, String) :- askCoord(Coord, String).

% TODO: implement a term that clears the input buffer


askSymmetry:-
    printSymmetryMenu,
    askSymmetryOption,
    read(Answer),
    manage_input(Answer).


printSymmetryMenu:-
    ansi_format([bg(black)], '                 1) Axis Symmetry                        ', []), nl,
    ansi_format([bg(black)], '                 2) Point Symmetry                       ', []), nl.


askSymmetryOption:-
    ansi_format([bg(black)], 'Waiting for option...                                    ', []), nl.


manage_input(1):-
    ansi_format([bg(black)], '                  Axis Symmetry choosen!                  ', []), nl,
    ansi_format([bg(black)], '                  Choose Axis                             ', []),nl,
    askAxis(Axis, String),
    write(Axis),
    write(-),
    write(String),nl.


manage_input(2):-
    ansi_format([bg(black)], '                  Point Symmetry choosen!                ', []), nl,
    ansi_format([bg(black)], '                  Choose Horizontal axis!                ', []), nl,
    askAxis(Axis,'Horizontal'),
    ansi_format([bg(black)], '                  Choose Vertical axis!                  ', []), nl,
    askAxis(Axis2,'Vertical').


manage_input(_Other):-
    ansi_format([bg(black), fg(red)], '                     Invalid input!                      ', []), nl,
    askSymmetryOption,
    read(Answer),
    manage_input(Answer).


askAxis(Axis, String) :-
    get_char(Input),
    validateAxis(Input, Axis, String).

validateAxis('A', Axis, 'Horizontal') :- Axis is 0.
validateAxis('B', Axis, 'Horizontal') :- Axis is 1.
validateAxis('C', Axis, 'Horizontal') :- Axis is 2.
validateAxis('D', Axis, 'Horizontal') :- Axis is 3.
validateAxis('E', Axis, 'Horizontal') :- Axis is 4.
validateAxis('F', Axis, 'Horizontal') :- Axis is 5.
validateAxis('G', Axis, 'Horizontal') :- Axis is 6.
validateAxis('H', Axis, 'Horizontal') :- Axis is 7.
validateAxis('I', Axis, 'Horizontal') :- Axis is 8.

validateAxis('J', Axis, 'Vertical') :- Axis is 0.
validateAxis('K', Axis, 'Vertical') :- Axis is 1.
validateAxis('L', Axis, 'Vertical') :- Axis is 2.
validateAxis('M', Axis, 'Vertical') :- Axis is 3.
validateAxis('N', Axis, 'Vertical') :- Axis is 4.
validateAxis('O', Axis, 'Vertical') :- Axis is 5.
validateAxis('P', Axis, 'Vertical') :- Axis is 6.
validateAxis('Q', Axis, 'Vertical') :- Axis is 7.
validateAxis('R', Axis, 'Vertical') :- Axis is 8.

validateAxis(_Input, Axis, String) :- 
    askAxis(Axis, String).


/*
    readInteger(Integer) :-
        readInput(Integer),
        integer(Integer).

    readInput(Input) :-
        get0(Char),
        readRest(Char, String),
        name(Input, String).

    readRest(10, []).
    readRest(13, []).
    readRest(Char, [Char|Rest]) :-
        get0(Char1),
        readRest(Char1, Rest).
*/