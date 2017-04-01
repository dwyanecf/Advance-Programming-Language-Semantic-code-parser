L = [begin, const, x, =, 8, ;, var, y, ;, var, z, ;, z, :=, 0, ;, if, x, =, y, +, 2, then, z , := , 5, else, z, :=, 3, endif, ;, while, not, x, =, z, do, z, :=, z, +, 2, endwhile, end, .], program(P, L, []).



program(P,[begin, var, z, ; , var, x, ;, z, :=, x, end, .],[]),write(P), prog_eval(P,2,3,Z).

program(P,[begin, var, x, ;, var, y,;, var, z,;, z,:=,x,+,y, end,.],[]),write(P), prog_eval(P,2,3,Z).

()??? program(P,[begin, var, x, ;, var, y,;, var, z,;, z,:=,'(',z,:=,x,+,2,')',+,y, end,.],[]),write(P), prog_eval(P,2,3,Z).

if????program(P,[begin, var, x,;, var, y,;, var, z,;,if, x,=,y, then, z,:=,1, else, z,:=,0, endif, end,.],[]),write(P), prog_eval(P,2,3,Z).

if?????program(P,[begin, var, x,;, var, y,;, var, z,;,if, x, =, 0, then, z,:=,x, else, z,:=,y, endif, end,.],[]),write(P), prog_eval(P,2,3,Z).

()??????program(P,[begin, var, x,;, var, y,;, var, z,;,if, not,'(',x,=,y,')', then, z,:=,x, else, z,:=,y, endif, end,.],[]),write(P), prog_eval(P,2,3,Z).

not???????program(P,[begin,var, x,;, var, z,;,z,:=,0,;, while, not, x,=,0, do, z, :=, z,+,1,;, x,:=,x,-,1, endwhile,end,.],[]),write(P), prog_eval(P,2,3,Z).

program(P,[begin, var, x,;, var, y,;, var, z,;,z,:=,1,;, w,:=,x,;, while, not, w, =, 0, do, z, :=,z,*,y,;, w,:=,w,-,1, endwhile,end,.],[]),write(P), prog_eval(P,2,3,Z).

 


