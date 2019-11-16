% TODO: document this code

% get list element at index
getListItem([Item|_], 0, Item).
getListItem([_|List], Index, Item) :-
    Index > 0,
    NewIndex is Index - 1,
    getListItem(List, NewIndex, Item).

% set a list item and returns the new list
setListItem([_|T], 0, Item, [Item|T]).
setListItem([H|T], Index, Item, [H|RT]) :-
    Index > 0,
    NewIndex is Index - 1,
    setListItem(T, NewIndex, Item, RT).

% get a matrix item at a certain row and column
getMatrixItem([H|_], 0, Column, Item) :-
    getListItem(H, Column, Item).
getMatrixItem([_|Matrix], Row, Column, Item) :-
    Row > 0,
    NewRow is Row - 1,
    getMatrixItem(Matrix, NewRow, Column, Item).

% set a matrix item at a certain row and column
setMatrixItem([H|T], 0, Column, Item, [NewH|T]) :-
    setListItem(H, Column, Item, NewH).
setMatrixItem([H|T], Row, Column, Item, [H|NewT]) :-
    Row > 0,
    NewRow is Row - 1,
    setMatrixItem(T, NewRow, Column, Item, NewT).

% copy a list to another one
copyList([], []).
copyList([H|OriginT], [H|CopyT]) :-
    copyList(OriginT, CopyT).

% copy a matrix to a new matrix
copyMatrix([], []).
copyMatrix([OriginH|OriginT], [CopyH|CopyT]) :-
    copyList(OriginH, CopyH),
    copyMatrix(OriginT, CopyT).

% counts how many times an item appears at a list
countItemsList([], _Item, 0).
countItemsList([H|T], Item, Count) :-
    Item == H,
    !,
    countItemsList(T, Item, Count1),
    Count is Count1 + 1.
countItemsList([_|T], Item, Count) :-
    countItemsList(T, Item, Count).

% counts how many times an item appears at a matrix
countItemsMatrix([], _Item, 0).
countItemsMatrix([H|T], Item, Count):-
    countItemsList(H, Item, Count2),
    countItemsMatrix(T, Item, Count1),
    Count is Count1 + Count2.

% Get the column with ColIndex from a matrix
getMatrixColumn([], _Column, []).
getMatrixColumn([PositionsH|PositionsT], ColIndex, [RowH|RowT]) :-
    getListItem(PositionsH, ColIndex, RowH),
    getMatrixColumn(PositionsT, ColIndex, RowT).



getLongestList([L], L) :-
    !.
getLongestList([H|T], H) :- 
    length(H, N),
    write('head : '), write(N), nl,
    getLongestList(T, X),
    length(X, M),
    write('best : '), write(M), nl,
    N >= M,
    !.
getLongestList([_|T], X) :-
    getLongestList(T, X),
    !.

/*

FIXME: not used

% get the max value of a list
max_list([H|T], R):- max(T, H, R). 
max([], R, R). 
max([H|T], AUX, R):- H >  AUX, max(T, H, R). 
max([H|T], AUX, R):- H =< AUX, max(T, AUX, R).


*/
