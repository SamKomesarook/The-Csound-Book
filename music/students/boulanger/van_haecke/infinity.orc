; INFINITESIMAL INFINITY
;	COMPOSED BY CHARLES T VAN HAECKE

sr		=		44100
kr 		= 		4410
ksmps 	= 		10
nchnls 	= 		2

garvb	init		0
											
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;											;
;		RISSET'S ENDLESS GLISSANDO USING GRAINS		;
;											;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		
		instr 1
isine  	= 		1
idur   	= 		p3
iamp   	= 		ampdb(p4)
ifunc2 	= 		2
ifunc3 	= 		3
irvb   	= 		p5
ipan   	= 		p6
				
k10amp	oscil 	iamp, 1/idur, ifunc2, 460.8
k10freq 	oscil 	3900, 1/idur, ifunc3, 460.8
k9amp   	oscil 	iamp, 1/idur, ifunc2, 409.6
k9freq  	oscil 	3900, 1/idur, ifunc3, 409.6
k8amp   	oscil 	iamp, 1/idur, ifunc2, 358.4
k8freq  	oscil 	3900, 1/idur, ifunc3, 358.4
k7amp  	oscil 	iamp, 1/idur, ifunc2, 307.2
k7freq  	oscil 	3900, 1/idur, ifunc3, 307.2
k6amp   	oscil 	iamp, 1/idur, ifunc2, 256.0
k6freq  	oscil 	3900, 1/idur, ifunc3, 256.0
k5amp   	oscil 	iamp, 1/idur, ifunc2, 204.8
k5freq  	oscil 	1000, 1/idur, ifunc3, 204.8
k4amp   	oscil	iamp, 1/idur, ifunc2, 153.6
k4freq  	oscil	3900, 1/idur, ifunc3, 153.6
k3amp   	oscil 	iamp, 1/idur, ifunc2, 102.4
k3freq  	oscil 	3900, 1/idur, ifunc3, 102.4
k2amp   	oscil 	iamp, 1/idur, ifunc2, 51.2
k2freq 	oscil 	3900, 1/idur, ifunc3, 51.2
k1amp   	oscil 	iamp, 1/idur, ifunc2, 0
k1freq  	oscil 	3900, 1/idur, ifunc3, 0

;			  	AMP, PITCH, DENS,AMPOFF,CPSOFF,GDUR,GFN,WFN,MGDUR
a10    	grain 	k10amp, k10freq, 15, 500, 500, .05, 1, 3, .1
a9	   	grain 	k9amp,  k9freq,  15, 100, 500, .05, 1, 3, .1
a8	   	grain 	k8amp,  k8freq,  15, 100, 500, .05, 1, 3, .1
a7	   	grain 	k7amp,  k7freq,  15, 100, 500, .05, 1, 3, .1
a6	   	grain 	k6amp,  k6freq,  15, 100, 500, .05, 1, 3, .1
a5	   	grain 	k5amp,  k5freq,  15, 100, 500, .05, 1, 3, .1
a4	   	grain 	k4amp,  k4freq,  15, 100, 500, .05, 1, 3, .1
a3	   	grain 	k3amp,  k3freq,  15, 100, 500, .05, 1, 3, .1
a2	   	grain 	k2amp,  k2freq,  15, 100, 500, .05, 1, 3, .1	
a1	  	grain 	k1amp,  k1freq,  15, 100, 500, .05, 1, 3, .1
asig 	= 		a1+a2+a3+a4+a5+a6+a7+a8+a9+a10
	
irtl		=		sqrt(2)/2*cos(ipan)+sin(ipan)	    ; CONSTANT POWER PANNING
irtr		=		sqrt(2)/2*cos(ipan)-sin(ipan)	    ; FROM C.ROADS "CM TUTORIAL" p460
		outs		asig*irtl, asig*irtr
garvb	=		garvb+(asig*irvb)
		endin

											
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;											;
;		EQUAL PANNING SINGLE GRAIN GENERATOR		;
;											;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
	
		instr 2
isine  	= 		1
ifunc2	= 		2
ifunc3 	= 		3
ifunc6	=		6
idur   	= 		p3
iamp   	= 		p4
irvb   	=		p5
ipan   	= 		p6
				
	
kamp  	oscil 	iamp, 1/idur, ifunc2, 0
kfreq  	oscil 	2000, 1/idur, ifunc3, 0

