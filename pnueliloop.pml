/*ltl p0	{ []!( (y[0]==1) && (y[1]==1)) }*/

/*
Unary Operators (unop):
	[]	(the temporal operator always)
	<>	(the temporal operator eventually)
	! 	(the boolean operator for negation)

Binary Operators (binop):
	U 	(the temporal operator strong until)
	W	(the temporal operator weak until (only when used in inline formula)
	V 	(the dual of U): (p V q) means !(!p U !q))
	&&	(the boolean operator for logical and)
	||	(the boolean operator for logical or)
	/\	(alternative form of &&)
	\/	(alternative form of ||)
	->	(the boolean operator for logical implication)
	<->	(the boolean operator for logical equivalence)
*/


/*
Terminal commands

spin -a pnueliloop.pml
cc -o pan pan.c
./pan -a -N psomething

trace
spin -t -p pnueliloop.pml

*/


ltl p0	{[]!((y[0]==1 && (y[1]==0 || s!=0)) && (y[1]==1 && (y[0]==0 || s!=1)))}

ltl p1  {[]((y[0]==1 ) -> <>(y[0]==0))}

ltl p2  {[]((y[1]==1 ) -> <>(y[1]==0))}

ltl p3  {[]<>(y[0]==1)}

ltl p4  {[]<>(y[1]==1)}


bit s = 1;
bit y[2];
byte state0;
byte state1;

active proctype process0(){
	endHere:
	do /* loop forever */
	:: true->/* non critical section */
		atomic{
			y[0] = 1;
			s = 0;
		}
		y[1] == 0 || s!=0
		/*critical section*/
		/* end */
		y[0]=0;

		//break;
	od
}

active proctype process1(){
	endHere:
	do
	:: true->/* non critical section */
		atomic{
			y[1] = 1;
			s = 1;
		}
		y[0] == 0 || s!=1
		/*critical section*/

		/* end */
		y[1]=0;

		
		//break;
	od
}


init { 
	atomic{
	
		run process0(); 
		run process1(); 
	}
}