; ch401.orc


massign 1, 401

	instr 401		
k1	midictrl	1			;READ A MIDI CONTROLLER
k2	=	k1/127				;SCALE IT ...
k3	=	1/k2				;INVERT IT ...
a1	oscil	20000, 440*k3, 1	;AND USE IT
	out	a1
	endin		