;			     AMP, PITCH, DENS, AMPOFF,CPSOFF,GDUR,GFN,WFN,MGDUA
asig	   	grain 	kamp,  kfreq,  15, 100,   500,  .05,  1,  3,  .1
irtl		=		sqrt(2)/2*cos(ipan)+sin(ipan)	    ; CONSTANT POWER PANNING
irtr		=		sqrt(2)/2*cos(ipan)-sin(ipan)	    ; FROM C.ROADS "CM TUTORIAL" p460
		outs		asig*irtl, asig*irtr
garvb	=		garvb+(asig*irvb)
		endin
												
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;												;
;		SINGLE GRAIN GLISS USING 'LINE' FOR 'CPSOFF/DENS'	;
;												;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
		
		instr 3
isine  	= 		1
ifunc2 	=		2
ifunc3 	= 		3
ifunc4 	= 		4
ifunc5 	= 		5
ifunc6 	= 		6
ifunc7 	= 		7
ifunc8	=		8
ifunc9	= 		9
ifunc10 	= 		10
idur   	= 		p3
iamp   	= 		ampdb(p4)
irvb   	= 		p5
ipan   	= 		p6
				
kdens	line		5, idur, 	250
kcpsoff	line    	5000, idur, 	25	
kamp   	oscil   	iamp, 1/idur, ifunc2, 0
kfreq  	oscil   	3900, 1/idur, ifunc3, 0

;			  	AMP,   PITCH,  DENS,   AMPOFF,  CPSOFF,  GDUR,GFN,WFN,MGDUR
a3	   	grain 	kamp,  kfreq,   kdens,  500,    kcpsoff,  .05, 2,   2, .15
irtl		=		sqrt(2)/2*cos(ipan)+sin(ipan)	    ; CONSTANT POWER PANNING
irtr		=		sqrt(2)/2*cos(ipan)-sin(ipan)	    ; FROM C.ROADS "CM TUTORIAL" p460
		outs		a3*irtl, a3*irtr
garvb	=		garvb+(a3*irvb)
		endin

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;												;
;		SINGLE GRAIN GLISS USING 'EXPON' FOR 'CPSOFF'	;
;												;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
												
		instr 4
isine  	= 		1
ifunc2 	= 		2
ifunc3 	= 		3
ifunc4 	= 		4
ifunc5 	= 		5
ifunc6 	= 		6
ifunc7 	= 		7
ifunc8 	= 		8
ifunc9 	= 		9
ifunc10	= 		10
idur   	= 		p3
iamp   	= 		ampdb(p4)
irvb   	= 		p5
ipan   	= 		p6
				
kdens	expon	5, 	  idur, 	500	
kcpsoff  	expon   	10000, idur, 	100	
kamp   	oscil   	iamp, 1/idur, ifunc2,  0
kfreq  	oscil   	1000, 1/idur, ifunc10, 0

;			  	AMP,   PITCH,  DENS, AMPOFF,  CPSOFF, GDUR,GFN,WFN,MGDUR
a4	   	grain 	kamp,  kfreq, kdens,  500,  kcpsoff, .05, 2,   2, .15
irtl		=		sqrt(2)/2*cos(ipan)+sin(ipan)	    ; CONSTANT POWER PANNING
irtr		=		sqrt(2)/2*cos(ipan)-sin(ipan)	    ; FROM C.ROADS "CM TUTORIAL" p460
		outs		a4*irtl, a4*irtr
garvb	=		garvb+(a4*irvb)
		endin
												
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;												;
;		SINGLE GRAIN GLISS USING 'LINEN' FOR 'CPSOFF'	;
;												;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

		instr 5
isine  	= 		1
ifunc2 	= 		2
ifunc3 	= 		3
ifunc4	= 		4
ifunc5 	= 		5
ifunc6 	= 		6
ifunc7 	= 		7
ifunc8 	= 		8
ifunc9 	= 		9
ifunc10	= 		10
idur   	= 		p3
iamp   	=	 	ampdb(p4)
irvb   	= 		p5
ipan   	= 		p6
irise  	= 		idur*.5
idec  	= 		idur*.5
				
