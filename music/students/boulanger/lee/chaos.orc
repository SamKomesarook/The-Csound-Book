; Kyogu Lee - NYU - Spring 2001

sr      =       44100
kr      =       4410
ksmps   =       10
nchnls  =       2

garvb	init	0


		instr	1		; wind generator
idur	=		p3
iamp	= 		p4
imodrt	=		p5
imoddp	=		p6
icf		=		p7
ibw		=		p8
alfo	randi	1, imodrt
anoise	rand	iamp
asig	reson	anoise, icf+alfo*imoddp, ibw
kenv	linseg	0, idur/2, 1, idur/2, 0
		outs	kenv*asig, kenv*asig
		endin
		
		

        instr	2		; FM Synth
idur	=		p3
icaramp	=		p4
icafrq1	=		p5
icafrq2	=		p6
imodin1	=		p7
imodin2	=		p8
ifcfm1	=		p9
ifcfm2	=		p10
imodfn	=		p11
icarfn	=		p12
ipan	=		p13
kcarfrq	linseg	icafrq1, idur, icafrq2
kmodind	linseg	imodin1, idur, imodin2
kfcfmra	linseg	ifcfm1, idur, ifcfm2
kpan	linseg	ipan, idur, 1-ipan
kmodenv	linen	kmodind*(kcarfrq/kfcfmra), idur/4, idur/2, idur/4
kcarenv	linen	icaramp, .01, idur, idur/5
amod	oscili	kmodenv, kcarfrq/kfcfmra, imodfn
asig	oscili	kcarenv, kcarfrq+amod, icarfn
		outs	kpan*asig, (1-kpan)*asig
		endin



		instr	3		; bass

i1		=		cpspch(p4)
i2		=		int((80000/i1)+.5)
i3		=		1/32767
a1		linen	p5,p6,p3,p7
k1		linen	p5,p6,p3,p7
a2		buzz	a1,i1,i2,3
a2		reson	a2,i1,i1,1,0
a2		reson	a2,500,500,1,0
a2		reson	a2,1500,750,1,0
a2		reson	a2,3000,1200,1,0
a2		balance	a2,a1
k1		= 		(k1*i3)*8000
a1		reson	a2,0.,k1,1,0
		outs	a1, a1
garvb	=		garvb+(a1*p8)     
		endin
		
		
		
		instr	4		; arpeggio

;p4		=		freq of fundamental (Hz)
;p5		=		amp
;p6		=		initial offset of freq - .03 Hz

; INIT VALUES CORRESPOND TO FREQ. OFFSETS FOR OSCILLATORS BASED ON ORIGINAL p6

i1		=		p6
i2		=		2*p6
i3		=		3*p6
i4		=		4*p6
                    
ampenv	linen	p5,.01,p3,.02		; A SIMPLE ENVELOPE TO PREVENT CLICKING.
                                             
a1		oscili	ampenv,cpspch(p4),7		; NINE OSCILLATORS WITH THE SAME AMPLITUDE ENV
a2		oscili	ampenv,cpspch(p4)+i1,7	; AND WAVEFORM, BUT SLIGHTLY DIFFERENT
a3		oscili	ampenv,cpspch(p4)+i2,7	; FREQUENCIES TO CREATE THE BEATING EFFECT
a4		oscili	ampenv,cpspch(p4)+i3,7
a5		oscili	ampenv,cpspch(p4)+i4,7
a6		oscili	ampenv,cpspch(p4)-i1,7
a7		oscili	ampenv,cpspch(p4)-i2,7
a8		oscili	ampenv,cpspch(p4)-i3,7
a9		oscili	ampenv,cpspch(p4)-i4,7
amix	=		a1+a2+a3+a4+a5+a6+a7+a8+a9
		outs 	amix, amix
garvb	=		garvb+(amix*p7)
		endin
		
		
		instr 	99		; global reverb
idur	=		p3
irvbtim	=		p4
arvb	reverb	garvb, irvbtim
		outs	arvb, arvb
garvb	=		0
		endin


