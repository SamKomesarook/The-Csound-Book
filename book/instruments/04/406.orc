sr      =      	44100
kr    	=     	4410
ksmps  	=     	10
nchnls	=		1

		instr 	406		
k1		line	0, p3, 1			; GENERATE AN ENVELOPE SCALED BETWEEN 0 AND 1
a1		oscil	32000*k1, 440, 1	; SCALE IT AND APPLY IT ON AN OSCILATOR
		out		a1					; AND PLAY THE RESULT
		endin
