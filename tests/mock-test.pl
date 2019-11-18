%participant(Id,Age,Performance)
participant(1234, 17, 'Pé coxinho').
participant(3423, 21, 'Programar com os pés').
participant(3788, 20, 'Sing a Bit').
participant(4865, 22, 'Pontes de esparguete').
participant(8937, 19, 'Pontes de pen-drives').
participant(2564, 20, 'Moodle hack').

%performance(Id,Times)
performance(1234,[120,120,120,120]).
performance(3423,[32,120,45,120]).
performance(3788,[110,2,6,43]).
performance(4865,[120,120,110,120]).
performance(8937,[97,101,105,110]).


% QUESTION 1
isMember(X, [X|_]) :- !.
isMember(X, [_|T]) :-
    isMember(X, T). 

madeItThrough(Participant) :-
    performance(Participant, Times),
    isMember(120, Times).
    

% QUESTION 2

% getListItem(List, Index, Item)
getListItem([Item|_], 1, Item) :- !.
getListItem([_|T], Index, Item) :-
    NIndex is Index - 1,
    getListItem(T, NIndex, Item).

% juriTimes(Participants, JuriMember, Times, Total)
juriTimes([], _JuriMember, [], 0).
juriTimes([HPart|TPart], JuriMember, [HTimes|TTimes], Total) :-
    performance(HPart, PTimes),
    getListItem(PTimes, JuriMember, HTimes),
    juriTimes(TPart, JuriMember, TTimes, NTotal),
    Total is NTotal + HTimes.


% QUESTION 3

patientJuri(JuriMember) :-
    performance(Id, List),
    getListItem(List, JuriMember, Item),
    Item == 120,
    performance(Id2, List2),
    getListItem(List2, JuriMember, Item2),
    Item2 == 120,
    Id \= Id2.


% QUESTION 4

% sumList(+List, -Sum)
sumList([], 0).
sumList([H|T], Sum) :-
    sumList(T, NSum),
    Sum is NSum + H.

% bestParticipant(+P1, +P2, -P)
bestParticipant(P1, P2, P1) :-
    performance(P1, T1),
    sumList(T1, S1),
    performance(P2, T2),
    sumList(T2, S2),
    S1 > S2.
bestParticipant(P1, P2, P2) :-
    performance(P1, T1),
    sumList(T1, S1),
    performance(P2, T2),
    sumList(T2, S2),
    S1 < S2.


% QUESTION 5

allPerfs :-
    participant(ID, _Age, Performance),
    performance(ID, Times),
    write(ID), write(':'), write(Performance), write(':'), write(Times), nl,
    fail. 
allPerfs.


% QUESTION 6

noClick(Participant) :-
    performance(Participant, Times),
    noClicks(Times).

noClicks([]).
noClicks([H|T]) :-
    H == 120, !,
    noClicks(T).


nSuccessfulParticipants(T) :-
    setof(Participant, noClick(Participant), Participants),
    length(Participants, T).

% QUESTION 7

fanList(Participant, FanList) :-
    performance(Participant, Times),
    getFans(Times, 1, Fans),
    FanList = Participant-Fans.

getFans([], _Index, []).
getFans([HT|TT], Index, [Index|TF]) :-
    HT == 120, !,
    NIndex is Index + 1,
    getFans(TT, NIndex, TF).
getFans([_|TT], Index, Fans) :-
    NIndex is Index + 1, 
    getFans(TT, NIndex, Fans).

juriFans(JuriFansList) :-
    findall(FanList, fanList(_Participant, FanList), JuriFansList).


% QUESTION 8
% TODO:
eligibleOutcome(Id,Perf,TT) :-
    performance(Id,Times),
    madeItThrough(Id),
    participant(Id,_,Perf),
    sumList(Times,TT).

getFirstN(_, 0, []).
getFirstN([H|TL], N, [H|TR]) :-
    NN is N - 1,
    getFirstN(TL, NN, TR).

nextPhase(N, Participants) :-
    setof(TT-Id-Perf, eligibleOutcome(Id, Perf, TT), AllPart),
    reverse(AllPart, RevPart),
    write(RevPart),
    getFirstN(RevPart, N, Participants).
    


% QUESTION 9

% participant(Id, Age, Performance)
% predX(AgeCap, ParticipantList, PerformanceList)
predX(Q,[R|Rs],[P|Ps]) :-
    participant(R,I,P),
    I =< Q, !, % participants age <= Q
    predX(Q,Rs,Ps).
predX(Q,[R|Rs],Ps) :-
    participant(R,I,_),
    I > Q, % participants age > Q
    predX(Q,Rs,Ps).
predX(_,[],[]).

% What does the predicate do ?
% Get the performances of the partipants on the provided
% list whose age is smaller than Q

% Green cut or red cut ?
% Green cut, because it does not alter the results,
% it only makes the predicate more efficient


% QUESTION 10
% [2, 3, 1, 2, 1, 3]
% [2, 3, 4, 2, 1, 3, 1, 4]
impoe(X,L) :-
    length(Mid,X),
    append(L1,[X|_],L), append(_,[X|Mid],L1).
% Explain the predicate impoe(X,L)
% The first append gets the list L1 that contains all the elements before the last X,
% the second append gets the list Mid which contains the elements between the two X's,
% if the Mid list has length X the predicate exits as true. impoe checks if a list 
% fills the parameters above mentioned in the specification

% QUESTION 11
% lanford(+N, -L)
langford(N, L) :-
    Length is N * 2,
    length(L, Length),
    langfordAux(N, L).

langfordAux(1, L) :-
    impoe(1, L).
langfordAux(N, L) :-
    impoe(N, L), 
    X is N - 1,
    langfordAux(X, L).
