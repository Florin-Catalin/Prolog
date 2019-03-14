gcd(X,X,X). % clause 1
gcd(X,Y,Z):- X>Y, R is X-Y, gcd(R,Y,Z). % Y<X, clause 2
gcd(X,Y,Z):- X<Y, R is Y-X, gcd(X,R,Z). % X<Y, clause 3