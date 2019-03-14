P(L,LE,LE):-VAR(L).
P([H|T],[H|LS],LE]):-
 P(T,LS,LE).