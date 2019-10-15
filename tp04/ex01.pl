ligado(a,b).
ligado(f,i).
ligado(a,c).
ligado(f,j).
ligado(b,d).
ligado(f,k).
ligado(b,e).
ligado(g,l).
ligado(b,f).
ligado(g,m).
ligado(c,g).
ligado(k,n).
ligado(d,h).
ligado(l,o).
ligado(d,i).
ligado(i,f).

membro(X, [X|_]) :- !.
membro(X, [_|Y]) :- 
    membro(X,Y). 
concatena([], L, L). 
concatena([X|Y], L, [X|Lista]):- 
    concatena(Y, L, Lista). 
inverte([X], [X]). 
inverte([X|Y], Lista):- 
    inverte(Y, Lista1), 
    concatena(Lista1, [X], Lista).

resolva_prof(I, F, P) :-
    resolva_prof(I, F, P, [I]).
/* base case, when the inicial and final nodes are the same */
resolva_prof(F, F, P, P).
resolva_prof(I, F, P, T) :-
    ligado(I, N),
    \+member(N, T),
    concatena(T, [N], NT),
    resolva_prof(N, F, P, NT).

resolva_larg(I, F, P) :-
    
    



