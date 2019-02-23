
%member/2
%member(element,lista)
member(H,[H|_]).
member(H,[_|T]):-
  member(H,T).
 
 %concatenare a trei liste versiunea 2
%append3_2/4
%append3_2(prima lista de concatenat, a doua lista 
%de concatenat, a treia lista de concatenat)
append3_2(L1,L2,L3,Result):-
 append(L2,L3,Int),
 append(Int,L1,Result).
 
% - check if two lists have same length

same_length([],[]).
same_length([_|L1],[_|L2]) :- 
  same_length(L1,L2).
  
  
% - append two lists 

append([],L,R):-
  L = R.
append([H|T],L,[H|R]) :-
  append(T,L,R).
  
% - return the middle element

middle(L,M):-
  same_length(L1,L2),
  append(L1,[M|L2],L).
 middle(L,M):-
 same_length(L1,L2),
  append(L1,[M,_|L2],L2).
  
 % - return the last element
 
my_last(X,[X]).
my_last(X,[_|L]) :- my_last(X,L).

% - return the last but one element of the list

last_but_one(X,[X,_]).
last_but_one(X,[_,L|LS]) :- last_but_one(X,[L|LS]).


% - inlocuiesti toate aparitiile head-ului unei liste cu un alt numar
replace([H|T],X,R):-replace([H|T],H,X,R).
replace([H|T],N,H,[N|R]):-replace(T,N,H,R),!.
replace([H|T],N,X,[H|R]):-replace(T,N,X,R).
replace([],_,_,[]).

% - eliminarea duplicatelor dintr-o lista 
%remove_dupl (intrare,iesire)
remove_dupl([],[]).
remove_dupl([H|T],R):-
 member(H,T),!,
 remove_dupl(T,R).
 remove_dupl([H|T],[H|R]):-
  remove_dupl(T,R).
  
 %count_dist(lista,conotr)
 count_dist([],0).
 count_dist([H|T],R):-
  member(H,T),!,
  count_dist(T,R).
  count_dist([_|T],R1):-
   count_dist(T,R),
   R1 is R+1.
   
   %- stergerea unuii element dintr-o lista 
  delete(X,[X|T],T).
  delete(X,[H|T],[H|R]):-
   delete(X,T,R).
  delete(_,[],[]).
  
  % - stergearea tuturor aparitilor 
  %delete_all/3 
  delete_all(X,[X|T],R):-
    delete_all(X,T,R).
   delete_all(X,[H|T],[H|R]):-
    delete_all(X,T,R).
delete_all(_,[],[]).

% - lungimea unei liste (lista,lungime lista 
list_length_1([],0).
list_length_1([H|T],Length):-
  list_length_1(T,TailLength),
    Length is TailLength +1.
	
%-sum elementelor
%sum_1(lista de intrare, suma valorilor elementelor argumentului).
sum_1([],0).
sum_1([H|T],Sum):-
 sum_1(T,TailSum),
   Sum is TailSum + H.
   

%3.Ai un graf orientat si sa faci din el neorientat

:-dynamic edge/2.
edge(a,b).
edge(b,c).
edge(b,d).
edge(c,f).
edge(d,e).
edge(d,g).

alledge:-edge(X,Y),\+(edge(Y,X)),assert(edge(Y,X)),fail.
alledge.

%2 Sa calculezi suma nodurilor care sunt copiii din stanga al nodului parinte

tree1(t(6,t(4,t(2,_,_),t(5,_,_)),t(9,t(7,_,_),_))).

sum(T,0):-var(T),!.
sum(t(_,L,R),Res):-sum(L,RL),sum(R,RR),takeleft(L,Left),R1 is RL+RR,Res is R1+Left.

takeleft(T,0):-var(T),!.
takeleft(t(K,_,_),K).