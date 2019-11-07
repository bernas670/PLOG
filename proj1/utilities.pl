% TODO: document this code

getListItem([Item|_], 0, Item).
getListItem([_|List], Index, Item) :-
    Index > 0,
    NewIndex is Index - 1,
    getListItem(List, NewIndex, Item).


setListItem([_|T], 0, Item, [Item|T]).
setListItem([H|T], Index, Item, [H|RT]) :-
    Index > 0,
    NewIndex is Index - 1,
    setListItem(T, NewIndex, Item, RT).


getMatrixItem([H|_], 0, Column, Item) :-
    getListItem(H, Column, Item).
getMatrixItem([_|Matrix], Row, Column, Item) :-
    Row > 0,
    NewRow is Row - 1,
    getMatrixItem(Matrix, NewRow, Column, Item).


setMatrixItem([H|T], 0, Column, Item, [NewH|T]) :-
    setListItem(H, Column, Item, NewH).
setMatrixItem([H|T], Row, Column, Item, [H|NewT]) :-
    Row > 0,
    NewRow is Row - 1,
    setMatrixItem(T, NewRow, Column, Item, NewT).

copyList([], []).
copyList([H|OriginT], [H|CopyT]) :-
    copyList(OriginT, CopyT).

copyMatrix([], []).
copyMatrix([OriginH|OriginT], [CopyH|CopyT]) :-
    copyList(OriginH, CopyH),
    copyMatrix(OriginT, CopyT).


countItemsList([], _Item, 0).
countItemsList([H|T], Item, Count) :-
    Item == H,
    !,
    countItemsList(T, Item, Count1),
    Count is Count1 + 1.
countItemsList([_|T], Item, Count) :-
    countItemsList(T, Item, Count).

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



