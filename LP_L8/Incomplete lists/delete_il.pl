delete_il(_, L, L):-var(L), !. % reached end, stop
delete_il(X, [X|T], T):-!. % found element, remove it and stop
delete_il(X, [H|T], [H|R]):-delete_il(X, T, R). % search for the element