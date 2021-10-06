; SIGNALS
; COPYRIGHT 1997 BY ADAM ZYGMUNT
; 
; ORCHESTRA FILE
;
; TO COMPILE, MAKE SURE YOUR CSOUND EXECUTABLE IS IN YOUR PATH, THEN USE THE COMMAND
; CSOUND -WGO SIGNALS.WAV SIGNALS.ORC SIGNALS.SCO
; THEN LOAD SIGNALS.WAV INTO YOUR .WAV PLAYER AND ENJOY!

sr		=		44100
kr		=		4410
ksmps	=		10
nchnls	=		2


		instr 1
; CHORUSED INSTRUMENT
idur		=		p3
iamp		=		p4
ipitch 	= 		cpspch(p5)
iatt		=		p6  				; % of dur
idec		=		p7  				; % of dur
ivib		=		p8  				; cps
ipan		=		p9  				; 0<ipan<1, amount of vib. panning
ifn		=		p10

kenv 	linen 	iamp/3, iatt*idur, idur, idec*idur
a1 		oscili 	kenv, ipitch-ivib, ifn
a2 		oscili 	kenv, ipitch, ifn
a3 		oscili 	kenv, ipitch+ivib, ifn
kpan 	oscili 	.5*ipan, ivib, 1
asum		=		a1+a2+a3

		outs 	asum*(kpan+.5), asum*(.5-kpan)
		endin


		instr 2
; FM INSTRUMENT
idur		=		p3
iamp		=		p4
ipitch	=		cpspch(p5)
icar		=		p6
imod		=		p7
ivibd	=		p8  			; mod. pitch vibrato (added to mod. multiplier)
ivibs	=		p9  			; vib. speed in cps
iatt		=		p10  		; total amp. env., % of dur
idec		=		p11  		; % of dur
ifn		=		p12

kndx 	line 	4, idur, 1
kenv 	linen 	iamp, iatt*idur, idur, idec*idur
kv 		oscili 	ivibd, ivibs, 1

a1 		foscili 	kenv, ipitch, icar, imod+kv, kndx, ifn
a2 		foscili 	kenv, ipitch, icar, imod-kv, kndx, ifn
		outs 	a1, a2
		endin


		instr 3
; CROSSFADE INSTRUMENT
idur		=		p3
iamp		=		p4
ipitch1	=		cpspch(p5)
ipitch2	=		cpspch(p6)
iatt		=		p7  			; % of dur
idec		=		p8  			; % of dur
ivib		=		p9  			; cps
ipan		=		p10  		; 0<pan<1
ifn1		=		p11
ifn2		=		p12

kenv 	linen 	iamp, iatt*idur, idur, idec*idur
kfade 	expon 	1, idur, .01

a1 		oscili 	kenv*kfade, ipitch1, ifn1
a2 		oscili 	kenv*(1-kfade), ipitch2, ifn2

kpan 	oscili 	.5*ipan, ivib, 1
asum		=		a1+a2
		outs 	asum*(kpan+.5), asum*(.5-kpan)
		endin 


		instr 4
; BEEP
idur		=		p3
iamp		=		p4
ipitch	=		cpspch(p5)
iatt		=		p6  			; % of dur
idec		=		p7  			; % of dur
iloc		=		p8  			; -1<iloc<1, -1=channel 1, 1=channel 2
ifn		=		p9

kenv 	linen 	iamp, iatt*idur, idur, idec
klfo 	oscili 	5, 2, 1

a1 		oscili 	kenv*.3, ipitch, ifn
a2 		oscili 	kenv*.3, ipitch*1.002, ifn
a3 		oscili 	kenv*.2, ipitch*2+klfo, ifn
a4 		oscili 	kenv*.2, ipitch*3-klfo, ifn

asum		=		a1+a2+a3+a4
iloc		=		(iloc+1)/2
		outs 	iloc*asum, (1-iloc)*asum
		endin

		instr 5
; JITTER
idur		=		p3
iamp		=		p4
ipitch	=		cpspch(p5)
ipitchr	=		cpspch(p5+p6)-cpspch(p5-1+.12-p6)  ; spread of frequencies for randh in semitones
irate	=		p7  							; rate of random pitch change (cps)
iatt		=		p8  							; % of dur
idec		=		p9  							; % of dur
ipan		=		p10  						; amount of random panning (0 to 1)
ifn		=		p11

