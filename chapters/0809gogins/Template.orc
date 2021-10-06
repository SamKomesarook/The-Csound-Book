sr = 44100
kr = 44100
ksmps = 1
nchnls = 2

instr 1
; INITIALIZATION
iattack 	= 	.012
irelease 	= 	.075
isustain 	= 	p3 - (iattack + irelease)
	if isustain > 0 goto longenvelope
isustain 	= 	0
p3 	= 	iattack + isustain + irelease
	longenvelope:
ifrequency = 	cpsoct(p4)
; Normalize to 80 dB = ampdb(80).
iamplitude = 	ampdb(p5) * 15848.926 / 5398.0
ileftpan 	= 	(0.5 - p6) / 2
irightpan 	= 	(0.5 + p6) / 2
; LOGGING
; p1 	= 	Instrument
; p2 	= 	Start
; p3 	= 	Length
; p4 	= 	Octave
; p5 	= 	Decibels
; p6 	= 	Pan
	print p2, p3, p4, p5, p6
; KONTROL
kenvelope 	expseg 	.00001, iattack, iamplitude, isustain, iamplitude, irelease, .00001
; AUDIO
asignal1 	pluck 	1, ifrequency, ifrequency * 1.002, 0, 1
asignal2 	pluck 	1, ifrequency * 1.003, ifrequency, 0, 1
apluckout 	= 	(asignal1 + asignal2) * kenvelope
	outs 	ileftpan * apluckout, irightpan * apluckout



endin
instr 2
; INITIALIZATION
imodulator 	= 	6.166667
ifmamplitude 	= 	3
index 	= 	.05
iattack 	= 	.015
irelease 	= 	.125
isustain 	= 	p3  - (iattack + irelease)
if isustain > 0 goto longenvelope
isustain 	= 	0.03
p3 	= 	iattack + isustain + irelease
	longenvelope:
ifrequency = 	cpsoct(p4)
icarrier 	=  	.998
icarrierb 	=  	1.002
; Normalize to 80 dB = ampdb(80).
iamplitude = 	ampdb(p5) * 15848.926 / 12729.0
ileftpan 	= 	(0.5 - p6) / 2.0
irightpan 	= 	(0.5 + p6) / 2.0
; LOGGING
; p1 	= 	Instrument
; p2 	= 	Start
; p3 	= 	Length
; p4 	= 	Octave
; p5 	= 	Decibels
; p6 	= 	Pan
	print p2, p3, p4, p5, p6
; KONTROL
kindenv 	expseg 	.00001, iattack, 1, isustain, .1, irelease, .00001
kindex 	= 	kindenv * index * ifmamplitude
; AUDIO
aouta 	foscili 	iamplitude, ifrequency, icarrier, imodulator, kindex, 1
aoutb 	foscili 	iamplitude, ifrequency, icarrierb, imodulator, kindex, 1
afmout 	= 	(aouta + aoutb) * kindenv * 2.556
	outs 	ileftpan * afmout, irightpan * afmout



endin
instr 3
; INITIALIZATION
iattack 	= 	.015
irelease 	= 	.065
isustain 	= 	p3 - (iattack + irelease)
if isustain > 0 goto longenvelope
isustain 	= 	0
p3 	= 	iattack + isustain + irelease
	longenvelope:
ifrequency = 	cpsoct(p4)
; Normalize to 80 dB = ampdb(80).
iamplitude = 	ampdb(p5) * 15848.926 / 1848
ileftpan 	= 	(0.5 - p6) / 2.0
irightpan 	= 	(0.5 + p6) / 2.0
; LOGGING
; p1 	= 	Instrument
; p2 	= 	Start
; p3 	= 	Length
; p4 	= 	Octave
; p5 	= 	Decibels
; p6 	= 	Pan
	print p2, p3, p4, p5, p6
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
instr 4
; INITIALIZATION
iattack 	= 	.015
irelease 	= 	.065
isustain 	= 	p3 - (iattack + irelease)
if isustain > 0 goto longenvelope
isustain 	= 	0
p3 	= 	iattack + isustain + irelease
	longenvelope:
ifrequency = 	cpsoct(p4)
; Normalize to 80 dB = ampdb(80).
iamplitude = 	ampdb(p5) * 15848.926 / 1848
ileftpan 	= 	(0.5 - p6) / 2.0
irightpan 	= 	(0.5 + p6) / 2.0
; LOGGING
; p1 	= 	Instrument
; p2 	= 	Start
; p3 	= 	Length
; p4 	= 	Octave
; p5 	= 	Decibels
; p6 	= 	Pan
	print p2, p3, p4, p5, p6
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
