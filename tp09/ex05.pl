:-use_module(library(clpfd)).


% 1 = Blue, 2 = Yellow, 3 = Black, 4 = Green
%         car   car   car   car
%          1     2     3     4
% Color [     ,     ,     ,    ]
% Size  [     ,     ,     ,    ]
fila(Vars) :- 
    length(Color, 4), domain(Color, 1, 4), all_distinct(Color),
    length(Size, 4), domain(Size, 1, 4), all_distinct(Size),
    
    % associate the cars and colors
    element(PBlue,   Color, 1), 
    element(PYellow, Color, 2), 
    element(PBlack,  Color, 3), 
    element(PGreen,  Color, 4), 
    
    % the green car is the smallest car
    element(PGreen, Size, 1),
    
    % the green car is after the blue car
    PGreen #> PBlue,
    
    % the yellow car is after the black car
    PYellow #> PBlack,

    % get position of the car that is before and after the blue one
    PBeforeBlue #= PBlue - 1, PAfterBlue #= PBlue + 1,
    % get the size of the car that is before and after the blue one
    element(PBeforeBlue, Size, SBeforeBlue), element(PAfterBlue, Size, SAfterBlue), 
    % the car before the blue one is smaller than the one after the blue one
    SBeforeBlue #< SAfterBlue,
    
    append(Color, Size, Vars),
    labeling([], Vars).
