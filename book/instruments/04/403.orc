		instr 		403	
k1		midictrl	1					;READ THE CONTROLLER
k2		=			127/k1				;FUSE THE TWO DIVISIONS INTO ONE
a1		oscil		20000, 440*k2, 1	;NOW USE IT
		out			a1	
		endin		
