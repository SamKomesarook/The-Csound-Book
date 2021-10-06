sr      =      	44100
kr    	=     	4410
ksmps  	=     	10
nchnls	=		1

		instr	1416
a4		linseg	100, p3*.7, 5, p3*.3, 5	
a3		linseg	0, p3*.01, 1, p3*.9, 1, p3*.09, 0	; SIMPLE ENVELOPE
i1		=		sr/ftlen(1)		; SPEED FACTOR (RELATIVE TO SR AND TABLE LENGTH)
a2		phasor	i1				; PHASE INPUT FOR SPEED
a1		fog		15000, a4, 1, a2, 0, 0, .01, .02, .01, 2, 1, 2, p3, 0, 1
		out		a1*a3
		endin
