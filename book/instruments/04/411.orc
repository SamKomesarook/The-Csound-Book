sr      =      	44100
kr    	=     	4410
ksmps  	=     	10
nchnls	=		1

		instr	411					
a1		oscil	p5, 440, 1			; GENERATE THE SIGNAL
a2		table	a1, 2				; USE TABLE LOOKUP TO COMPUTE THE SINE
		out		a2*p4				; AND PLAY THE OUTPUT
		endin		
