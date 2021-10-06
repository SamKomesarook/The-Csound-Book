sr      =      	44100
kr    	=     	4410
ksmps  	=     	10
nchnls	=		1

		instr	1415
a3		linseg	1, p3*.2, 1, p3*.4, 2, p3*.05, -1, p3*.35, -1	; SPEED CHANGE
i1		=		sr/ftlen(1)			; SPEED FACTOR (RELATIVE TO SR AND TABLE LENGTH)
a2		phasor	i1*a3				; PHASE INPUT FOR SPEED
a1		fog		15000, 100, 1, a2, 0, 0, .01, .02, .01, 2, 1, 2, p3, 0, 1
		out		a1
		endin
