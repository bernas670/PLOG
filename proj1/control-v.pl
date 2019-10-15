terminate() :-
    write('Game closed'), nl.

checkNumPlayers(NumPlayers) :-
    (NumPlayers < 1 ; NumPlayers > 4),
    write('Invalid number of players!'), nl,
    terminate().

getNumPlayers(NumPlayers) :-
    write('Number of players (1-4): '),
    get_char(NumPlayersChar),
    atom_number(NumPlayersChar, NumPlayers).
    
initialize() :-
    getNumPlayers(NumPlayers),
    checkNumPlayers(NumPlayers).

play() :-
    initialize().


