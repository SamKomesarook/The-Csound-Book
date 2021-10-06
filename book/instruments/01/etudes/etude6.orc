sr 		= 		44100
kr 		= 		4410
ksmps 	= 		10
nchnls 	= 		2

gacmb	init	0
garvb	init	0

		instr 	137
idur	=		p3
iamp	=		ampdb(p4)
ifrq	=		cpspch(p5)
ifun	=		p6
iatk	=		p7
irel	=		p8
irvbsnd	=		p9
icmbsnd	=		p10
kenv	linen	iamp, iatk, idur, irel
asig	loscil	kenv, ifrq, ifun
		outs		asig, asig
garvb	=		garvb+(asig*irvbsnd)
gacmb	=		gacmb+(asig*icmbsnd)
		endin

		instr   138 ;sweeping fm with vibrato & discrete pan
idur	=		p3
iamp	=		ampdb(p4)
ifrq	=		cpspch(p5)
ifc		=		p6
ifm		=		p7
iatk	=		p8
irel	=		p9
indx1	=		p10
indx2	=		p11
indxtim	=		p12	
ilfodep	=		p13
ilfofrq	=		p14		
ipan	=		p15		
irvbsnd	=		p16		
kampenv	expseg	.01, iatk, iamp, idur/9, iamp*.6, idur-(iatk+irel+idur/9), iamp*.7, irel,.01
klfo	oscil	ilfodep, ilfofrq, 1
kindex  expon  	indx1, indxtim, indx2
asig   	foscil 	kampenv, ifrq+klfo, ifc, ifm, kindex, 1
		outs     asig*ipan, asig*(1-ipan)
garvb	=		garvb+(asig*irvbsnd)
		endin

		instr	139; filtered noise with discrete random pan & reverb send
idur	=		p3
iamp	=		p4
ifrq	=		p5
iatk	=		p6
irel	=		p7
icut1	=		p8
icut2	=		p9
irvbsnd	linrand	.25
ipan	betarand	1, 1, 1
kenv	linen	iamp, iatk, idur, irel
kcut	expon	icut1, idur, icut2
anoise	rand	ifrq	
afilt4	tone	anoise, kcut
afilt3	tone	afilt4, kcut
afilt2	tone	afilt3, kcut
afilt1	tone	afilt2, kcut
asig	=		afilt1*kenv
		outs	asig*ipan, asig*(1-ipan)
		print	ipan, irvbsnd
garvb	=		garvb+(asig*irvbsnd)
		endin

		instr   140 		; dual mono - buzz + plk
idur	=		p3
iamp	=		ampdb(p4)
ifrq	=		cpspch(p5)
iatkl	=		p6
irell	=		p7
ihrm1r	=		p8
ihrm2r	=		p9
irvbsnd	=		p10
kenvl	linen	1, .001, idur, .1
kenvr	linen   iamp, iatkl, idur, irell
khrmr   line  	ihrm1r, idur, ihrm2r	
asigl	pluck   iamp*kenvl, ifrq, ifrq, 2, 1
asigr	buzz   	kenvr, ifrq, khrmr+1, 1
        outs    asigl, asigr
garvb	=		garvb+((asigl+asigr)*irvbsnd)
		endin

		instr	141   ; lfo pan - am pulser
idur	=		p3
iamp	=		ampdb(p4)
ifrq	=		cpspch(p5)
ifun	=		p6
iatk	=		p7
irel	=		p8
iatkfun	=		p9
imodpth	=		p10
imodfrq	=		p11
imodfun	=		p12
ipanfrq	=		p13	
irvbsnd	=		p14			
kenv	envlpx	iamp, iatk, idur, irel, iatkfun, .7, .01
kpan	oscil	.5, ipanfrq, 1
klfo	oscil	imodpth, imodfrq, imodfun	
asig    oscil	klfo*kenv, ifrq, ifun
kpanlfo	=		kpan+.5
       	outs  	asig*kpanlfo, asig*(1-kpanlfo)
garvb	=		garvb+(asig*irvbsnd)
		endin
				
		instr	142   ; lfo equalpower pan - am pulser
idur	=		p3
iamp	=		ampdb(p4)
ifrq	=		cpspch(p5)
ifun	=		p6
iatk	=		p7
irel	=		p8
iatkfun	=		p9
imodpth	=		p10
imodfrq	=		p11
imodfun	=		p12
ipanfrq	=		p13	
irvbsnd	=		p14			
kenv	envlpx	iamp, iatk, idur, irel, iatkfun, .7, .01
kpan	oscil	.5, ipanfrq, 1
klfo	oscil	imodpth, imodfrq, imodfun	
asig    oscil	klfo*kenv, ifrq, ifun
kpanlfo	=		sqrt(kpan+.5)
       	outs  	asig*kpanlfo, asig*(1-kpanlfo)
garvb	=		garvb+(asig*irvbsnd)
		endin

		instr   143 ; bending strings with envelope pan
idur	=		p3
iamp	=		ampdb(p4)
ifrq1	=		cpspch(p5)
ifrq2	=		cpspch(p6)
itim1	=		p7
itim2	=		p8
ipnv1	=		p9
ipnv2	=		p10
irvbsnd	=		p11
kenv    linen	iamp, .01, idur, .01
kfrq	linseg  ifrq1, itim1, ifrq2, itim2, ifrq1
kpaneg	expseg	ipnv1, itim1, ipnv2, itim2, ipnv1		
asig 	pluck 	kenv, kfrq, ifrq1, 0, 1
kpan	=		sqrt(kpaneg)
		outs 	asig*kpan, asig*(1-kpan)
garvb	=		garvb+(asig*irvbsnd)
		endin
		

		instr	198
idur	=		p3
itime 	= 		p4
iloop 	= 		p5
kenv	linen	1, .01, idur, .01
acomb 	comb	gacmb, itime, iloop, 0
		outs		acomb*kenv, acomb*kenv
gacmb	=		0
endin
		
			instr 	199
idur	=		p3					
irvbtim	=		p4
ihiatn	=		p5
arvb	nreverb	garvb, irvbtim, ihiatn
		outs		arvb, arvb
garvb	=		0
		endin

