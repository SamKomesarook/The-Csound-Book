sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         1

gadrysig	init	0

		instr	001
idur	=		p3
iamp	=		ampdb(p4)
ifrq	=		cpspch(p5)
iatk	=		p6
irel	=		p7
ivibdel	=		p8
imoddpt	=		p9
imodfrq	=		p10
iharm	=		p11
iwetamt   	=		p12
idryamt	=		1-p12
kenv	linen	iamp+10, iatk, idur, irel
kvibenv	linseg	0, ivibdel, 1, idur-ivibdel, .3
klfo	oscil	kvibenv*imoddpt, imodfrq, 1	
asig   	buzz   	kenv, ifrq+klfo, iharm, 1
gadrysig	=	gadrysig + asig*iwetamt
       	out  	asig*idryamt
		endin

 		 instr     	002

kband     	line      	p5, p3, p6
aenv      	linseg    0, p3*.01, 1, p3*.8, .6, 1.2, 0
anoise        rand      p4
abp       	butterbp  anoise, 329.628, kband
          	out       abp*aenv
          	endin 


	instr   003
idur	=		p3
iamp	=		ampdb(p4)
ifrq	=		cpspch(p5)
ifun	=		p6
iatk	=		p7
irel	=		p8
iatkfun	=		p9				
index1	=		p10
index2	=		p11
iwetamt   	=		p12
idryamt	=		1-p12
kenv	envlpx	iamp, iatk, idur, irel, iatkfun, .7, .01
kmodswp	expon	index1, idur, index2
kbuzswp expon   20, idur, 1
asig3   foscil 	kenv, ifrq, 1, 1, kmodswp, ifun
asig2   buzz   	kenv, ifrq*.99, kbuzswp+1, ifun
asig1 	pluck 	iamp*.5, ifrq*.5, ifrq, 0, 1
gadrysig	=	gadrysig + (asig1+asig2+asig3)*iwetamt
amix	=		asig1+asig2+asig3	
		out     amix*idryamt
		dispfft	amix, .25, 1024
		endin

	instr 	004
iamp	=	ampdb (p4)
ifrq	=	cpspch (p5)
agrain 		grain 	iamp, ifrq, 55, iamp, 10, .05, 1, 3, 1  
		out 	agrain
		endin


		instr	005
irevtime	=	p4
areverb	reverb	gadrysig,	irevtime
	out	areverb+gadrysig
gadrysig	=	0
	endin
