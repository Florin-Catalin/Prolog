append_il(L1,L2):-var(L1),!,L1=L2.
append_il([_|T],L2):-append_il(T,L2).