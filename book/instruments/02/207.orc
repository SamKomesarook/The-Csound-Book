sr      =      	44100
kr    	=     	4410
ksmps  	=     	10
nchnls	=		1

		instr 207
idur	=			p3
iamp	=			p4
ifrq	=			cpspch(p5)			; p5=DESIRED PITCH
iswp1	=			p6
iswp2	=			p7
kswp	line		iswp1, idur, iswp2	; AMPLITUDE SWEEP VALUES
acosi	oscili		kswp*.5, ifrq, 2	; f2=COSINE WAVE
asine	oscili		kswp, ifrq, 1		; f1=SINE WAVE
atab1	tablei		acosi, 33, 1, .5	; TABLES a1 TO GEN13
atab2	tablei		acosi, 34, 1, .5	; TABLES a1 TO GEN14
knrm1	tablei		kswp, 35, 1			; NORMALIZING f35
knrm2	tablei		kswp, 36, 1			; NORMALIZING f36
anrm1	=			atab1*knrm1			; NORMALIZE GEN13 SIGNAL
anrm2	=			atab2*knrm2*asine	; NORMALIZE GEN14 SIGNAL
amix	=			anrm1+anrm2			; MIX GEN13 AND GEN14
kenv	expseg		.001, idur*.1, iamp, idur*.1, iamp*.8, idur*.8, .001	
asig	=			amix*kenv	
		out 		asig
		endin
