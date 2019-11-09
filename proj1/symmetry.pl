axisOrientation('H', 0).
axisOrientation('V', 1).

isEmpty(Board, Coords) :-
    getListItem(Coords, 0, Row),    
    getListItem(Coords, 1, Column),    
    getMatrixItem(Board, Row, Column, Piece),
    Piece == 0.

axialSymmetryPositions(_Board, [], _Orientation, _Axis, []).
axialSymmetryPositions(Board, [HPos|TPos], Orientation, Axis, [HRes|TRes]) :-
    axisOrientation(Orientation, ColIndex),
    getListItem(HPos, ColIndex, Coord),
    blockAxialSymmetry(Coord, Axis, NewCoord),
    NewCoord >= 0, NewCoord =< 9,
    setListItem(HPos, ColIndex, NewCoord, HRes),
    isEmpty(Board, HRes),
    axialSymmetryPositions(Board, TPos, Orientation, Axis, TRes).

pointSymmetryPositions(_Board, [], _HAxis, _VAxis, []).
pointSymmetryPositions(Board, [HPos|TPos], HAxis, VAxis, [HRes|TRes]) :-
    blockPointSymmetry(HPos, HAxis, VAxis, HRes),
    getListItem(HRes, 0, Row),
    Row >= 0, Row =< 9,
    getListItem(HRes, 1, Col),
    Col >= 0, Col =< 9,
    isEmpty(Board, HRes),
    pointSymmetryPositions(Board, TPos, HAxis, VAxis, TRes).

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
