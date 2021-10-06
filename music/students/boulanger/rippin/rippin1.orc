;Greg Rippin
;NYU
;3/20/01

sr = 44100
kr = 4410
ksmps = 10
nchnls = 2

;dedicated reverb for bell instrument (4)
garvbl 		init 0
garvbr		init 0
 
	instr 4 ;based on Risset bell instrument
idur	= p3
iamp	= p4
ifrq	= cpspch(p5)
ipan	= p6
klfoc	linseg 0, idur*.25, 0, idur*.25, iamp*.002, idur*.5, iamp*.001 ;lfo delay control
klfot	oscil klfoc, 6, 3 ;tremelo lfo
klfov	oscil klfoc*.1, ifrq*.01, 3 ;vibrato lfo
kenv   	oscil iamp,1/idur,8 
asig    oscil kenv+klfot,ifrq+klfov,3
aoutl	= asig*ipan
aoutr	= asig*(1-ipan)
	outs aoutl, aoutr
garvbl	= garvbl+(.1*aoutl)
garvbr	= garvbr+(.1*aoutr)
	endin

	instr 5 ;drone
idur	= p3
iamp	= p4
ifrq	= p5
igrndur	= .1
kenv	oscil 1, 1/idur, 7
kfrq	linseg ifrq, idur/3, ifrq, idur/6, 1.1*ifrq, idur/6, ifrq, idur/3, ifrq
;left channel
agrainl	grain iamp*kenv, kfrq, 2000*kenv, 1000,40*kenv, igrndur, 3, 7, igrndur*2
anoisel	rand 2*iamp*kenv
afiltl	butterbp anoisel, kfrq, 200
addl	= (agrainl + afiltl)
;right channel
agrainr grain iamp*kenv, kfrq*1.01, 2000*kenv, 1000,40*kenv, igrndur, 3, 7, igrndur*2
anoiser rand iamp*kenv
afiltr	butterbp anoiser, kfrq, 200
addr	= (agrainr + afiltr)
	outs addl, addr
	endin

instr 6	;wash 
idur	= p3
iamp	= p4
ifrq	= cpspch(p5)
kenv	expseg	.001, .2*idur, 1, .05*idur, 1, .75*idur, .001
koct	linseg 0, idur*.1, 0, idur*.8, 6, idur*.1, 6
kfrq	expseg .9*ifrq, .1*idur, ifrq, .8*idur, ifrq, .1*idur, .8*ifrq
kpan	line 0, idur, 1
ain	fof 15000*kenv, 100, kfrq, koct, 20, .01, .02, .007, 5, 3, 9, idur
afilt	butterlp ain, ifrq*.85
	outs afilt*kpan, afilt*(1-kpan)
	endin



	instr 99 ;dedicated verb for bell
arvbl	reverb garvbl, 3 
arvbr	reverb garvbr, 3.1 
	outs arvbl, arvbr
garvbl	= 0
garvbr	= 0
	endin
