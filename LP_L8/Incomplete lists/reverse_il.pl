
append_il(L1,L2):-var(L1),!,L1=L2.
append_il([_|T],L2):-append_il(T,L2).

%reverse_il(l,acc,rez)
reverse_il(L,_):-var(L),!.
reverse_il([H|T],R):-reverse_il(T,R),append_il(R,[H|_]).