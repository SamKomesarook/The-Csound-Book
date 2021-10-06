sr = 44100
kr = 4410
ksmps = 10
nchnls = 2

instr 1
; INITIALIZATION
; Normalize to 80 dB = ampdb(80).
iamplitude = 	ampdb(p5) * 15848.926 / 4200
iattack 	= 	.015
irelease 	= 	.03
isustain 	= 	p3 - (iattack + irelease)
if isustain > 0 goto longenvelope
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
aenv 	expseg 	1.0 / 10000.0, iattack, 1.0, isustain, 1.0, irelease, 1.0 / 10000.0
ag 	pluck 	iamplitude,cpsoct(ioct+kvib),iamplitude/2,1,1
agleft 	pluck 	iamplitude,cpsoct(ioct+ishift),iamplitude/2,1,1
agright 	pluck 	iamplitude,cpsoct(ioct-ishift),iamplitude/2,1,1
adump 	delayr 	0.5
adump1 delayr 0.7
	delayw ag * aenv ;put ag signal into delay line.
ad1 	deltap 	0.1
ad2 	deltap 	0.21
	outs 	ileftpan * aenv * (agleft + ad1), irightpan * aenv * (agright + ad2)








endin
instr 2
; LOGGING
; p1 = Instrument
; p2 = Start
; p3 = Length
; p4 = Octave
; p5 = Decibels
; p6 = Pan
print 	p2, p3, p4, p5, p6
; INITIALIZATION
iattack 	= 	.015
irelease 	= 	.065
isustain 	= 	p3 - (iattack + irelease)
if isustain > 0 goto longenvelope
isustain 	= 	0
p3 	= 	iattack + isustain + irelease
longenvelope:
ifrequency 	= 	cpsoct(p4)
; Normalize to 80 dB = ampdb(80).
iamplitude =	ampdb(p5) * 15848.926 / 1848
ileftpan 	= 	(0.5 - p6) / 2.0
irightpan 	= 	(0.5 + p6) / 2.0
; KONTROL
kamp	linseg	0.0, iattack, iamplitude, isustain, iamplitude, irelease, 0.0
; AUDIO
asig	pluck 	kamp, ifrequency, ifrequency, 0, 1
af1	reson	asig, 110, 80
af2	reson	asig, 220, 100
af3	reson	asig, 440, 80
aout	balance 	0.6*af1+af2+0.6*af3+0.4*asig, asig
	outs 	aout * ileftpan, aout* irightpan















endin
instr 3
; INITIALIZATION
; Normalize to 80 dB = ampdb(80).
iamplitude = 	ampdb(p5) * 15848.926 / 4200
iattack 	= 	.015
irelease 	= 	.03
isustain 	= 	p3 - (iattack + irelease)
if isustain > 0 goto longenvelope
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
aenv 	expseg 	1.0 / 10000.0, iattack, 1.0, isustain, 1.0, irelease, 1.0 / 10000.0
ag 	pluck 	iamplitude,cpsoct(ioct+kvib),iamplitude/2,1,1
agleft 	pluck 	iamplitude,cpsoct(ioct+ishift),iamplitude/2,1,1
agright 	pluck 	iamplitude,cpsoct(ioct-ishift),iamplitude/2,1,1
adump 	delayr 	0.5
adump1 delayr 0.7
	delayw ag * aenv ;put ag signal into delay line.
ad1 	deltap 	0.1
ad2 	deltap 	0.21
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
print 	p2, p3, p4, p5, p6
; INITIALIZATION
iattack 	= 	.015
idecay 	= 	.5
ifrequency = 	cpsoct(p4)
; Normalize to 80 dB = ampdb(80).
iamplitude = 	ampdb(p5) * 15848.926 / 42633.1
ileftpan 	= 	0.5 - p6 / 2
irightpan 	= 	0.5 + p6 / 2
; Offsets for oscillators based on original p6.
ioffset 	= 	0.04
i1 	= 	ioffset
i2 	= 	2 * ioffset
i3 	= 	3 * ioffset 
i4 	= 	4 * ioffset 
; AUDIO
; A simple envelope to prevent clicking.
aenvelope linen 	iamplitude, iattack, p3, idecay
; Nine oscillators with the same envelope
; and waveform, but slightly different
; frequencies to create the beating effect.
a1 	oscili 	aenvelope, ifrequency, 33
a2 	oscili 	aenvelope, ifrequency + i1, 33
a3 	oscili 	aenvelope, ifrequency + i2, 33
a4 	oscili 	aenvelope, ifrequency + i3, 33
a5 	oscili 	aenvelope, ifrequency + i4, 33
a6 	oscili 	aenvelope, ifrequency - i1, 33
a7 	oscili 	aenvelope, ifrequency - i2, 33
a8 	oscili 	aenvelope, ifrequency - i3, 33
a9 	oscili 	aenvelope, ifrequency - i4, 33
asignal 	= 	a1 + a2 + a3 + a4 + a5 + a6 + a7 + a8 + a9
	outs 	asignal * ileftpan, asignal * irightpan 















endin
