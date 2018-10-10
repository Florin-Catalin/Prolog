woman(ana). 
woman(sara).
woman(ema).
woman(maria).

man(andrei).
man(george).
man(alex).
man(ion).



parent(maria, ana). 
parent(george,ana). 
parent(maria,andrei).
parent(george,andrei).



mother(X,Y):-woman(X), parent(X,Y).
sibling(X,Y):-parent(Z,X), parent(Z,Y), X\=Y.
sister(X,Y):-sibling(X,Y), woman(X).
aunt(X,Y):-sister(X,Z),parent(Z,Y).

ancestor(X,Y) :- parent (X,Y);
ancestor (X,y) :- parent (X,Z), ancestor(Z,Y).