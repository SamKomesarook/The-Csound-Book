massign 1, 402

	instr 402		
k1	midictrl	1						;READ THE MIDI CONTROLLER AGAIN
a1	oscil	20000, 440*1/(k1/127), 1	;SCALE, INVERT, SQUARE AND USE IT IN ONE LINE!
	out	a1
	endin		