kdens	linen	1000,  irise, .001, idec	
kcpsoff	linen   	5000,  irise, .001, idec		
kamp   	oscil   	iamp, 1/idur, ifunc2,  0
kfreq  	oscil   	3900, 1/idur, ifunc10, 0

;			  	AMP,   PITCH,  DENS, AMPOFF,  CPSOFF,   GDUR,GFN,WFN,MGDUR
a5	   	grain 	kamp,  kfreq,  kdens, 500,     kcpsoff,  .05, 2,   2, .15
irtl		=		sqrt(2)/2*cos(ipan)+sin(ipan)	    ; CONSTANT POWER PANNING
irtr		=		sqrt(2)/2*cos(ipan)-sin(ipan)	    ; FROM C.ROADS "CM TUTORIAL" p460
		outs		a5*irtl, a5*irtr
garvb	=		garvb+(a5*irvb)
		endin
												
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;												;
;		SINGLE GRAIN GLISS USING 'AMP OSCIL' FOR 'CPSOFF'	;
;												;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


		instr 6
isine  	= 		1
ifunc2 	= 		2
ifunc3 	= 		3
ifunc4 	= 		4
ifunc5 	= 		5
ifunc6 	= 		6
ifunc7 	= 		7
ifunc8 	= 		8
ifunc9 	= 		9
ifunc10	= 		10
idur   	= 		p3
iamp   	= 		ampdb(p4)
irvb   	= 		p5
ipan  	= 		p6
	
kamp   	oscil   	iamp, 1/idur, ifunc2,  0
kfreq  	oscil   	2000, 1/idur, ifunc10, 0

;			  	AMP,   PITCH,  DENS,     AMPOFF, CPSOFF, GDUR,GFN,WFN,MGDUR
a6	   	grain 	kamp,  kfreq,  kamp*.20,  100,    kamp,   .05, 2,   2, .15
irtl		=		sqrt(2)/2*cos(ipan)+sin(ipan)	    ; CONSTANT POWER PANNING
irtr		=		sqrt(2)/2*cos(ipan)-sin(ipan)	    ; FROM C.ROADS "CM TUTORIAL" p460
		outs		a6*irtl, a6*irtr
garvb	=		garvb+(a6*irvb)
		endin
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;												;
;		SINGLE GRAIN GLISS USING 'FREQ OSCIL' FOR 'CPSOFF';
;												;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
												

		instr 7
isine  	= 		1
ifunc2 	= 		2
ifunc3 	= 		3
ifunc4 	= 		4
ifunc5 	= 		5
ifunc6 	= 		6
ifunc7 	= 		7
ifunc8 	= 		8
ifunc9 	= 		9
ifunc10	= 		10
idur   	= 		p3
iamp   	= 		ampdb(p4)
irvb  	= 		p5
ipan   	=		 p6
	
kamp   	oscil   	iamp, 1/idur, ifunc2, 0
kfreq  	oscil   	3900, 1/idur, ifunc3, 0

;			  	AMP,	 PITCH, DENS,      AMPOFF, CPSOFF, GDUR,GFN,WFN,MGDUR
a7	   	grain 	kamp, kfreq, kfreq*.75, 500, 	  kfreq, .05,  2,  2, .15
irtl		=		sqrt(2)/2*cos(ipan)+sin(ipan)	    ; CONSTANT POWER PANNING
irtr		=		sqrt(2)/2*cos(ipan)-sin(ipan)	    ; FROM C.ROADS "CM TUTORIAL" p460
		outs		a7*irtl, a7*irtr
garvb	=		garvb+(a7*irvb)
		endin


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;													;
;		SINGLE GRAIN GLISS USING 'LINSEG' FOR 'CPSOFF/DENS' 	;
;													;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
													
		instr 8
isine 	= 		1
ifunc2 	= 		2
ifunc3 	= 		3
ifunc4 	=		4
ifunc5 	= 		5
ifunc6 	= 		6
ifunc7 	= 		7
ifunc8 	= 		8
ifunc9 	= 		9
ifunc10	= 		10
idur   	= 		p3
iamp   	= 		ampdb(p4)
irvb   	= 		p5
ipan   	= 		p6
idec   	= 		idur*.5
irise  	= 		idur*.5

kcpsoff 	linseg	5000, idec, 15, irise, 5000
kdens	linseg	1000, idec, 5,  irise, 1000
kamp   	oscil   	iamp, 1/idur, ifunc2, 0
kfreq  	oscil   	3900, 1/idur, ifunc3, 0

