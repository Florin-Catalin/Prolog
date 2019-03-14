insert_ord( X, [X|T], [R|T]) :-
           X >= H,!, 
		   insert_ord(X,T,R).
		  insert_ord(X,T,[X|T]).
		  



 s([H],L,[H|R] ):-
   s(T,L,R).
   s([],R,R).
   