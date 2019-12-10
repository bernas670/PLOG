:-use_module(library(clpfd)).


count_equals(_, [], 0).
count_equals(Value, [H|T], Count) :-
    % check if the value is equal to the head of the list
    % in case the restriction is true B will equal 1
    Value #= H #<=> B,
    % add B to the Count
    Count #= M + B,
    count_equals(Value, T, M).