;			 	 AMP,   PITCH,  DENS, AMPOFF, CPSOFF, GDUR,GFN,WFN,MGDUR
a8	  	 grain 	kamp,  kfreq,  kdens,  500,   kcpsoff, .05, 2,   2, .15
irtl		=		sqrt(2)/2*cos(ipan)+sin(ipan)	    ; CONSTANT POWER PANNING
irtr		=		sqrt(2)/2*cos(ipan)-sin(ipan)	    ; FROM C.ROADS "CM TUTORIAL" p460
		outs		a8*irtl, a8*irtr
garvb	=		garvb+(a8*irvb)
		endin

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;												;
;		RISSET'S ENDLESS GLISSANDO (DOWN) - FROM DODGE	;
;												;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
												
		instr 9
isine  	= 		1
ifunc2 	= 		2
ifunc3	= 		3
idur   	= 		p3
iamp  	= 		ampdb(p4)
irvb   	= 		p5
ipan   	= 		p6
	
k10amp  	oscil 	iamp, 1/idur, ifunc2, 460.8
k10freq 	oscil 	3900, 1/idur, ifunc3, 460.8
k9amp   	oscil 	iamp, 1/idur, ifunc2, 409.6
k9freq  	oscil 	3900, 1/idur, ifunc3, 409.6
k8amp   	oscil 	iamp, 1/idur, ifunc2, 358.4
k8freq  	oscil 	3900, 1/idur, ifunc3, 358.4
k7amp   	oscil 	iamp, 1/idur, ifunc2, 307.2
k7freq  	oscil 	3900, 1/idur, ifunc3, 307.2
k6amp   	oscil 	iamp, 1/idur, ifunc2, 256.0
k6freq 	oscil 	3900, 1/idur, ifunc3, 256.0
k5amp   	oscil 	iamp, 1/idur, ifunc2, 204.8
k5freq  	oscil 	1000, 1/idur, ifunc3, 204.8
k4amp   	oscil 	iamp, 1/idur, ifunc2, 153.6
k4freq  	oscil 	3900, 1/idur, ifunc3, 153.6
k3amp   	oscil 	iamp, 1/idur, ifunc2, 102.4
k3freq  	oscil 	3900, 1/idur, ifunc3, 102.4
k2amp   	oscil 	iamp, 1/idur, ifunc2, 51.2
k2freq  	oscil 	3900, 1/idur, ifunc3, 51.2
k1amp   	oscil 	iamp, 1/idur, ifunc2, 0
k1freq  	oscil 	3900, 1/idur, ifunc3, 0

a10		oscil 	k10amp, k10freq, isine
a9		oscil 	k9amp,  k9freq,  isine
a8		oscil 	k8amp,  k8freq,  isine
a7  		oscil 	k7amp,  k7freq,  isine
a6		oscil 	k6amp,  k6freq,  isine  
a5		oscil 	k5amp,  k5freq,  isine
a4		oscil 	k4amp,  k4freq,  isine
a3		oscil 	k3amp,  k3freq,  isine
a2		oscil 	k2amp,  k2freq,  isine	
a1		oscil 	k1amp,  k1freq,  isine
asum 	= 		a1+a2+a3+a4+a5+a6+a7+a8+a9+a10
irtl		=		sqrt(2)/2*cos(ipan)+sin(ipan)	    ; CONSTANT POWER PANNING
irtr		=		sqrt(2)/2*cos(ipan)-sin(ipan)	    ; FROM C.ROADS "CM TUTORIAL" p460
		outs		asum*irtl, asum*irtr
garvb	=		garvb+(asum*irvb)
		endin

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;											;
;		SINGLE GLISS OSCIL UP					;
;											;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
											
		instr 10
isine  	= 		1
ifunc2 	= 		2
ifunc3 	= 		3
ifunc6 	= 		6
idur   	= 		p3
iamp   	= 		ampdb(p4)
irvb   	= 		p5
ipan   	= 		p6
	
kamp   	oscil 	iamp, 1/idur, ifunc2, 0
kfreq  	oscil 	3900, 1/idur, ifunc3, 0

