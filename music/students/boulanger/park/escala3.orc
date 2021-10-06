;				Escala3 (orc file)
;					composition by Joo Won Park (druntune@hotmail.com)
;								Feb. 24th, 2001



sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         2

#define REVERB	#garvb	=	garvb+(asig*irvbsnd)#
#define	COMB	#gacomb	=	gacomb+(asig*icmbsnd)#	
garvb	init	0
gacomb	init	0


		instr 1 ;chorused sine
idur	=	p3
iamp	=	ampdb (p4)
ifrq	=	p5
ifn		=	p6
iatk	=	idur*p7
irel	=	idur-iatk
irvbsnd	=	p8
icmbsnd	=	p9
ipre	=	p10
kenv	linen	iamp,iatk,idur,irel	
asig	oscil	kenv,ifrq,ifn
a2	oscil	kenv*.7,ifrq*.99,ifn
a3	oscil	kenv*.7,ifrq*.1.01,ifn
aleft	=	asig+a2
aright	=	asig+a3		
$REVERB.
$COMB.
		outs	aleft*ipre,aright*ipre
		endin
		
		
		instr 2 ;FM sweep
idur	=	p3
iamp	=	ampdb (p4)
ifrq	=	p5
ifn		=	p6
iatk	=	idur*p7
irel	=	idur-iatk
imod	=	p8
ipanfrq	=	p9
irvbsnd	=	p10
icmbsnd	=	p11
kpan	oscil	1,ipanfrq,ifn
kenv	linseg	0,iatk,iamp,irel,0
kindex	expseg	0.001,iatk,imod,irel,0.001
a2		foscil	kenv,ifrq,1,4,kindex,ifn
asig		tonex	a2, 12000
		$REVERB.
		$COMB.
		outs	asig*kpan,asig*(1-kpan)
		endin
	
	
	
		instr 3; noise panner
idur	=	p3
iamp	=	ampdb (p4)
ifc1	=	p5
ifc2	=	p6
iatk	=	idur*p7
irel	=	idur*p8
ilfo	=	p9
ipanfrq	=	p10
irvbsnd	=	p11
kenv	linen	1,iatk,idur,irel
klfo	oscil	kenv,ilfo,2 
kpan	oscil	1,ipanfrq,2
anoise	randi	iamp*klfo,14000
atone1	tonex	anoise,ifc1
atone2 	atonex	anoise,ifc2
asig	=	(atone1+atone2)*kenv
$REVERB.
		outs	asig*kpan,asig*(1-kpan)
		;dispfft asig,idur,1024
		endin
	
	
		instr 198 ; comb 
idur	=	p3
irvt	=	p4
iloopt	=	p5
acomb	comb	gacomb,irvt,iloopt
		outs	acomb,acomb
gacomb	=	0
		endin


		instr 199 ; reverb
idur	=	p3
irvbtim	=	p4
ihiatn	=	p5
arvb	nreverb	garvb,irvbtim,ihiatn
		outs	arvb,arvb
garvb	=	0
		endin	
		
