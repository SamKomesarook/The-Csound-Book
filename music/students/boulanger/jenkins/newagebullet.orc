sr=44100
kr=4410
ksmps=10
nchnls=2

gadly	init	0
garvbsig init 0

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

instr 4				;poo
iboop	=	p3-p6
iamp	=	ampdb(p4)
ifreq	=	cpspch(p5)	
istart	=	p6
iend	=	p8
			
kenv	expseg	.01,	istart, iamp, iboop, iend
k1		oscil	1000,	ifreq,	1

k2		expseg	10000,	.5,	.01
a1		oscil	kenv,	k1,	1	

kpan	oscil	.5,	.5,	1, p7

kpan	=	kpan + .5

outs a1*(1-kpan), a1*kpan
endin

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

instr 5					;DING
iboop	=	p3-p6
iamp	=	ampdb(p4)
ifreq	=	cpspch(p5)	
istart	=	p6								
iend	=	p7								
ipan	=	p8
ivdec	=	p9

		
kenv	expseg	.01,	istart, iamp, iend, .01
k1		oscil	1000,	ifreq,	1

a1		oscil	kenv,	k1,	1

afilt1	butterlp	a1*.01, 1000

averb	reverb	afilt1,	ivdec

kpan	oscil	.5,	.8,	1

aout = a1+averb 
outs aout*ipan,aout*(ipan-1)

gadly	=	gadly + aout*.5
endin

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
instr 6							;beep4
iboop	=	p3-p6
iamp	=	ampdb(p4)
ifreq	=	cpspch(p5)	
istart	=	p6
iend	=	p7
ipan	=	p8
;	

		
kenv	expseg	.01,	istart, iamp, iend, .01
k1		oscil	1000,	ifreq,	1


a1		oscil	kenv,	k1,	1

afilt1	butterlp	a1*.01, 800

averb	reverb	afilt1,	8

kpan	oscil	.5,	.8,	1

aout = a1+averb 
outs aout*ipan,aout*(ipan-1)


endin

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
instr 7;    zkick               Jeremy Zuckerman's kick 
iboop = p3-(p5+p7+.1)
irvbgain = p10

k2  expseg  p4, p5, p6, p7, p8, iboop, p9

k1  linen  1, .001, p3, 1

a2  oscil  1, k2, 1

a1  reson  a2, 80, 10

a3	linseg	1, p3 * .9375, 1, p3 * .0625, 0

outs a1*k1, a1*k1

garvbsig     =       garvbsig + a1	 * p10 * a3

display  k2, 1
endin

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
instr	3							;SOOTHIE

iamp	=	ampdb(p4)			;ia = start dB of env
ifreq	=	cpspch(p5)			;ic = end dB of env
ia		=	p6
idur	=	p7
idur2	=	p8
ic		=	p9
iatk	=	p10
idlytim =   p11
 
k1	 		linseg	ia,	idur,iamp, idur2, ic
k2	 		line	100, 30,	3000
kenv		linseg	0, iatk, 1, 1, 0
ksamphold 	randh 800, 4

a1	 		oscil	k1,	ifreq,	2
a2			oscil	10000,	220,	1 

afilt1 		butterlp	a1,	k2
afilt2		reson		afilt1*.002,	k2,	50
afilt3		reson		afilt2*.0002,	ksamphold*.5, 15

abalance	balance		afilt3,	a2

adelay		comb		abalance*kenv,	25,	idlytim
averb		reverb2		adelay*.333,	.5, 0

outs 		(averb*.5)+(adelay), (averb*.5)+(adelay)
endin

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

instr 8						;noise
iamp	=	ampdb(p4)
iblow	=	p5

kcut	linseg	30, 10,	1000,	10,	15	
a1	randi	iamp,	iblow

afilt	butterlp	a1,	kcut,	10
averb	reverb	afilt*.1,	15
a3	linseg	.01, .3, 1, p3-1, 1, .3, 0

outs	afilt*a3, afilt*a3
garvbsig  =  garvbsig + afilt*.05*a3
endin

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
instr 9					;poo2

iboop	=	p3-p6
iamp	=	ampdb(p4)
ifreq	=	cpspch(p5)	
istart	=	p6
iphase	=	p7
ipanshape	=	p8
;				
kenv	expseg	.01,	istart, iamp, iboop, 70
k1		oscil	1000,	ifreq,	1

k2		expseg	10000,	.5,	.01
a1		oscil	kenv,	k1,	1	

kpan	oscil	.5,	.8,	ipanshape, iphase

kpan	=	kpan + .5

outs a1*(1-kpan), a1*kpan
endin

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
instr 10			;what is it doing to m?
irvbgain = p4
ibalance = p7	
									
kenv	linseg	0, .5, 1

a1	soundin	"what.aif"


;				  fedbk	dtm								;p5=delay fedback
acomb	comb	a1,	p5,	p6								;p6=delay time

averb	reverb2	acomb,	p8,	p9							;p8 ktime							
	
														;p9	khdif(high freq diffusion 0-1)
										

outs averb*kenv*ibalance, averb*kenv*(ibalance-1)

endin

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
instr	103		;DING DELAY

ipan	=	p4
idecay	=	p5
idrate	=	p6
a1	comb	gadly, idecay,	idrate

outs a1*ipan,a1*(ipan-1)

gadly	=	0

endin

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
instr 105	;zkick verb			

abutt         reverb2  garvbsig, 30, 0
	
outs    abutt,abutt
garvbsig      =       0
endin


