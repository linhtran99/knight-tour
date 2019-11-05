% find a path S on nxn board starting from X/Y
path(S,X/Y,N):-
    N1 is N+1,
    N2 is N*N-1,                        % number of moves left needed to make
    X>0, X<N1, Y>0, Y<N1, !,            % check if initial position is legal
    solution(S,[X/Y],X/Y,N1,N2).

% when all moves have been achieved, found a solution S
solution(S,S,_,_,0):- !.

% generate the final move without checking
solution(S,L,X/Y,N,1):-
    move(X/Y,X1/Y1,N),                  % generate a legal move
    \+member(X1/Y1,L),                  % check that the move is not achieved
    add(L,X1/Y1,S1),                    % add the move to the achieved list
    solution(S,S1,X1/Y1,N,0).           % go to the final solution

% generate new move recursively
solution(S,L,X/Y,N,M):-
    M>1, M1 is M-1,
    check(X/Y,X1/Y1,N,[],L,L),          % generate the best move
    add(L,X1/Y1,S1),                    % add the move to the achieved list
    solution(S,S1,X1/Y1,N,M1).          % generate a new move

% check every possible moves
check(X/Y,X0/Y0,N,L,S,S0):-
    move(X/Y,X1/Y1,N),
    \+member(X1/Y1,S),
    add(S,X1/Y1,S1),
    choice(X1/Y1,N,[X1/Y1|S0],0,Num),   % find the number of possible next moves of X1/Y1
    add(L,X1/Y1/Num,L1),                % add the move with associated number of possible next moves to a list
    check(X/Y,X0/Y0,N,L1,S1,S0).        % check for the next possible move

% the best move is the move with the least possible next moves
check(X/Y,X0/Y0,N,L,_,_):-
    min(L,X0/Y0/Num).

% check for every possible moves that has not been achieved recursively
choice(X/Y,N,S,M,Num):-
    move(X/Y,X1/Y1,N),
    \+member(X1/Y1,S),
    add(S,X1/Y1,S1),
    M<8, M1 is M+1,                     % increment the number of possible next move
    choice(X/Y,N,S1,M1,Num).
% when all the moves has been checked, found the number of possible next moves of a move X/Y
choice(_,_,_,M,M).

% find the move with least possible next moves in the potential move list
min([X/Y/M],X/Y/M):- !.

min([Xh/Yh/H,Xk/Yk/K|T],M) :-
    H =< K, !,
    min([Xh/Yh/H|T],M).

min([Xh/Yh/H,Xk/Yk/K|T],M) :-
    H > K, !,
    min([Xk/Yk/K|T],M).

% add a move X/Y to a list L to form a new list L1
add([],X/Y,[X/Y]):- !.
add([H|T],X/Y,[H|T1]):-
    add(T,X/Y,T1).

add([],X/Y/N,[X/Y/N]):- !.
add([H|T],X/Y/N,[H|T1]):-
    add(T,X/Y/N,T1).

% check if a move is already in the achieved list
member(X/Y,[X/Y|Z]):- !.
member(X/Y,[X1/Y1|Z]):-
    member(X/Y,Z).

% legal move of a knight, moving in 1 by 2 or 2 by 1 square
move(X/Y,X1/Y1,N):-
    (one(X,X1), two(Y,Y1) ; two(X,X1), one(Y,Y1)),
    X1>0, X1<N, Y1>0, Y1<N.

one(X,X1):- X1 is X+1 ; X1 is X-1.
two(X,X1):- X1 is X+2 ; X1 is X-2.
