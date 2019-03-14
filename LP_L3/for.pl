for(In,In,0):-!.
for(In,Out,I):-
NewI is I-1
Intermediate is In+NewI 
for(Intermediate,Out,NewI).
