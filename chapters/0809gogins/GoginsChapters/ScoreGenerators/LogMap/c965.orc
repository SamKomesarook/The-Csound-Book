sr = 44100
kr = 44100
ksmps = 1
nchnls = 2

instr 1
; INITIALIZATION
icarrier 	= 	1
iratio 	= 	1.25
ifmamplitude = 	8
index 	= 	5.4
iattack 	= 	.02
irelease 	= 	.05
isustain 	= 	p3  - (iattack + irelease)
if isustain > 0 goto longenvelope
isustain 	= 	0
p3 	= 	iattack + isustain + irelease
	longenvelope:
ifrequency = 	cpsoct(p4)
ifrequencyb = 	ifrequency * 1.003
icarrierb 	= 	icarrier * 1.004
; Normalize to 80 dB = ampdb(80).
iamplitude = 	ampdb(p5) * 15848.926 / 12748.1
ileftpan 	= 	(0.5 - p6) / 2.0
irightpan 	= 	(0.5 + p6) / 2.0
; LOGGING
; p1 	= 	Instrument
; p2 	= 	Start
; p3 	= 	Length
; p4 	= 	Octave
; p5 	= 	Decibels
; p6 	= 	Pan
	print 	p2, p3, p4, p5, p6
; KONTROL
kindenv 	expseg 	.000001, iattack, 1, isustain, .125, irelease, .000001
kindex 	= 	kindenv * index * ifmamplitude
; AUDIO
aouta 	foscili 	iamplitude, ifrequency, icarrier, iratio, index, 1
aoutb 	foscili 	iamplitude, ifrequencyb, icarrierb, iratio, index, 1
; Plus amplitude correction.
afmout 	= 	(aouta + aoutb) * kindenv * 2.565
	outs 	ileftpan * afmout, irightpan * afmout


endin
