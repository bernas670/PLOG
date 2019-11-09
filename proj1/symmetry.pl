
axisOrientation('Horizontal', 0).
axisOrientation('Vertical', 1).

/*
axialSymmetry(Board, Orientation, AxisIndex, Positions, NewBoard) :-
    axisOrientation(Orientation, ColIndex),
    getMatrixColumn(Board, ColIndex, Coords),
    max_list(Coords, Max),

    ((Max >= AxisIndex) ->
    (
        % do the thingy    
    );
    (
        min_list(Coords, Min),
        ((Min < AxisIndex) ->
        (
            %true
        );
        (
            %false  
        )
        )
    )).
*/
%makeSymmetry(Positions, Orientation, Axis, Factor, NewPositions)


% Calculate the symmetric coordinate to Coord in relation to Axis
% When the axis index is greater or equal to the coord
blockAxialSymmetry(Coord, Axis, NewCoord) :-
    Coord >= Axis,
    NewCoord is Coord + (Axis - Coord) * 2 + 1.
% When the axis index is smaller than the coord
blockAxialSymmetry(Coord, Axis, NewCoord) :-
    NewCoord is Coord + (Coord - Axis - 1) * (-2) - 1.


% Calculate the symmetric coordinates to Coords in relation
% to the point that is the intersection of HAxis and VAxis
blockPointSymmetry(Coords, HAxis, VAxis, NewCoords) :-
    getListItem(Coords, 0, Row),
    blockAxialSymmetry(Row, HAxis, NewRow),
    getListItem(Coords, 1, Col),
    blockAxialSymmetry(Col, VAxis, NewCol),
    append([NewRow], [NewCol], NewCoords).
