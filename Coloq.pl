%1. Count the number of lists in a deep list.
count_lists([],0).
count_lists([H|T],R):-atomic(H),count_lists(T,R).
count_lists([H|T], R):-count_lists(H, RH),count_lists(T, RT),R is RH + RT + 1.

append1([], L, L).
append1([H|T], L, [H|R]):-append(T, L, R).
%2. Double the odd numbers and square the even.
numbers([],[]).
numbers([H|T],[H*H|R]):- 0 is H mod 2,numbers(T,R).
numbers([H|T],[2*H|R]):- 1 is H mod 2,numbers(T,R).
%3. Convert a number to binary
dec_bin(0,'0').
dec_bin(1,'1').
dec_bin(N,B):-N>1,X is N mod 2,Y is N//2,dec_bin(Y,B1),atom_concat(B1, X, B).

%5. Delete the occurrences of x on even positions
del_pos_even([],_,_,[]).
del_pos_even([H|T],C,H,R):-0 is C mod 2,!,C1 is C+1,del_pos_even(T,C1,H,R).
del_pos_even([H|T],C,Nr,[H|R]):-C1 is C+1,del_pos_even(T,C1,Nr,R).


%6 Compute the divisors of a natural number.
divisor(NR,NR,DIVS,[NR|DIVS]):-!.
divisor(NR,ACC,DIVS,R):-0 is NR mod ACC,!,ACC1 is ACC + 1,append([ACC],DIVS,DIVS1),divisor(NR,ACC1,DIVS1,R).
divisor(NR,ACC,DIVS,R):-ACC1 is ACC+1,divisor(NR,ACC1,DIVS,R).


%7. Reverse a natural number.
reverse_n(0,0).
reverse_n(Nr,R1):-M is Nr mod 10, D is Nr div 10,reverse_n(D,R),atom_concat(M,R,R1).

%8. Delete each kth element from the end of the list.
delete_k([],_,_,[]).
delete_k([H|T],K,Count,R):-Count is K-1,!,delete_k(T,K,0,R).
delete_k([H|T],K,Count,[H|R]):-Count1 is Count + 1, delete_k(T,K,Count1,R).
reverse_list([],[]).
reverse_list([H|T],R):-reverse(T,R1),append(R1,[H],R).
delete_kend(L,K,Count,R):-reverse_list(L,NewL),delete_k(NewL,K,Count,R1),reverse_list(R1,R).

% 9. Separate the even elements on odd positions from the rest
separate1([],_,[],[]).
separate1([H|T],Count,[H|Even],Rest):-0 is H mod 2,1 is Count mod 2,!,Count1 is Count + 1,separate1(T,Count1,Even,Rest).
separate1([H|T],Count,Even,[H|Rest]):-Count1 is Count + 1,separate1(T,Count1,Even,Rest).

separate11(L,Even,Rest):-separate1(L,1,Even,Rest).


%10. Binary incomplete tree. Collect odd nodes with 1 child in an incomplete list.
collect_odd_from_1child(t(_, L, R), _):-
	var(L),
	var(R), !.
collect_odd_from_1child(t(K, N, R), [K|List]):-
	var(N),
	1 is K mod 2, !,
	collect_odd_from_1child(R, List).
collect_odd_from_1child(t(K, L, N), List):-
	var(N),
	1 is K mod 2, !,
	collect_odd_from_1child(L, List),
	insert_il(K, List).
collect_odd_from_1child(t(_, L, R), List):-
	collect_odd_from_1child(L, LL),
	collect_odd_from_1child(R, RL),
	append_il(LL, RL),
	List = LL.

insert_il(X, L):-
	var(L), !,
	L = [X|_].
insert_il(X, [_|T]):-
	insert_il(X, T).

append_il(L1, L2):-
	var(L1), !,
	L1 = L2.
append_il([_|T1], L2):-
	append_il(T1, L2).

%12. Binary Tree. Collect even keys from leaves in a difference list.

collect_even_from_leaf(nil,L,L).
collect_even_from_leaf(t(K,nil,nil),[K|LS],LS):-0 is K mod 2,!.
collect_even_from_leaf(t(K,L,R),LS,LE):-collect_even_from_leaf(L,LS,LM),collect_even_from_leaf(R,LM,LE).

