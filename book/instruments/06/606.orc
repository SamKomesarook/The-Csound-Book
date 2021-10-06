sr      =      	44100
kr    	=     	4410
ksmps  	=     	10
nchnls	=		1

		instr 	606			
imodind	=		p4/20				; SCALES MOD INDEX TO 0-5
iattmod	=		1/(imodind+1)		; SCALES MOD ATT TO INDEX
kenv	linen	ampdb(p4), .1, p3, .1 ; AMP ENVELOPE
kmodenv	linen	imodind, iattmod, p3, .1 ; MOD INDEX ENV
asig	foscil	kenv, cpspch(p5), 1, 1,kmodenv, 1
		out		asig	
		endin		