a10	   	oscil 	kamp,  kfreq, isine
irtl		=		sqrt(2)/2*cos(ipan)+sin(ipan)	    ; CONSTANT POWER PANNING
irtr		=		sqrt(2)/2*cos(ipan)-sin(ipan)	    ; FROM C.ROADS "CM TUTORIAL" p460
		outs		a10*irtl, a10*irtr
garvb	=		garvb+(a10*irvb)
		endin
	
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;											;
;		SINGLE GLISS OSCIL DOWN					;
;											;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
											
		instr 11
isine  	= 		1
ifunc2 	= 		2
ifunc3	=		3
ifunc6 	= 		6
ifunc10	= 		10
idur   	= 		p3
iamp   	= 		ampdb(p4)
irvb   	= 		p5
ipan   	= 		p6
	
kamp   	oscil 	iamp, 1/idur, ifunc2, 0
kfreq  	oscil 	3900, 1/idur, ifunc10, 0

a11	   	oscil 	kamp,  kfreq, isine
irtl		=		sqrt(2)/2*cos(ipan)+sin(ipan)	    ; CONSTANT POWER PANNING
irtr		=		sqrt(2)/2*cos(ipan)-sin(ipan)	    ; FROM C.ROADS "CM TUTORIAL" p460
		outs		a11*irtl, a11*irtr
garvb	=		garvb+(a11*irvb)
		endin
		
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;												;
;		RISSET'S ENDLESS GLISSANDO (UP) - FROM DODGE		;
;												;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
												
		instr 12
isine  	= 		1
ifunc2 	= 		2
ifunc3	= 		3
ifunc10 	= 		10
idur   	= 		p3
iamp   	= 		ampdb(p4)
irvb   	= 		p5
ipan   	= 		p6

k10amp  	oscil 	iamp, 1/idur, ifunc2,  460.8
k10freq 	oscil 	3900, 1/idur, ifunc10, 460.8
k9amp   	oscil 	iamp, 1/idur, ifunc2,  409.6
k9freq  	oscil 	3900, 1/idur, ifunc10, 409.6
k8amp   	oscil 	iamp, 1/idur, ifunc2,  358.4
k8freq  	oscil 	3900, 1/idur, ifunc10, 358.4
k7amp   	oscil 	iamp, 1/idur, ifunc2,  307.2
k7freq  	oscil 	3900, 1/idur, ifunc10, 307.2
k6amp   	oscil 	iamp, 1/idur, ifunc2,  256.0
k6freq  	oscil 	3900, 1/idur, ifunc10, 256.0
k5amp   	oscil 	iamp, 1/idur, ifunc2,  204.8
k5freq  	oscil 	1000, 1/idur, ifunc10, 204.8
k4amp   	oscil 	iamp, 1/idur, ifunc2,  153.6
k4freq  	oscil 	3900, 1/idur, ifunc10, 153.6
k3amp   	oscil 	iamp, 1/idur, ifunc2,  102.4
k3freq  	oscil 	3900, 1/idur, ifunc10, 102.4
k2amp   	oscil 	iamp, 1/idur, ifunc2,  51.2
k2freq  	oscil 	3900, 1/idur, ifunc10, 51.2
k1amp   	oscil 	iamp, 1/idur, ifunc2,  0
k1freq  	oscil 	3900, 1/idur, ifunc10, 0

a10		oscil 	k10amp, k10freq, isine
a9		oscil 	k9amp,  k9freq,  isine
a8		oscil 	k8amp,  k8freq,  isine
a7  		oscil 	k7amp,  k7freq,  isine
a6		oscil 	k6amp,  k6freq,  isine  
a5		oscil 	k5amp,  k5freq,  isine
a4		oscil 	k4amp,  k4freq,  isine
a3		oscil 	k3amp,  k3freq,  isine
a2		oscil 	k2amp,  k2freq,  isine	
a1		oscil 	k1amp,  k1freq,  isine
asum 	= 		a1+a2+a3+a4+a5+a6+a7+a8+a9+a10
irtl		=		sqrt(2)/2*cos(ipan)+sin(ipan)	    ; CONSTANT POWER PANNING
irtr		=		sqrt(2)/2*cos(ipan)-sin(ipan)	    ; FROM C.ROADS "CM TUTORIAL" p460
		outs		asum*irtl, asum*irtr
