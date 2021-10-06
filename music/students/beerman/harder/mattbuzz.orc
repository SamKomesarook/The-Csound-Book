;--------------------------------------------------------
; MUSIC TECHNOLOGY STUDIO - BOWLING GREEN STATE UNIVERSITY
; ADVISOR: DR. BURTON BEERMAN
; STUDENT:  MATTHEW D. HARDER
; INSTRUMENT:  BUZZ.ORC
;---------------------
; BUZZ AND BUTTERLP FILTER
;------------------------

sr		=		44100
kr		=		4410
ksmps	=		10
nchnls	=		1

		instr 1
idur		=		p3
ifreq	=		p4
iamp		=		p5
irise	=		p6
iphs		=		p7
knh		=		p8
kfreq	=		p9
	
k1 		linen 	p5, p6, p3, 1

a1 		buzz 	k1, p4, p8, 1, p7

k2 		oscil 	10000, 10, 1

a2 		oscil 	k2, p4, 2

k3 		oscil  	10000, 1, 2

afil 	butterlp 	a1, k3

		out 		a1+a2+afil
		endin

		instr 2

idur		=		p3
ifreq	=		p4
iamp		=		p5
irise	=		p6
	
k1 		linen 	p5, p6, p3, 1
a1 		oscil 	p5, k1, 2
		out 		a1
		endin 