%14. Collect all the nodes at odd depth from a binary incomplete tree (the root has depth 0).
collect_all_odd_depth(N, _, []):-
	var(N),!.
collect_all_odd_depth(t(K, L, R), N, [K|List]):-
	1 is N mod 2, !,
	N1 is N + 1,
	collect_all_odd_depth(L, N1, LL),
	collect_all_odd_depth(R, N1, LR),
	append(LL, LR, List).
collect_all_odd_depth(t(_, L, R), N, List):-
	N1 is N + 1,
	collect_all_odd_depth(L, N1, LL),
	collect_all_odd_depth(R, N1, LR),
	append(LL, LR, List).

  %15. Flatten only the elements at depth X from a deep list.
max(A,B,A):-A>B,!.
max(A,B,B).

depth([],1).
depth([H|T],R):-atomic(H),!,depth(T,R).
depth([H|T],R):- depth(H,R1), depth(T,R2), R3 is R1+1, max(R3,R2,R).

flatten([],[]).
flatten([H|T], [H|R]) :- atomic(H),!, flatten(T,R).
flatten([H|T], R) :- flatten(H,R1), flatten(T,R2), append(R1,R2,R).

flatten_depth([],_,_,[]).
flatten_depth([H|T],Depth,Count,[H|R]):-atomic(H),!,Count is Depth,flatten_depth(T,Depth,Count,R).
flatten_depth([H|T],Depth,Count,R):-atomic(H),!,flatten_depth(T,Depth,Count,R).
flatten_depth([H|T],Depth,Count,R):-Count1 is Count +1,flatten_depth(H,Depth,Count1,R1),flatten_depth(T,Depth,Count,R2),append(R1,R2,R).

%16. Delete duplicate elements that are on an odd position in a list
%count_dups(List,Elemen,Count,R)
count_dups([],El,Count,[Count]).
count_dups([H|T],H,Count,R):-Count1 is Count+1,count_dups(T,H,Count1,R).
count_dups([H|T],El,Count,R):-count_dups(T,El,Count,R).

%remove_odd(List,Elem,Count,R)
remove_odd([],_,_,[]).
remove_odd([H|T],H,Count,R):-1 is Count mod 2,!,Count1 is Count + 1, remove_odd(T,H,Count1,R).
remove_odd([H|T],Elem,Count,[H|R]):-Count1 is Count + 1, remove_odd(T,Elem,Count1,R).

%remove_odd_dups(List,R)
remove_odd_dups([],[]).
remove_odd_dups([H|T],[H|R]):-count_dups(T,H,0,C),C>1,remove_odd(T,H,0,NewT),remove_odd_dups(NewT,R).
remove_odd_dups([H|T],[H|R]):-remove_odd_dups(T,R).

%11. Ternary incomplete tree. Collect the keys between X and Y (closed interval) in a difference list.

%collect_ternary(T,X,Y,R).
collect_ternary(L,_,_,LS,LS):-var(L),!.
collect_ternary(t(K,L,M,R),X,Y,[K|LS],LE):-K>=X,K=<Y,!,collect_ternary(L,X,Y,LS,RE1),collect_ternary(M,X,Y,RE1,RE2),collect_ternary(R,X,Y,RE2,LE).
collect_ternary(t(K,L,M,R),X,Y,LS,LE):-collect_ternary(L,X,Y,LS,RE1),collect_ternary(M,X,Y,RE1,RE2),collect_ternary(R,X,Y,RE2,LE).

tree(t(2,t(8,_,_,_),t(3,_,_,t(4,_,_,_)),t(5,t(7,_,_,_),t(6,_,_,_),t(1,_,_,t(9,_,_,_))))).


%13. Replace the min element from a ternary incomplete tree with the root.
inorder_ternary(T,_):-var(T),!.
inorder_ternary(t(K,L,M,R), List):-inorder_ternary(L,LL), inorder_ternary(M,LM), inorder_ternary(R,RL),
append(LL, [K|LM],List1), append(List1,RL,List).


minim([],MIN,MIN).
minim([H|T],MIN,R):-H<MIN,!,MINP is H,minim(T,MINP,R).
minim([H|T],MIN,R):-minim(T,MIN,R).

