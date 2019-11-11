askCoord(Coord, String) :-
    % TODO: make this prompt always 60 chars long
    ansi_format([bg(black)], '    ~w  ', [String]), nl,
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


askCoords(Row, Column) :-
    askCoord(Row, 'Row'),
    askCoord(Column, 'Column'),
    !.


askAxis(Axis, String) :-
    % TODO: make this prompt always 60 chars long
    ansi_format([bg(black)], '   ~w Axis:    ', [String]), nl,
    read(Input),
    validateAxis(Input, Axis, String).

validateAxis('a', Axis, 'Horizontal') :- Axis is 0.
validateAxis('b', Axis, 'Horizontal') :- Axis is 1.
validateAxis('c', Axis, 'Horizontal') :- Axis is 2.
validateAxis('d', Axis, 'Horizontal') :- Axis is 3.
validateAxis('e', Axis, 'Horizontal') :- Axis is 4.
validateAxis('f', Axis, 'Horizontal') :- Axis is 5.
validateAxis('g', Axis, 'Horizontal') :- Axis is 6.
validateAxis('h', Axis, 'Horizontal') :- Axis is 7.
validateAxis('i', Axis, 'Horizontal') :- Axis is 8.
validateAxis('j', Axis, 'Vertical') :- Axis is 8.
validateAxis('k', Axis, 'Vertical') :- Axis is 7.
validateAxis('l', Axis, 'Vertical') :- Axis is 6.
validateAxis('m', Axis, 'Vertical') :- Axis is 5.
validateAxis('n', Axis, 'Vertical') :- Axis is 4.
validateAxis('o', Axis, 'Vertical') :- Axis is 3.
validateAxis('p', Axis, 'Vertical') :- Axis is 2.
validateAxis('q', Axis, 'Vertical') :- Axis is 1.
validateAxis('r', Axis, 'Vertical') :- Axis is 0.
validateAxis(_Input, Axis, String) :- askAxis(Axis, String).


askPoint(HAxis, VAxis) :-
    ansi_format([bg(black)], '                     Point Coordinates                      ', []), nl,
    askAxis(HAxis, 'Horizontal'),
    askAxis(VAxis, 'Vertical'),
    !.


askSymmetry(Symmetry) :-
    ansi_format([bg(black)], '    Symmetry type :                                         ', []), nl,
    ansi_format([bg(black)], '          1) Axial Horizontal                               ', []), nl,
    ansi_format([bg(black)], '          2) Axial Vertical                                 ', []), nl,
    ansi_format([bg(black)], '          3) Point                                          ', []), nl,
    ansi_format([bg(black)], '                  Waiting for an option...                  ', []), nl,
    read(Input),
    validateSymmetry(Input, Symmetry).

validateSymmetry(1, Symmetry) :- Symmetry is 1.
validateSymmetry(2, Symmetry) :- Symmetry is 2.
validateSymmetry(3, Symmetry) :- Symmetry is 3.
validateSymmetry(_Input, Symmetry) :- askSymmetry(Symmetry).
