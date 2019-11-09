
axisOrientation('Horizontal', 0).
axisOrientation('Vertical', 1).

/*
axialSymmetry(Board, Orientation, AxisIndex, Positions, NewBoard) :-
    axisOrientation(Orientation, ColIndex),
    getMatrixColumn(Board, ColIndex, Coords),
    max_list(Coords, Max),  %implemented @utilities.pl

    ((Max >= AxisIndex) ->
    (
        % chamar uma função calcSymetryCoords que recebe uma lista de coordinates e utiliza a função calcSymetryCoord para cada elemento da lista
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
calcSymmetryCoord(Coord, Axis, 1, NewCoord) :-
    NewCoord is Coord + (Axis - Coord) * 2 + 1.
% When the axis index is smaller than the coord
calcSymmetryCoord(Coord, Axis, -1, NewCoord) :- 
    NewCoord is Coord + (Coord - Axis - 1) * (-2) - 1.


% Calculates new coords for a list of coords with the auxiliar func calcSymmetryCoord
/*calcSymetryCoords(Coords, Axis,1,NewCoords):-*/


