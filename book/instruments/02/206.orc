sr      =      	44100
kr    	=     	4410
ksmps  	=     	10
nchnls	=		1

		instr 206		
iwshpfn	=		p6	
inrmfn	=		p7	
kswp	linseg	0, p3*.5, .49, p3*.5, 0	; INDEX SWEEP FUNCTION
aindex	oscili	kswp, p5, 2				; SOUND TO WAVESHAPE
atable	tablei	aindex, iwshpfn, 1, .5	; WAVESHAPE aindex
knrm	tablei	kswp*2, inrmfn, 1		; MAKE NORMALIZATION FUNCTION
kenv	linen	p4, .01, p3, .02		; AMPLITUDE ENVELOPE
		asig	=	(atable*knrm)*kenv	; NORMALIZE AND IMPOSE ENV
		out		asig
		dispfft	asig, .1, 1024
		endin		

