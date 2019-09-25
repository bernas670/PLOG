male(aldo).
male(lincoln).
male(lj).
male(michael).
female(christina).
female(lisa).
female(sara).
female(ella).

/* the first argument is one of the parents of the second argument */
parent(aldo, lincoln).
parent(aldo, michael).
parent(christina, lincoln).
parent(christina, michael).

parent(lisa, lj).
parent(lincoln, lj).

parent(michael, ella).
parent(sara, ella).

/* x is y's father if he is one of the parents of y and is male */
father(X, Y) :- parent(X, Y), male(X).
mother(X, Y) :- parent(X, Y), female(X).