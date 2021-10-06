; Table-based Rezzy Synth with Distortion

sr	=	44100
kr	=	44100
ksmps	=	1
nchnls	=	1

	instr	1007	; tb-303 EMULATOR
idur	=	p3
iamp	=	p4
ifqc	=	cpspch(p5)
irez	=	p7
itabl1	=	p8
kaenv	linseg	0, .01, 1, p3-.02, 1, .01, 0	; ampenv
kfco	linseg	p6, .5*p3, .2*p6, .5*p3, .1*p6	; FrqSweep
ka1	=	100/irez/sqrt(kfco)-1	; attempts to separate...
ka2	=	1000/kfco	; ...Freq. from Res.
aynm1	init	0	; Initialize Yn-1 to zero
aynm2	init	0	; Initialize Yn-2 to zero 
axn	oscil	iamp, ifqc, itabl1	; osc

; Replace the differential eqUation with a difference equation.
ayn	=	((ka1+2*ka2)*aynm1-ka2*aynm2+axn)/(1+ka1+ka2)
atemp	tone	axn, kfco
aclip1	=	(ayn-atemp)/100000
aclip	tablei	aclip1, 7, 1, .5
aout	=	aclip*20000+atemp
aynm2	=	aynm1
aynm1	=	ayn
	out	kaenv*aout	; Amp envelope and output
	endin
