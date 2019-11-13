% TODO: beautify the main menu


% Main menu
mainMenu :-
    printMainMenu,
    askOption,
    read(Input),
    manageInput(Input).

botMenu1(BotLevel) :-
    printBotMenu1,
    askOption,
    read(Input),
    manageBotInput(Input, BotLevel).

botMenu2(BotLevel) :-
    printBotMenu2,
    askOption,
    read(Input),
    manageBotInput(Input, BotLevel).


botMenu3(BotLevel1, BotLevel2) :-
    printBotMenu2,
    askOption,
    read(Input1),
    manageBotInput(Input1, BotLevel1),
    printBotMenu1,
    askOption,
    read(Input2),
    manageBotInput(Input2, BotLevel2),
    manageBot(BotLevel1, BotLevel2).


% Print the main menu
printMainMenu :- 
    ansi_format([bg(black)], '                                                            ', []), nl,
    ansi_format([bg(black)], '   ┼────────────────────────────────────────────────────┼   ', []), nl,
    ansi_format([bg(black)], '   │                                                    │   ', []), nl,
    ansi_format([bg(black)], '   │                                                    │   ', []), nl,
    ansi_format([bg(black)], '   │         ____ _        _          __     __         │   ', []), nl,
    ansi_format([bg(black)], '   │        / ___| |_ _ __| |    _    \\ \\   / /         │   ', []), nl,
    ansi_format([bg(black)], '   │       | |   | __|  __| |  _| |_   \\ \\ / /          │   ', []), nl,
    ansi_format([bg(black)], '   │       | |___| |_| |  | | |_   _|   \\ V /           │   ', []), nl,
    ansi_format([bg(black)], '   │        \\____|\\__|_|  |_|   |_|      \\_/            │   ', []), nl,
    ansi_format([bg(black)], '   │                                                    │   ', []), nl,
    ansi_format([bg(black)], '   │                                                    │   ', []), nl,
    ansi_format([bg(black)], '   │                                                    │   ', []), nl,
    ansi_format([bg(black)], '   │             1) Player VS Player                    │   ', []), nl,
    ansi_format([bg(black)], '   │             2) Player VS Computer                  │   ', []), nl,
    ansi_format([bg(black)], '   │             3) Computer VS Player                  │   ', []), nl,
    ansi_format([bg(black)], '   │             4) Computer VS Computer                │   ', []), nl,
    ansi_format([bg(black)], '   │                                                    │   ', []), nl,
    ansi_format([bg(black)], '   │             5) Rules                               │   ', []), nl,
    ansi_format([bg(black)], '   │             0) Quit                                │   ', []), nl,
    ansi_format([bg(black)], '   │                                                    │   ', []), nl,
    ansi_format([bg(black)], '   │                     by : Bernardo Santos           │   ', []), nl,
    ansi_format([bg(black)], '   │                           & Vítor Gonçalves        │   ', []), nl,
    ansi_format([bg(black)], '   │                                                    │   ', []), nl,
    ansi_format([bg(black)], '   │                                                    │   ', []), nl,
    ansi_format([bg(black)], '   ┼────────────────────────────────────────────────────┼   ', []), nl,
    ansi_format([bg(black)], '                                                            ', []), nl.

printRulesMenu:-
    ansi_format([bg(black)], '                                                            ', []), nl,
    ansi_format([bg(black)], '   ┼────────────────────────────────────────────────────┼   ', []), nl,
    ansi_format([bg(black)], '   │  ', []), 
    ansi_format([bg(black), fg(red)], '                   R U L E S                  ', []),
    ansi_format([bg(black)], '    │   ', []), nl,
    ansi_format([bg(black)], '   │                                                    │   ', []), nl,
    ansi_format([bg(black)], '   │ At the beginning, both players place 2 castle      │   ', []), nl,
    ansi_format([bg(black)], '   │ pieces that will only serve as obstacles.          │   ', []), nl,
    ansi_format([bg(black)], '   │                                                    │   ', []), nl,
    ansi_format([bg(black)], '   │ Immediately after, each player places a piece      │   ', []), nl,
    ansi_format([bg(black)], '   │ of their own in an empty place.                    │   ', []), nl,
    ansi_format([bg(black)], '   │                                                    │   ', []), nl,
    ansi_format([bg(black)], '   │ Until the end of the game, alternately each player │   ', []), nl,
    ansi_format([bg(black)], '   │ must select a valid position of their own pieces   │   ', []), nl,
    ansi_format([bg(black)], '   │ already on the board, and using the axes make      │   ', []), nl,
    ansi_format([bg(black)], '   │ symmetries to place new pieces.                    │   ', []), nl,
    ansi_format([bg(black)], '   │                                                    │   ', []), nl,
    ansi_format([bg(black)], '   │ Symmetries can be vertical, horizontal and also    │   ', []), nl,
    ansi_format([bg(black)], '   │ over points.                                       │   ', []), nl,
    ansi_format([bg(black)], '   │                                                    │   ', []), nl,
    ansi_format([bg(black)], '   │ The game is over when there are no more valid      │   ', []), nl,
    ansi_format([bg(black)], '   │ moves for any player. At this point, the one that  │   ', []), nl,
    ansi_format([bg(black)], '   │ has the most pieces on the board is the winner.    │   ', []), nl,
    ansi_format([bg(black)], '   │                                                    │   ', []), nl,
    ansi_format([bg(black)], '   │                                                    │   ', []), nl,
    ansi_format([bg(black)], '   │  ', []), 
    ansi_format([bg(black), fg(cyan)], '                  Have fun :D                 ', []),
    ansi_format([bg(black)], '    │   ', []), nl,
    ansi_format([bg(black)], '   ┼────────────────────────────────────────────────────┼   ', []), nl,
    ansi_format([bg(black)], '                                                            ', []), nl.