kenv 	linen 	iamp, iatt*idur, idur, idec*idur
kp 		randh 	ipitchr, irate, p2/500
k1 		line 	0, idur, ipan

a1 		oscili 	kenv*.3, ipitch+kp, ifn
a2 		oscili 	kenv*.2, (ipitch+kp)+(ipan-k1)*6, ifn
a3 		oscili 	kenv*.2, (ipitch+kp)-(ipan-k1)*6, ifn

asum		=		a1+a2+a3
kpan 	randi 	k1, irate
kpan		=		(kpan+1)/2
		outs 	kpan*asum, (1-kpan)*asum
		endin


		instr 6
; FALL
idur		=		p3
iamp		=		p4
ipitch	=		cpspch(p5)
iatt		=		p6
ifn		=		p7

kenv 	expseg 	1, idur*.2, .4, idur*.3, .5, idur*.5, .001
kenv2 	linen 	iamp, iatt*idur, idur, 0
kp 		expseg 	1, idur*.3, 1, idur*.7, .9

a1 		oscili 	kenv*kenv2*.4, ipitch*kp, ifn 
a2 		oscili 	kenv*kenv2*.2, ipitch*2*kp, ifn
a3 		oscili 	kenv*kenv2*.4, ipitch*kp+kenv*4, ifn

asum		=		a1+a2+a3
		outs 	asum, asum*.2
		endin

		instr 7
; VOX
idur		=		p3
iamp		=		p4
ipitch	=		cpspch(p5)
iatt		=		p6  						; % of dur
idec		=		p7  						; % of dur
ivib		=		p8  						; cps
ipan		=		p9  						; 0<ipan<1, amount of vib. panning
if1 		table 	p10*3, 6
if2 		table 	p10*3+1, 6
if3 		table 	p10*3+2, 6  				; look up vowel formants in table

kenv 	linen 	iamp, iatt*idur, idur, idec*idur
kvib 	oscili 	ivib, ivib, 1

asrc 	buzz 	kenv, ipitch+kvib, 7, 1
a1 		butterbp 	asrc, if1, 40
a2 		butterbp 	asrc, if2, 40
a3 		butterbp 	asrc, if3, 40

kpan 	oscili 	.5*ipan, ivib, 1
asum		=		a1+a2+a3
asum 	balance 	asum, asrc
		outs 	asum*(kpan+.5), asum*(.5-kpan)
		endin


		instr 8
; SQUIRM
idur		=		p3
iamp		=		p4
ipitch	=		cpspch(p5)
ipitchr	=		cpspch(p5+p6)-cpspch(p5-1+.12-p6)  ; spread of frequencies for randh in semitones
irate	=		p7  							; rate of random pitch change (cps)
iatt		=		p8  							; % of dur
idec		=		p9  							; % of dur
ipan		=		p10  						; amount of random panning (0 to 1)
ifn		=		p11

kenv 	linen 	iamp, iatt*idur, idur, idec*idur
kp 		randi 	ipitchr, irate, p2/500
k1 		line 	0, idur, ipan

a1 		oscili 	kenv*.3, ipitch+kp, ifn
a2 		oscili 	kenv*.2, (ipitch+kp)+(ipan-k1)*6, ifn
a3 		oscili 	kenv*.2, (ipitch+kp)-(ipan-k1)*6, ifn

asum		=		a1+a2+a3
kpan 	randi 	k1, irate
kpan		=		(kpan+1)/2
		outs 	kpan*asum, (1-kpan)*asum
		endin


		instr 9
; FM BEND INSTRUMENT
idur		=		p3
iamp		=		p4
ipitch	=		cpspch(p5) 	;starting pitch
ipitch2	=		cpspch(p6) 	;ending pitch
icar		=		p7
imod		=		p8
ivibd	=		p9  			; mod. pitch vibrato (added to mod. multiplier)
ivibs	=		p10  		; vib. speed in cps
iatt		=		p11  		; total amp. env., % of dur
idec		=		p12  		; % of dur
ifn		=		p13

kndx 	line 	4, idur, 1
kenv 	linen 	iamp, iatt*idur, idur, idec*idur
kp 		expseg 	1, idur*.3, 1, idur*.7, ipitch2/ipitch
kv 		oscili 	ivibd, ivibs, 1

a1 		foscili 	kenv, ipitch*kp, icar, imod+kv, kndx, ifn
a2 		foscili 	kenv, ipitch*kp, icar, imod-kv, kndx, ifn
		outs 	a1, a2
		endin

