play:- 
    write('Choose size of the board: '),
    read(Size),
    write('Enter initial position: '), 
    read(X/Y),
    N is Size*Size-1, 
    go([X/Y],X/Y,N,Size).

go(_,_,0,Size):- board(_,Size),write('Congratulation! You won.').
go(L,_,-1,Size):-board(L,Size),write('Deadlock! Game over.').
go(L,X/Y,N,Size):-
    board(L,Size),
    write('Remaining positions to filled: '),write(N),nl,
    write('Enter next move: '), read(X1/Y1),                           % read in the next move
    check(L,X/Y,X1/Y1,N,Size), !.                                      % check if the next move is legal

% if there is only one move left, no need to check if the final move will lead to deadlock
check(L,X/Y,X1/Y1,1,Size):-
    move(X/Y,X1/Y1,Size),
    \+member(X1/Y1,L),
    add(L,X1/Y1,L1),
    go(L1,X1/Y1,0,Size), !.                                            % go to the end of game state

% if the new move is legal
check(L,X/Y,X1/Y1,N,Size):-
    move(X/Y,X1/Y1,Size),
    \+member(X1/Y1,L),
    add(L,X1/Y1,L1),
    M is N-1,
    move(X1/Y1,X2/Y2,Size),
    \+member(X2/Y2,L),
    go(L1,X1/Y1,M,Size), !.                                             % continue the game

% if the next move lead to deadlock
check(L,X/Y,X1/Y1,_,Size):-
    move(X/Y,X1/Y1,Size),
    \+member(X1/Y1,L),
    add(L,X1/Y1,L1),
    go(L1,_,-1,Size), !.                                                % go to game over state

% if the next move is illegal
check(L,X/Y,X1/Y1,N,Size):-
    \+move(X/Y,X1/Y1,Size),
    write('Invalid move, try again.'),
    nl,
    go(L,X/Y,N,Size), !.                                                % go back and make a new move

% if the new move is already been achieved
check(L,X/Y,X1/Y1,N,Size):-
    move(X/Y,X1/Y1,Size),
    member(X1/Y1,L),
    write('The position has been achieved, try again.'),
    nl,
    go(L,X/Y,N,Size), !.                                                % go back and make a new move

% add a move to a list L to make a new list L1
add([],X/Y,[X/Y]):- !.
add([H|T],X/Y,[H|T1]):-
    add(T,X/Y,T1).

% legal moves of a knight, moving in 1 by 2 or 2 by 1 square
move(X/Y,X1/Y1,N):-
    (one(X,X1), two(Y,Y1) ; two(X,X1), one(Y,Y1)),
    M is N+1,
    X1>0, X1<M, Y1>0, Y1<M.

one(X,X1):- X1 is X+1 ; X1 is X-1.
two(X,X1):- X1 is X+2 ; X1 is X-2.

check_list(List,Pos/Line,N):-
    Pos<N+1,Line>0,
    member(Pos/Line,List),!,
    write(1),write(' '),
    Pos1 is Pos+1,
    check_list(List,Pos1/Line,N).
check_list(List,Pos/Line,N):-
    Pos<N+1,Line>0,
    write(0),write(' '),
    Pos1 is Pos+1,
    check_list(List,Pos1/Line,N).
check_list(List,_/Line,N):-
    Line>1,
    nl,
    Line1 is Line-1,
    check_list(List,1/Line1,N).
check_list(_,_/1,_):-!.

board(Solution,N):-
    Line is N,
    check_list(Solution,1/Line,N),nl,
    write(------------------),nl,!.
