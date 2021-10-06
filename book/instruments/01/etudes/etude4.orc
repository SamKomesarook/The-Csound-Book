sr 		= 		44100
kr 		= 		4410
ksmps 	= 		10
nchnls 	= 		1

		instr	120
idur	=		p3
iamp	=		ampdb(p4)
ifrq	=		cpspch(p5)
ifun	=		p6
iatk	=		p7
irel	=		p8
iatkfun	=		p9				
kenv	envlpx	iamp, iatk, idur, irel, iatkfun, .7, .01
asig3   oscil	kenv, ifrq*.99, ifun
asig2   oscil	kenv, ifrq*1.01, ifun
asig1   oscil	kenv, ifrq, ifun
amix	=		asig1+asig2+asig3
       	out  	amix
       	display	kenv, p3
		endin

		instr 	121				
idur	=		p3
iamp	=		p4
ifrq	=		cpspch(p5)
ienvfun	=		p6
iwav1	=		p7
iwav1gn	=		p8
iwav2	=		p9
iwav2gn	=		p10		
kenv    oscil   iamp, idur, ienvfun
awav2 	loscil  iwav2gn, ifrq*1.02, iwav2
awav1 	loscil  iwav1gn, ifrq, iwav1
		out 	(awav1+awav2)*kenv
		print	idur, iamp, ifrq
		endin

		instr   122
idur	=		p3
iamp	=		ampdb(p4)
ifrq	=		cpspch(p5)
ifun	=		p6
iatk	=		p7
irel	=		p8
iatkfun	=		p9				
index1	=		p10
index2	=		p11
kenv	envlpx	iamp, iatk, idur, irel, iatkfun, .7, .01
kmodswp	expon	index1, idur, index2
kbuzswp expon   20, idur, 1
asig3   foscil 	kenv, ifrq, 1, 1, kmodswp, ifun
asig2   buzz   	kenv, ifrq*.99, kbuzswp+1, ifun
asig1 	pluck 	iamp, ifrq*.5, ifrq, 0, 1
amix	=		asig1+asig2+asig3	
		out     amix
		dispfft	amix, .25, 1024
		endin

		instr	123
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
kenv	envlpx	iamp, iatk, idur, irel, iatkfun, .7, .01
klfo	oscil	imodpth, imodfrq, imodfun	
asig    oscil	klfo, ifrq, ifun
       	out  	asig*kenv
		endin
		
		instr	124
idur	=		p3
iamp	=		ampdb(p4)
ifrq	=		cpspch(p5)
ifun	=		p6
iatk	=		p7
irel	=		p8
iatkfun	=		p9
imodp1	=		p10
imodp2	=		p11
imodfr1	=		p12
imodfr2	=		p13
imodfun	=		p14				
kenv	envlpx	iamp, iatk, idur, irel, iatkfun, .7, .01
kmodpth	expon	imodp1, idur, imodp2
kmodfrq	line	cpspch(imodfr1), idur, cpspch(imodfr2) 		
alfo	oscil	kmodpth, kmodfrq, imodfun	
asig   	oscil	alfo, ifrq, ifun
       	out  	asig*kenv
		endin
		
		instr	125
idur	=		p3
iamp	=		ampdb(p4)
ifrq	=		cpspch(p5)
ifun	=		p6
iatk	=		p7
irel	=		p8
iatkfun	=		p9
imodp1	=		p10
imodp2	=		p11
imodfr1	=		p12
imodfr2	=		p13
imodfun	=		p14				
kenv	envlpx	iamp, iatk, idur, irel, iatkfun, .7, .01
kmodpth	expon	imodp1, idur, imodp2
kmodfrq	line	cpspch(imodfr1), idur, cpspch(imodfr2) 		
alfo	oscil	kmodpth, kmodfrq, imodfun	
asig   	loscil	alfo, ifrq, ifun
       	out  	asig*kenv
		endin
		
		instr	126
idur	=		p3
iamp	=		ampdb(p4)
ifrq	=		cpspch(p5)
iatk	=		p6
irel	=		p7
ivibdel	=		p8
imoddpt	=		p9
imodfrq	=		p10
iharm	=		p11
kenv	linen	iamp, iatk, idur, irel
kvibenv	linseg	0, ivibdel, 1, idur-ivibdel, .3
klfo	oscil	kvibenv*imoddpt, imodfrq, 1	
asig   	buzz   	kenv, ifrq+klfo, iharm, 1
       	out  	asig
		endin

		instr	127
idur	=		p3
iamp	=		ampdb(p4)
ifrq	=		cpspch(p5)
iatk	=		p6
irel	=		p7
ivibdel	=		p8
ivibdpt	=		p9
ivibfrq	=		p10
imdfrq1	=		cpspch(p11)
imdfrq2	=		cpspch(p12)
imdndx1	=		p13
imdndx2	=		p14	
kenv	linen	iamp, iatk, idur, irel
kvibenv	linseg	0, ivibdel, 1, idur-ivibdel, .3
klfo	oscil	kvibenv*ivibdpt, ivibfrq, 1
kmodfrq	line	imdfrq1, p3, imdfrq2
kmodndx	linseg	imdndx1, p3/2, imdndx2, p3/2, imdndx1	
amod	oscil	kmodndx*ifrq, kmodfrq, 1
aplk 	pluck 	iamp, ifrq+klfo, ifrq, 0, 1
asig	oscil	kenv, ifrq+klfo+amod, 1 	
amix	=		asig+aplk
       	out  	amix
		endin
