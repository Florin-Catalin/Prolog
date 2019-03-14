% Author:
% Date: 19/10/2016

member(X,[X|_]):-!.
member(X,[_|T]):-member(X,T).

memberDeep(H,[H|_]):-!.
memberDeep(X,[H|_]):-memberDeep(X,H),!.
memberDeep(X,[_|T]):-memberDeep(X,T).

member_il(_,L):-var(L),!,fail.
member_il(X,[X|_]):-!.
member_il(X,[_|T]):-member_il(X,T).


