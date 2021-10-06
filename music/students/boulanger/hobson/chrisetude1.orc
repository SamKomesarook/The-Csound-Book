sr 	=	44100
kr 	=	44100
ksmps 	=	1
nchnls 	=	2

garvb	init	0
gacmb	init	0


	instr	130
idur	=	p3
iamp	=	p4
ifrq	=	p5
iatk	=	p6
irel	=	p7
icut1	=	p8
icut2	=	p9
irvbsnd =	p10
ipan	=	p11
kenv	linen	iamp, iatk, idur, irel
kcut	expon	icut1, idur, icut2
anoise	rand	ifrq	
afilt2	tone	anoise, kcut
afilt1	tone	afilt2, kcut
amix	=	afilt1*kenv
  outs  amix*ipan, amix*(1-ipan)
garvb	=	garvb + ((afilt1*kenv)*irvbsnd)
;  dispfft	afilt1, idur, 4096
	endin		

	instr   134
idur	=	p3
iamp	=	ampdb(p4)
ifrq	=	cpspch(p5)
icut1	=	p6
icut2	=	p7
iresgn	=	p8
icmbsnd =	p9
ipan	=	p10
kcut	expon	icut1, idur, icut2
aplk 	pluck 	iamp, ifrq, ifrq, 0, 1
abpf	butterbp	aplk, kcut, kcut*.2
alpf	butterlp	aplk, kcut
amix	=     alpf+(abpf*iresgn)
	outs	amix*ipan, amix*(1-ipan)
gacmb	=	gacmb+(amix*icmbsnd)
;	dispfft	amix, idur, 1024
	endin

	instr   108
iamp	=	ampdb(p4)
idur	=	p3
ifrq	=	cpspch(p5)
kcar	=	p6
kmod	=	p7
k1	=	p8
k2	=	p9
ifn	=	p10
kenv	linen  iamp, .3, idur, .3 
kndx      line    k1, idur, k2
a1   	foscil 	kenv, ifrq, kcar, kmod, kndx, ifn
		outs     a1/15, a1/2
		endin

	instr 1 
iamp = ampdb(p4)
ifrq	= cpspch(p5)
kamp 	line 0, 1, 5000	
a1 	oscil kamp, ifrq, 1
kvib	oscil 2.75, p5/70, 1
asig	oscil a1, p5+kvib, 1
	outs asig/2, asig/20
endin

	instr 998
idur	=	p3
irvbtim	=	p4
ihiatn	=	p5
arvb	nreverb	garvb, irvbtim, ihiatn
	outs arvb/2, arvb/2
garvb	=	0
endin

	instr 999
idur	=	p3
itime	=	p4
iloop	=	p5
kenv	linen	1, .01, idur, .01
acomb	comb	gacmb, itime, iloop, 0
	outs (acomb*kenv)/2, (acomb*kenv)/2
gacmb	=	0
	endin