garvb	=		garvb+(asum*irvb)
		endin

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;													;
;		RISSET'S ENDLESS/GRAIN GLISSANDO (UP/DOWN)- FROM DODGE	;
;													;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
													
		instr 13
isine  	= 		1
ifunc2 	= 		2
ifunc3 	= 		3
ifunc10	= 		10
idur   	= 		p3
iamp   	= 		ampdb(p4)
irvb   	= 		p5
ipan   	= 		p6
irise  	= 		idur*.5
idec   	= 		idur*.5

k10cpsoff	linseg	5000, idec, 15, irise, 5000
k10dens	linseg	1000, idec, 5,  irise, 1000	
k10amp  	oscil 	iamp, 1/idur, ifunc2,  460.8
k10freq 	oscil 	3900, 1/idur, ifunc3,  460.8
k9amp   	oscil 	iamp, 1/idur, ifunc2,  409.6
k9freq  	oscil 	3900, 1/idur, ifunc10, 409.6
k8amp  	oscil 	iamp, 1/idur, ifunc2,  358.4
k8freq  	oscil 	3900, 1/idur, ifunc3,  358.4
k7amp   	oscil 	iamp, 1/idur, ifunc2,  307.2
k7freq 	oscil 	3900, 1/idur, ifunc10, 307.2
k6dens	linen 	1000, irise, .001, idec	
k6cpsoff	linen 	5000, irise, .001, idec		
k6amp   	oscil 	iamp, 1/idur, ifunc2,  256.0
k6freq  	oscil 	3900, 1/idur, ifunc3,  256.0
k5amp   	oscil 	iamp, 1/idur, ifunc2,  204.8
k5freq  	oscil 	1000, 1/idur, ifunc10, 204.8
k4dens	expon 	5, 	 idur, 500	
k4cpsoff  expon 	10000,  idur, 100	
k4amp   	oscil 	iamp, 1/idur, ifunc2,  153.6
k4freq  	oscil 	3900, 1/idur, ifunc3,  153.6
k3amp  	oscil 	iamp, 1/idur, ifunc2,  51.2
k3freq  	oscil 	3900, 1/idur, ifunc10,  51.2
k2dens	line 	5,	 idur, 250
k2cpsoff	line  	5000,   idur, 25	
k2amp   	oscil 	iamp, 1/idur, ifunc2,  102.4
k2freq  	oscil 	3900, 1/idur, ifunc3, 102.4
k1amp   	oscil 	iamp, 1/idur, ifunc2,  0
k1freq 	oscil 	3900, 1/idur, ifunc10, 0

;			 	AMP,    PITCH,     DENS,      AMPOFF, CPSOFF, GDUR,GFN,WFN,MGDUR
a10	   	grain 	k10amp, k10freq,   k10dens*.5, 250,  k10cpsoff, .05, 2,   2, .15
a9	   	grain 	k9amp,  k9freq,    k9freq*.3, 250,   k9freq*.3, .05, 2,   2, .15
a8		oscil 	k8amp,  k8freq,    isine
a7	    	grain 	k7amp,  k7freq,    k7amp*.20,	250,   k7amp*.2,  .05, 2,   2, .15
a6	    	grain 	k6amp,  k6freq,    k6dens*.5, 250,   k6cpsoff,  .05, 2,   2, .15
a5		oscil 	k5amp,  k5freq,    isine
a4	    	grain 	k4amp,  k4freq,    k4dens*.5, 250,   k4cpsoff,  .05, 2,   2, .15
a3		oscil 	k3amp,  k3freq,    isine	
a2	    	grain 	k2amp,  k2freq,    k2dens,  	250,   k2cpsoff,  .05, 2,   2, .15
a1		oscil 	k1amp,  k1freq,    isine
asum 	= 		a1+a2+a3+a4+a5+a6+a7+a8+a9+a10
irtl		=		sqrt(2)/2*cos(ipan)+sin(ipan)	    	; CONSTANT POWER PANNING
irtr		=		sqrt(2)/2*cos(ipan)-sin(ipan)		; FROM C.ROADS "CM TUTORIAL" p460
		outs		asum*irtl, asum*irtr
garvb	=		garvb+(asum*irvb)
		endin

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;											;
;		REVERB 								;
;											;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
											
		instr 99
asig		nreverb 	garvb, p4, p5
		outs    	asig, asig
garvb	=		0
		endin
		

