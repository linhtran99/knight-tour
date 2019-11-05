play:- write('Enter initial position: '), read(X/Y), go([X/Y],X/Y,24).

go(_,_,0):- write('Congratulation! You won.').
go(_,_,-1):-write('Deadlock! Game over.').
go(L,X/Y,N):-
    write('Enter next move: '), read(X1/Y1),                 % read in the next move
    check(L,X/Y,X1/Y1,N), !.                                 % check if the next move is legal

% if there is only one move left, no need to check if the final move will lead to deadlock
check(L,X/Y,X1/Y1,1):-
    move(X/Y,X1/Y1),
    \+member(X1/Y1,L),
    add(L,X1/Y1,L1),
    go(L1,X1/Y1,0).                                          % go to the end of game state

% if the new move is legal
check(L,X/Y,X1/Y1,N):-
    move(X/Y,X1/Y1),
    \+member(X1/Y1,L),
    add(L,X1/Y1,L1),
    M is N-1,
    move(X1/Y1,X2/Y2),
    \+member(X2/Y2,L),
    go(L1,X1/Y1,M), !.                                       % continue the game

% if the next move lead to deadlock
check(L,X/Y,X1/Y1,N):-
    move(X/Y,X1/Y1),
    \+member(X1/Y1,L),
    go(_,_,-1), !.                                           % go to game over state

% if the next move is illegal
check(L,X/Y,X1/Y1,N):-
    \+move(X/Y,X1/Y1),
    write('Invalid move, try again.'),
    nl,
    go(L,X/Y,N), !.                                          % go back and make a new move

% if the new move is already been achieved
check(L,X/Y,X1/Y1,N):-
    move(X/Y,X1/Y1),
    member(X1/Y1,L),
    write('The position has been achieved, try again.'),
    nl,
    go(L,X/Y,N), !.                                          % go back and make a new move

% add a move to a list L to make a new list L1
add([],X/Y,[X/Y]):- !.
add([H|T],X/Y,[H|T1]):-
    add(T,X/Y,T1).

member(X/Y,[X/Y|Z]).
member(X/Y,[X1/Y1|Z]):-
    member(X/Y,Z).

% legal moves of a knight, moving in 1 by 2 or 2 by 1 square
move(X/Y,X1/Y1):-
    (one(X,X1), two(Y,Y1) ; two(X,X1), one(Y,Y1)),
    X1>0, X1<6, Y1>0, Y1<6.

one(X,X1):- X1 is X+1 ; X1 is X-1.
two(X,X1):- X1 is X+2 ; X1 is X-2.