min_ternary(T,List):-inorder_ternary(T,L),minim(L,100,List).

%copac(t(2,t(8,_,_,_),t(3,_,_,t(1,_,_,_)),t(5,t(7,_,_,_),t(6,_,_,_),t(1,_,_,t(9,_,_,_))))).

replacemin(t(K,L,M,R),t(NK,NL,NM,NR)):-min_ternary(t(K,L,M,R),Min),replace_min_tree(t(K,L,M,R),Min,K,t(NK,NL,NM,NR)).

replace_min_tree(L,_,_,_):-var(L),!.
replace_min_tree(t(K,L,M,R),Min,Root,t(Root,NL,NM,NR)):-Min=K,!,
														replace_min_tree(L,Min,Root,NL),
														replace_min_tree(M,Min,Root,NM),
														replace_min_tree(R,Min,Root,NR).
replace_min_tree(t(K,L,M,R),Min,Root,t(K,NL,NM,NR)):-
                            replace_min_tree(L,Min,Root,NL),
													 replace_min_tree(M,Min,Root,NM),
													 replace_min_tree(R,Min,Root,NR).
%18. Replace each node with its height in a binary incomplete tree
% predicate which computes the maximum between 2 numbers
max(A, B, A):-A>B, !.
max(_, B, B).
% predicate which computes the height of a binary tree
height(L, 0):-var(L),!.
height(t(_, L, R), H):-height(L, H1), height(R, H2), max(H1, H2, H3), H is H3+1.

replaceheight(T,R):-height(T,H),replace_height(T,H,R).

replace_height(L,_,L):-var(L).
replace_height(t(K,L,R),Height,t(Height,NL,NR)):-H1 is Height-1,replace_height(L,H1,NL),replace_height(R,H1,NR).
altcopac(t(2,t(4,t(5,_,_),t(7,_,_)),t(3,t(0,t(4,_,_),_),t(8,_,t(5,_,_))))).

%21. Encode a list with RLE.
encode([],X,Count,[[X,Count]]).
encode([H|T],H,Count,R):-Count1 is Count + 1,encode(T,H,Count1,R).
encode([H|T],X,Count,[[X,Count]|R]):-encode(T,H,1,R).

rle_encode([H|T],R):-encode(T,H,1,R).

%20. Decode a list encoded with RLE.
printn([Nr,Count],Count,List,[List]).
printn([Nr,Count],Acc,List,R):-Acc<Count,Acc1 is Acc + 1, append([Nr],List,List1),printn([Nr,Count],Acc1,List1,R).
decode([],List,[List]).
decode([[Nr,Count]|T],List,R):-printn([Nr,Count],0,[],R1),append(List,R1,R2),decode(T,R2,R).





%[1,2,3,4]
%[5,6,4,6]
%[4,5,6,3]
%[1,2,3,3]

%[1,5,4,1]
%[2,6,5,2]
%[3,4,6,3]
%[4,6,3,3]


extractk([],_,_,[]).
extractk([H|T],Count,K,[H|R]):-Count is K,!,Count1 is Count + 1,extractk(T,Count1,K,R).
extractk([H|T],Count,K,R):-Count1 is Count +1,extractk(T,Count1,K,R).


%%%%%%%%%%%
count_dups1(L,El,Count,[Count]):-var(L),!.
count_dups1([H|T],H,Count,R):-Count1 is Count+1,count_dups1(T,H,Count1,R).
count_dups1([H|T],El,Count,R):-count_dups1(T,El,Count,R).
%%%%%%%%%%%%%%
postorder(t(K,L,R),List):-postorder(L,LL),postorder(R,LR),append(LL,LR,Rez1),append(Rez1,[K],List).
postorder(nil,[]).

sum([],0).
sum([H|T],R):-sum(T,T1),R is T1 + H.

suma(L,Partial,Partial):-var(L),!.
suma([H|T],Partial,R):-sum(H,Suma),append(Partial,[Suma],Partial1),suma(T,Partial1,R).

sumaminim(L,M):-suma(L,[],R),minim(R,100,M).

%In lista incompleta, nodurile de la o anumita inaltime


