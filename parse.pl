program(program(X)) --> block(X),[.].

block(block(X,Y)) --> [begin],declaration(X),[;],command(Y),[end].

declaration(X) --> declaration1(X).
declaration(together(X,Y)) --> declaration1(X),[;],declaration(Y).
declaration1(clarify(X,Y)) --> [const],id(X),[=],n(Y).
declaration1(d(X)) --> [var],id(X).


command(X) --> command1(X).
command(comb(X,Y)) --> command1(X),[;],command(Y).
command1(assign(I,E)) --> id(I),[:=],expression(E).
command1(ce(X,Y,Z)) --> [if],bool(X),[then],command(Y),[else],command(Z),[endif].
command1(loop(B,C)) --> [while], bool(B), [do], command(C), [endwhile].



expression1(id(X)) --> id(X).
expression1(num(X)) --> n(X).


expression(X) --> expression1(X).
expression(add(X,Y)) --> expression1(X),[+],expression1(Y).
expression(sub(X,Y)) --> expression1(X),[-],expression1(Y).
expression(multi(X,Y)) --> expression1(X),[*],expression1(Y).
expression(div(X,Y)) --> expression1(X),['/'],expression1(Y).


bool(equal(X,Y)) --> expression(X),[=],expression(Y).

bool(f(X)) -->[not],bool(X).

id(v) --> [v].
id(x) --> [x].
id(y) --> [y].
id(z) --> [z].
id(u) --> [u].
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