
program(program(X)) --> command(X),[.].

%	program(p(X)) --> block(X),[.].
%
%	block(case(X,Y)) --> [begin],declaration(X),[;],command(Y),[end].
%	declaration(X) --> declaration1(X).
%	declaration(stick(X,Y)) --> declaration1(X),[;],declaration(Y).
%	declaration1(say(X,Y)) --> [const],id(X),[=],n(Y).
%	declaration1(shout(X)) --> [var],id(X).
%


command(X) --> command1(X).
command(comb(X,Y)) --> command1(X),[;],command(Y).
command1(assign(I,E)) --> id(I),[=],expression(E).
command1(ce(X,Y,Z)) --> [if],bool(X),[then],command(Y),[else],command(Z),[endif].
command1(while(B,C)) --> [loop, while], bool(B), command(C), [endloop, while].






expression1(id(X)) --> id(X).
expression1(num(X)) --> n(X).
expression1(e(X)) --> ['('],expression(X),[')'].

expression(X) --> expression1(X).
expression(add(X,Y)) --> expression1(X),[+],expression1(Y).
expression(sub(X,Y)) --> expression1(X),[-],expression1(Y).
expression(multi(X,Y)) --> expression1(X),[*],expression1(Y).




bool(equal(X,Y)) --> expression(X),[=],expression(Y).
bool(greater(X,Y)) --> expression(X),[>],expression(Y).
bool(less(X,Y)) --> expression(X),[<],expression(Y).

id(w) --> [w].
id(x) --> [x].
id(y) --> [y].
id(z) --> [z].
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

main(ValX, ValY, ValZ) :- 
program(P,[z,=,1,;,w,=,x,;,loop, while, w,>,0,z,=,z,*,y,;,w,=,w,-,1,endloop, while,.],[]),
prog_eval(P,ValX,ValY,ValZ).


prog_eval(program(Comm), Val_x, Val_y, Output) :- initialize_store(Store),
update(x, Val_x, Store, Mst), update(y, Val_y, Mst, Nst),
comm(Comm, Nst, Pst), access(z, Pst, Output).

comm(comb(C1, C2), Store, Outstore) :- comm(C1, Store, Nstore),
comm(C2, Nstore, Outstore).

comm(while(B, C), Store, Outstore) :-
(bool(B, Store) -> comm(C, Store, Nstore),
comm(while(B, C), Nstore, Outstore); Outstore=Store).

comm(ce(B, C1, C2), Store, Outstore) :- (bool(B, Store) ->
comm(C1, Store, Outstore); comm(C2, Store, Outstore)).

comm(assign(I, E), Store, Outstore) :-
expr(E, Store, Val), update(I, Val, Store, Outstore).

expr(add(E1, E2), Store, Result) :- expr(E1, Store, Val_E1),
expr(E2, Store, Val_E2), Result is Val_E1+Val_E2.

expr(sub(E1, E2), Store, Result) :- expr(E1, Store, Val_E1),
expr(E2, Store, Val_E2), Result is Val_E1-Val_E2.

expr(multi(E1, E2), Store, Result) :- expr(E1, Store, Val_E1),
expr(E2, Store, Val_E2), Result is Val_E1*Val_E2.

expr(id(X), Store, Result) :- access(X, Store, Result).
expr(num(X),_, X).

bool(greater(E1, E2), Store) :- expr(E1, Store, Eval1),
expr(E2, Store, Eval2), Eval1 > Eval2.

bool(less(E1, E2), Store) :- expr(E1, Store, Eval1),
expr(E2, Store, Eval2), Eval1 < Eval2.

bool(equal(E1, E2), Store) :- expr(E1, Store, Eval),
expr(E2, Store, Eval).


initialize_store([]).
access(Id,[(Id,Val)|_],Val).
access(Id,[_|R],Val):- access(Id,R,Val).
update(Id,NewV,[],[(Id,NewV)]).
update(Id,NewV,[(Id,_)|R],[(Id,NewV)|R]).
update(Id,NewV,[P|R],[P|R1]):- update(Id,NewV,R,R1).
