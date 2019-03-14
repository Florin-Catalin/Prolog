

%TOOL BOX
%Prolog lists

%my_last (X,L) :- X is the last element of the lists
%      (element,list) (?,?)
my_last(X,[X]).
my_last(X,[_|L]):- my_last(X,L). 