heightC(nil, 0).
heightC(t(_, L, R), H):-heightC(L, H1), heightC(R, H2), max(H1, H2, H3), H is H3+1.

collect(nil,_,_,_).
collect(t(K,L,R),WantedHeight,LocalHeight,[K|List]):-LocalHeight is WantedHeight,!,LocalHeight1 is LocalHeight - 1,
														collect(L,WantedHeight,LocalHeight1,List1),
														collect(R,WantedHeight,LocalHeight1,List2),
														append(List1,List2,List).
collect(t(K,L,R),WantedHeight,LocalHeight,List):-LocalHeight1 is LocalHeight - 1,
														collect(L,WantedHeight,LocalHeight1,List1),
														collect(R,WantedHeight,LocalHeight1,Lis2),
														append(List1,List2,List).

collectFinal(T,WantedHeight,List):-heightC(T,Height),collect(T,WantedHeight,Height,List).														

copacel(t(6, t(4, t(2, nil, nil), t(5, nil, nil)), t(9, t(7, nil, nil), nil))). 

%%%%%%%% Sum from all elems from root to leaf
rootleaf(nil,_,[]).
rootleaf(t(K,nil,nil),S,[Res]):-
    Res is K+S.
rootleaf(t(K,L,R),S,Res):-
    S1 is S+K,
    rootleaf(L,S1,R1),
    S2 is S+K,
    rootleaf(R,S2,R2),
    append(R1,R2,Res).
%%%%%%%%%%%%%%

rootleaf(nil,_,LS,LS).
rootleaf(t(K,nil,nil),S,[Res|LS],LS):-
    Res is K+S.
rootleaf(t(K,L,R),S,LS,LE):-
    S1 is S+K,
    rootleaf(L,S1,LS,LM),
    S2 is S+K,
    rootleaf(R,S2,LM,LE).

%%%%%%%prime factors

decompose(Nr,Nr,Count,[[Nr,Count1]]):-Count1 is Count + 1.
decompose(Nr,Divider,Count,R):-0 is Nr mod Divider,!,Nr1 is Nr//Divider,Count1 is Count + 1,decompose(Nr1,Divider,Count1,R).
decompose(Nr,Divider,Count,[[Divider,Count]|R]):- Divider1 is Divider + 1,decompose(Nr,Divider1,0,R).

decomposee(Nr,R):-decompose(Nr,2,0,R).
%%%%%%%%%%%%%
maxim([],MIN,MIN).
maxim([H|T],MIN,R):-H>MIN,!,MINP is H,maxim(T,MINP,R).
maxim([H|T],MIN,R):-maxim(T,MIN,R).

find_maxi(L,M,M):-var(L),!.
find_maxi([H|T],MP,M):-maxim(H,0,MPP),MPP>MP,!,MP1 is MPP,find_maxi(T,MP1,M).
find_maxi([H|T],MP,M):-find_maxi(T,MP,M).

member_il(_, L):-var(L), !, fail.
% these 2 clauses are the same as for the member1 predicate
member_il(X, [X|_]):-!.
member_il(X, [_|T]):-member_il(X, T).

maxfinal(L,_,Partial,Partial):-var(L),!.
maxfinal([H|T],M,Partial,R):-member_il(M,H),!,append(H,Partial,Partial1),maxfinal(T,M,Partial1,R).
maxfinal([H|T],M,Partial,R):-maxfinal(T,M,Partial,R).

maxfinalCall(L,R):-find_maxi(L,0,M),maxfinal(L,M,[],R).
%%%%%%%%%%%%%%%%%%%%%%%%

collect_tmiddle(nil,[],LS).
collect_tmiddle(t(K,L,nil,R),LS,LE):-collect_tmiddle(L,LS,LM),collect_tmiddle(R,LM,LE).
collect_tmiddle(t(K,L,M,R),[K|LS],LE):-collect_tmiddle(L,LS,LM),collect_tmiddle(M,LM,LX),collect_tmiddle(R,LX,LE).

copacelul(t(2,t(8,nil,nil,nil),t(3,nil,nil,t(1,nil,1,nil)),t(5,t(7,nil,nil,nil),t(6,nil,nil,nil),t(1,nil,nil,t(9,nil,10,11))))).