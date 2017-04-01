


program(p(X)) --> block(X),[.].

block(case(X,Y)) --> [begin],declaration(X),[;],command(Y),[end].

declaration(X) --> declaration1(X).
declaration(stick(X,Y)) --> declaration1(X),[;],declaration(Y).
declaration1(say(X,Y)) --> [const],id(X),[=],n(Y).
declaration1(shout(X)) --> [var],id(X).



command(X) --> command1(X).
command(comb(X,Y)) --> command1(X),[;],command(Y).
command1(assign(I,E)) --> id(I),[:=],expression(E).
command1(ce(X,Y,Z)) --> [if],bool(X),[then],command(Y),[else],command(Z),[endif].
command1(while(B,C)) --> [while], bool(B), [do], command(C), [endwhile].

command1(goto(X)) --> block(X).



expression1(id(X)) --> id(X).
expression1(num(X)) --> n(X).
expression1(e(X)) --> ["("],expression(X),[")"].



expression(X) --> expression1(X).
expression(add(X,Y)) --> expression1(X),[+],expression1(Y).
expression(sub(X,Y)) --> expression1(X),[-],expression1(Y).
expression(multi(X,Y)) --> expression1(X),[*],expression1(Y).



bool(equal(X,Y)) --> expression(X),[=],expression(Y).
bool(greater(X,Y)) --> expression(X),[>],expression(Y).
bool(less(X,Y)) --> expression(X),[<],expression(Y).

bool(bool(true)) -->[true].
bool(bool(false)) -->[false].
bool(not(X)) -->[not],  bool(X).

id(v) --> [v].
id(x) --> [x].
id(y) --> [y].
id(z) --> [z].
id(u) --> [u].
id(w) --> [w].
n(0) --> [0].
n(1) --> [1].
n(2) --> [2].
n(3) --> [3].
n(4) --> [4].
n(5) --> [5].
n(6) --> [6].
n(7) --> [7].
n(8) --> [8].
n(9) --> [9].

prog_eval(p(Blocks), Val_x, Val_y, Output) :- 
initialize_store(Store),
update(x, Val_x, Store, Mst), update(y, Val_y, Mst, Nst),
bloc(Blocks, Nst, Pst), 
access(z, Pst, Output).

bloc(case(D1, D2), Store, Outstore) :-
declare(D1, Store, Bstore),
comm(D2, Bstore, Outstore).

declare(stick(D1, D2), Store, Outstore) :-
declare(D1, Store, Cstore),
declare(D2, Cstore, Outstore).

declare(say(X,N), Store, Outstore) :-
expr(num(N),_, N),update(X, N, Store, Outstore).

declare(shout(X), Store, Outstore):- 
access(X, Store, FStore),
update(X, FStore, Store, Outstore).





comm(comb(C1, C2), Store, Outstore) :- 
comm(C1, Store, Nstore),
comm(C2, Nstore, Outstore).

comm(while(B, C), Store, Outstore) :-
(bool(B, Store) -> comm(C, Store, Nstore),
comm(while(B, C), Nstore, Outstore); Outstore=Store).

comm(ce(B, C1, C2), Store, Outstore) :- 
(bool(B, Store) ->
comm(C1, Store, Outstore); 
comm(C2, Store, Outstore)).

comm(assign(I, E), Store, Outstore) :-
expr(E, Store, Val), update(I, Val, Store, Outstore).

expr(add(E1, E2), Store, Result) :- expr(E1, Store, Val_E1),
expr(E2, Store, Val_E2), Result is Val_E1+Val_E2.

expr(sub(E1, E2), Store, Result) :- expr(E1, Store, Val_E1),
expr(E2, Store, Val_E2), Result is Val_E1-Val_E2.

expr(multi(E1, E2), Store, Result) :- expr(E1, Store, Val_E1),
expr(E2, Store, Val_E2), Result is Val_E1*Val_E2.

expr(div(E1, E2), Store, Result) :- expr(E1, Store, Val_E1),
expr(E2, Store, Val_E2), Result is Val_E1//Val_E2.

expr(id(X), Store, Result) :- access(X, Store, Result).

expr(num(X),_, X).

bool(greater(E1, E2), Store) :- expr(E1, Store, Eval1),
expr(E2, Store, Eval2), Eval1 > Eval2.

bool(less(E1, E2), Store) :- expr(E1, Store, Eval1),
expr(E2, Store, Eval2), Eval1 < Eval2.

bool(equal(E1, E2), Store) :- expr(E1, Store, Eval),
expr(E2, Store, Eval).

main(ValX, ValY, ValZ) :-
program(P,[begin, var, z, ; , var, x, ;, z, :=, x, end, .],[]),write(P), prog_eval(P,ValX,ValY,ValZ).




initialize_store([]).
access(Id,[(Id,Val)|_],Val).
access(Id,[],0).
access(Id,[_|R],Val):- access(Id,R,Val).
update(Id,NewV,[],[(Id,NewV)]).
update(Id,NewV,[(Id,_)|R],[(Id,NewV)|R]).
update(Id,NewV,[P|R],[P|R1]):- update(Id,NewV,R,R1).