printBotMenu1 :-
    ansi_format([bg(black)], '                                                            ', []), nl,
    ansi_format([bg(black)], '   ┼────────────────────────────────────────────────────┼   ', []), nl,
    ansi_format([bg(black)], '   │', []),
    ansi_format([bg(black),fg(cyan)], '                 Choose computer level   ', []),
    ansi_format([bg(black)], '           │   ', []), nl,
    ansi_format([bg(black)], '   │                                                    │   ', []), nl,
    ansi_format([bg(black)], '   │                     1) Random                      │   ', []), nl,
    ansi_format([bg(black)], '   │                     2) Greedy                      │   ', []), nl,
    ansi_format([bg(black)], '   │                                                    │   ', []), nl, 
    ansi_format([bg(black)], '   ┼────────────────────────────────────────────────────┼   ', []), nl,
    ansi_format([bg(black)], '                                                            ', []), nl.

printBotMenu2 :-
    ansi_format([bg(black)], '                                                            ', []), nl,
    ansi_format([bg(black)], '   ┼────────────────────────────────────────────────────┼   ', []), nl,
    ansi_format([bg(black)], '   │', []),
    ansi_format([bg(black),fg(red)], '                 Choose computer level   ', []),
    ansi_format([bg(black)], '           │   ', []), nl,
    ansi_format([bg(black)], '   │                                                    │   ', []), nl,
    ansi_format([bg(black)], '   │                     1) Random                      │   ', []), nl,
    ansi_format([bg(black)], '   │                     2) Greedy                      │   ', []), nl,
    ansi_format([bg(black)], '   │                                                    │   ', []), nl, 
    ansi_format([bg(black)], '   ┼────────────────────────────────────────────────────┼   ', []), nl,
    ansi_format([bg(black)], '                                                            ', []), nl.



    

% Prompt when the game is waiting for an option
askOption :-
    ansi_format([bg(black)], '                   Waiting for option...                    ', []), nl.

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
    botMenu1(BotLevel),
    write(BotLevel),
    startGame('P', 'C').

% If the user input is 3 start the game as computer vs player
manageInput(3) :-
    ansi_format([bg(black)], '                                                            ', []), nl,
    ansi_format([bg(black)], '                 Computer VS Player chosen!                 ', []), nl,
    ansi_format([bg(black)], '                                                            ', []), nl,
    botMenu2(BotLevel),
    write(BotLevel),
    startGame('C', 'P').

% If the user input is 3 start the game as computer vs computer
manageInput(4) :-
    ansi_format([bg(black)], '                                                            ', []), nl,
    ansi_format([bg(black)], '                Computer VS Computer chosen!                ', []), nl,
    ansi_format([bg(black)], '                                                            ', []), nl,
    botMenu3(BotLevel1, BotLevel2),
    write(BotLevel1),
    write('   '), write(BotLevel2).
    %startGame('C', 'C').

% If the user input is 5 display the rules
manageInput(5) :-
    printRulesMenu, nl,
    mainMenu.
   
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

manageBotInput(1, Bot) :- Bot is 1.

manageBotInput(2, Bot) :- Bot is 2.

manageBotInput(_Other, BotLevel) :-
    askOption,
    read(Input),
    manageBotInput(Input, BotLevel).

manageBot(1,2) :-
    ansi_format([bg(black)], '                                                            ', []), nl,
    ansi_format([bg(black), fg(red)], '               Random level choosen for computer 1          ', []), nl,
    ansi_format([bg(black), fg(red)], '               Greedy level choosen for computer 2          ', []), nl,
    ansi_format([bg(black)], '                                                            ', []), nl.

manageBot(2,1) :-
    ansi_format([bg(black)], '                                                            ', []), nl,
    ansi_format([bg(black), fg(red)], '               Greedy level choosen for computer 1          ', []), nl,
    ansi_format([bg(black), fg(red)], '               Random level choosen for computer 2          ', []), nl,
    ansi_format([bg(black)], '                                                            ', []), nl.

manageBot(1,1) :-
    ansi_format([bg(black)], '                                                            ', []), nl,
    ansi_format([bg(black), fg(red)], '               Random level choosen for computer 1          ', []), nl,
    ansi_format([bg(black), fg(red)], '               Random level choosen for computer 2          ', []), nl,
    ansi_format([bg(black)], '                                                            ', []), nl.

manageBot(2,2) :-
    ansi_format([bg(black)], '                                                            ', []), nl,
    ansi_format([bg(black), fg(red)], '               Greedy level choosen for computer 1          ', []), nl,
    ansi_format([bg(black), fg(red)], '               Greedy level choosen for computer 2          ', []), nl,
    ansi_format([bg(black)], '                                                            ', []), nl.



    

    
