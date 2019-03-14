
member(X,[X|_]):-!.
member(X,[_|T]):-member(X,T).


i([H|T] ,L,[H|R ]) :- member([H|T],L,R),!,i(T,L,R).
 i([H|T],L,R) :- i(T,L,R).
 i([],L,L).
