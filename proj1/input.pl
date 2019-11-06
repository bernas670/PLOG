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


% FIXME: not working
askAxis(Axis) :-
    ansi_format([bg(black)], '    Axis  ', []),
    read(Input),
    validateAxis(Input, Axis).

validateAxis('A', Axis) :- Axis is 0.
validateAxis('B', Axis) :- Axis is 1.
validateAxis('C', Axis) :- Axis is 2.
validateAxis('D', Axis) :- Axis is 3.
validateAxis('E', Axis) :- Axis is 4.
validateAxis('F', Axis) :- Axis is 5.
validateAxis('G', Axis) :- Axis is 6.
validateAxis('H', Axis) :- Axis is 7.
validateAxis('I', Axis) :- Axis is 8.

validateAxis('J', Axis) :- Axis is 0.
validateAxis('K', Axis) :- Axis is 1.
validateAxis('L', Axis) :- Axis is 2.
validateAxis('M', Axis) :- Axis is 3.
validateAxis('N', Axis) :- Axis is 4.
validateAxis('O', Axis) :- Axis is 5.
validateAxis('P', Axis) :- Axis is 6.
validateAxis('Q', Axis) :- Axis is 7.
validateAxis('R', Axis) :- Axis is 8.

validateAxis(_Input, Axis) :- askAxis(Axis).

