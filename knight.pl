% find a path S starting at X/Y
path(S,X/Y):-
    X>0, X<6, Y>0, Y<6,            % check if initial position is legal
    solution(S,[X/Y],X/Y,24).

% when all the moves have been achieved, found a solution S
solution(S,S,_,0).

% generate new move recursively
solution(S,L,X/Y,N):-
    move(X/Y,X1/Y1),                % generate a legal move
    \+member(X1/Y1,L),              % check that the move is not achieved
    add(L,X1/Y1,S1),                % add the move to the achieved list
    N>0, M is N-1,
    solution(S,S1,X1/Y1,M).         % generate a new move

% add X/Y to a list L to form a new list L1
add([],X/Y,[X/Y]):- !.
add([H|T],X/Y,[H|T1]):-
    add(T,X/Y,T1).

% check if X/Y is already a member of a list
member(X/Y,[X/Y|Z]).
member(X/Y,[X1/Y1|Z]):-
    member(X/Y,Z).

% legal moves of a knight, moving in a 2 by 1 or 1 by 2 square. 
move(X/Y,X1/Y1):-
    (one(X,X1), two(Y,Y1) ; two(X,X1), one(Y,Y1)),
    X1>0, X1<6, Y1>0, Y1<6.

one(X,X1):- X1 is X+1 ; X1 is X-1.
two(X,X1):- X1 is X+2 ; X1 is X-2.
