:- consult('logic.pl').

% TODO: beautify the main menu


% Main menu
mainMenu :-
    printMainMenu,
    askOption,
    read(Input),
    manageInput(Input).

% Print the main menu
printMainMenu :- 
    ansi_format([bg(black)], '                                                            ', []), nl,
    ansi_format([bg(black)], '                                                            ', []), nl,
    ansi_format([bg(black)], '                                                            ', []), nl,
    ansi_format([bg(black)], '                                                            ', []), nl,
    ansi_format([bg(black)], '             ____ _        _          __     __             ', []), nl,
    ansi_format([bg(black)], '            / ___| |_ _ __| |    _    \\ \\   / /             ', []), nl,
    ansi_format([bg(black)], '           | |   | __|  __| |  _| |_   \\ \\ / /              ', []), nl,
    ansi_format([bg(black)], '           | |___| |_| |  | | |_   _|   \\ V /               ', []), nl,
    ansi_format([bg(black)], '            \\____|\\__|_|  |_|   |_|      \\_/                ', []), nl,
    ansi_format([bg(black)], '                                                            ', []), nl,
    ansi_format([bg(black)], '                                                            ', []), nl,
    ansi_format([bg(black)], '                                                            ', []), nl,
    ansi_format([bg(black)], '                 1) Player VS Player                        ', []), nl,
    ansi_format([bg(black)], '                 2) Player VS Computer                      ', []), nl,
    ansi_format([bg(black)], '                 3) Computer VS Computer                    ', []), nl,
    ansi_format([bg(black)], '                                                            ', []), nl,
    ansi_format([bg(black)], '                 0) Quit                                    ', []), nl,
    ansi_format([bg(black)], '                                                            ', []), nl,
    ansi_format([bg(black)], '                                                            ', []), nl,
    ansi_format([bg(black)], '                         by : Bernardo Santos               ', []), nl,
    ansi_format([bg(black)], '                               & Vítor Gonçalves            ', []), nl,
    ansi_format([bg(black)], '                                                            ', []), nl,
    ansi_format([bg(black)], '                                                            ', []), nl,
    ansi_format([bg(black)], '                                                            ', []), nl,
    ansi_format([bg(black)], '                                                            ', []), nl.

% 
askOption :-
    ansi_format([bg(black)], '   Waiting for option...                                    ', []), nl.

% If the user input is 1 start the game as player vs player
manageInput(1) :-
    ansi_format([bg(black)], '                                                            ', []), nl,
    ansi_format([bg(black)], '                  Player VS Player chosen!                  ', []), nl,
    ansi_format([bg(black)], '                                                            ', []), nl,
    startGame('P', 'P').

% If the user input is 2 start the game as player vs computer
manageInput(2) :-
    ansi_format([bg(black)], '                                                            ', []), nl,
    ansi_format([bg(black)], '                 Player VS Computer chosen!                 ', []), nl,
    ansi_format([bg(black)], '                                                            ', []), nl,
    startGame('P', 'C').

% If the user input is 3 start the game as computer vs computer
manageInput(3) :-
    ansi_format([bg(black)], '                                                            ', []), nl,
    ansi_format([bg(black)], '                Computer VS Computer chosen!                ', []), nl,
    ansi_format([bg(black)], '                                                            ', []), nl,
    startGame('C', 'C').

% If the user input is 0 quit the game
manageInput(0) :-
    ansi_format([bg(black)], '                                                            ', []), nl,
    ansi_format([bg(black)], '                     Quitting Ctrl+V :(                     ', []), nl,
    ansi_format([bg(black)], '                                                            ', []), nl.

% In case the user input is invalid display an error message and ask for a valid input again
manageInput(_Other) :-
    ansi_format([bg(black)], '                                                            ', []), nl,
    ansi_format([bg(black), fg(red)], '                       Invalid input!                       ', []), nl,
    ansi_format([bg(black)], '                                                            ', []), nl,
    askOption,
    read(Input),
    manageInput(Input).
