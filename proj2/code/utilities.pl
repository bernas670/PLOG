% it_col(Col, Board) :- it_col(Col, 0, Board).
% it_col([], _NCol, []).
% it_col([HCol|TCol], NCol, Board) :- 
%     get_col(Board, NCol, Column),
%     exactly(1, Column, 2),
%     space_rest(HCol, Column),
%     NNCol is NCol + 1,
%     it_col(TCol, NNCol, Board).


% % get a list that contains the elements of the column with index NCol
% get_col([], _NCol, []).
% get_col([HMatrix|TMatrix], NCol, [HList|TList]) :-
%     nth0(NCol, HMatrix, HList),
%     get_col(TMatrix, NCol, TList).


% true if X occurs exactly N times in the list L
exactly(_, [], 0).
exactly(X, [Y|L], N) :-
    X #= Y #<=> B,
    N #= M+B,
    exactly(X, L, M).


surround_rest(CurPos, PrvPos, OutPos) :-
    CurIPos-CurFPos = CurPos,
    PrvIPos-PrvFPos = PrvPos,

    CurIPos #\= PrvIPos - 1, CurIPos #\= PrvIPos + 1, 
    CurIPos #\= PrvFPos - 1, CurIPos #\= PrvFPos + 1, 
    
    CurFPos #\= PrvIPos - 1, CurFPos #\= PrvIPos + 1, 
    CurFPos #\= PrvFPos - 1, CurFPos #\= PrvFPos + 1, 

    OutPos = CurIPos-CurFPos.