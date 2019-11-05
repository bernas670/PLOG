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
    ansi_format([bg(black)], '                                                            ', []), nl,   
    ansi_format([bg(black)], '                                                            ', []), nl.

askOption :-
    ansi_format([bg(black)], '     Waiting for option...                                  ', []), nl.

manageInput(1) :-
    nl,
    write('Player VS Player'),
    nl.

manageInput(2) :-
    nl,
    write('Player VS Computer'),
    nl.

manageInput(3) :-
    nl,
    write('Computer VS Computer'),
    nl.

manageInput(0) :-
    nl,
    write('Exiting Ctrl+V ...'),
    nl.

manageInput(_Other) :-
    ansi_format([bg(black), fg(red)], '               Invalid input! Exiting Ctrl+V.               ', []), nl.
