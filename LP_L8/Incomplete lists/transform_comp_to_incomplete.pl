%q9-3. Write a predicate which transforms an incomplete list into a complete
%list.


complete_list(L,_):- 
          var(L),!.
complete_list([H|T],[H|R]):-
           complete_list(H,R).