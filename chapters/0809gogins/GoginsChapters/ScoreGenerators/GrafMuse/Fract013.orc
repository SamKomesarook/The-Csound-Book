sr = 44100
kr = 4410
ksmps = 10
nchnls = 2

instr 1
; INITIALIZATION
; Normalize to 80 dB = ampdb(80).
iamplitude = ampdb(p5) * 15848.926 / 4901
ileftpan = (0.5 - p6) / 2.0
irightpan = (0.5 + p6) / 2.0
iattack = .05
irelease= .1
if p3 > .15 then goto longenvelope
p3 = .15
longenvelope:
iattack = p3/3
isustain = p3/3
irelease = p3 - (iattack + isustain)
ip6 = .3
ip7 = 2.2
ishift	=	8.0 / 1200.0
ipch	=	cpsoct(p4)
ioct	=	p4

; LOGGING
; p1 = Instrument
; p2 = Start
; p3 = Length
; p4 = Octave
; p5 = Decibels
; p6 = Pan
print p2, p3, p4, p5, p6

; KONTROL
kadsr	linseg	0,iattack,1,isustain,1,irelease,0
kmodi	linseg	0,iattack,5,isustain,3,irelease,0
kmodr	linseg	ip6,p3,ip7	;r moves from ip6 to ip7 in p3 secs.

; AUDIO
a1	=	kmodi*(kmodr - 1/kmodr)/2
a1ndx	=	abs(a1*2/20)	;a1*2 is argument normalized from 0-1.
a2	=	kmodi*(kmodr + 1/kmodr)/2	
a3	tablei	a1ndx,43,1	;look up table is in f43, normalized index.
ao1	oscil	a1,ipch,42		;cosine
a4	=	exp(-0.5*a3+ao1)
ao2	oscil	a2*ipch,ipch,42		;cosine
aoutl	oscil	iamplitude*kadsr*a4,ao2+cpsoct(ioct+ishift),1	;final output left
aoutr	oscil	iamplitude*kadsr*a4,ao2+cpsoct(ioct-ishift),1	;final output right
outs	ileftpan * aoutl, irightpan * aoutr








endin
instr 2
; LOGGING
; p1 = Instrument
; p2 = Start
; p3 = Length
; p4 = Octave
; p5 = Decibels
; p6 = Pan
print p2, p3, p4, p5, p6

; INITIALIZATION
imodulator = 6.166667
ifmamplitude = 3
index = .05
iattack = .015
irelease = .125
isustain = p3  - (iattack + irelease)
if isustain > 0 goto longenvelope
isustain = 0.03
p3 = iattack + isustain + irelease
longenvelope:
ifrequency = cpsoct(p4)
icarrier =  .998
icarrierb =  1.002
; Normalize to 80 dB = ampdb(80).
iamplitude = ampdb(p5) * 15848.926 / 12729.0
ileftpan = (0.5 - p6) / 2.0
irightpan = (0.5 + p6) / 2.0

; KONTROL
kindenv expseg .00001, iattack, 1, isustain, .1, irelease, .00001
kindex = kindenv * index * ifmamplitude

; AUDIO	
aouta foscili iamplitude, ifrequency, icarrier, imodulator, kindex, 1
aoutb foscili iamplitude, ifrequency, icarrierb, imodulator, kindex, 1
afmout = (aouta + aoutb) * kindenv * 2.556
outs ileftpan * afmout, irightpan * afmout















endin
instr 3
; INITIALIZATION
; Normalize to 80 dB = ampdb(80).
iamplitude = ampdb(p5) * 15848.926 / 4200
iattack = .015
irelease = .03
isustain 	= 	p3 - (iattack + irelease)
if 	isustain > 0 goto longenvelope
isustain 	= 	0
longenvelope:
p3 	= 	iattack + isustain + irelease
ileftpan 	= 	(0.5 - p6) / 2.0
irightpan 	= 	(0.5 + p6) / 2.0
ishift 	= 	8.0 / 1200.0
ipch 	= 	cpsoct(p4)
ioct 	= 	p4
; LOGGING
; p1 = Instrument
; p2 = Start
; p3 = Length
; p4 = Octave
; p5 = Decibels
; p6 = Pan
	print 	p2, p3, p4, p5, p6
; KONTROL
kvib 	oscil 	1.0 / 120.0, ipch / 50.0, 41
; AUDIO
aenv	expseg 	1.0 / 10000.0, iattack, 1.0, isustain, 1.0, irelease, 1.0 / 10000.0
ag	pluck 	iamplitude,cpsoct(ioct+kvib),iamplitude/2,1,1
agleft 	pluck 	iamplitude,cpsoct(ioct+ishift),iamplitude/2,1,1
agright 	pluck 	iamplitude,cpsoct(ioct-ishift),iamplitude/2,1,1
adump 	delayr 	0.3
	delayw 	ag * aenv ;put ag signal into delay line.
ad1 	deltap 0.1
ad2 	deltap 0.21
	outs 	ileftpan * aenv * (agleft + ad1), irightpan * aenv * (agright + ad2)








endin
instr 4
; LOGGING
; p1 = Instrument
; p2 = Start
; p3 = Length
; p4 = Octave
; p5 = Decibels
; p6 = Pan
print p2, p3, p4, p5, p6

; INITIALIZATION
; Envelope initialization.
iduration = p3
ifrequency = cpsoct(p4)
; Normalize to 80 dB = ampdb(80).
iamplitude = ampdb(p5) * 15848.926 / 4739
ileftpan = (0.5 - p6) / 2.0
irightpan = (0.5 + p6) / 2.0

; KONTROL
kenvelope expon iamplitude, iduration, 1

; AUDIO
apluck pluck iamplitude, ifrequency, ifrequency, 0, 1
aharp oscil kenvelope, ifrequency, 46
aoutsignal = apluck + aharp
outs aoutsignal * ileftpan, aoutsignal * irightpan















endin
instr 5
; LOGGING
; p1 = Instrument
; p2 = Start
; p3 = Length
; p4 = Octave
; p5 = Decibels
; p6 = Pan
print p2, p3, p4, p5, p6

; INITIALIZATION
iattack = .015
irelease = .065
isustain = p3 - (iattack + irelease)
if isustain > 0 goto longenvelope
isustain = 0
p3 = iattack + isustain + irelease
longenvelope:
ifrequency = cpsoct(p4)
; Normalize to 80 dB = ampdb(80).
iamplitude = ampdb(p5) * 15848.926 / 1848
ileftpan = (0.5 - p6) / 2.0
irightpan = (0.5 + p6) / 2.0

; KONTROL
kamp	linseg	0.0, iattack, iamplitude, isustain, iamplitude, irelease, 0.0

; AUDIO
asig	pluck 	kamp, ifrequency, ifrequency, 0, 1
af1	reson	asig, 110, 80
af2	reson	asig, 220, 100
af3	reson	asig, 440, 80
aout	balance 0.6*af1+af2+0.6*af3+0.4*asig, asig
outs 	aout * ileftpan, aout* irightpan















endin
