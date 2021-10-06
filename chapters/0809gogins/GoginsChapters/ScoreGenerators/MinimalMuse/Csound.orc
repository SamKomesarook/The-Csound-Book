sr = 44100
kr = 44100
ksmps = 1
nchnls = 2

instr 1
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
; Pitch.
i1 = cpsoct(p4)
; Amplitude.
; Normalize to 80 dB = ampdb(80).
iamplitude = ampdb(p5) * 15848.926 /  15848.926 
; Pan.
ileftpan = (0.5 - p6) / 2.0
irightpan = (0.5 + p6) / 2.0
;ip6=cheby# 
ip6 = 32
;ip7=choice 
ip7 =1
iattack = .05
irelease = .1
isustain = p3 - (iattack + irelease)
if isustain > 0 goto longenvelope
isustain = 0
p3 = iattack + isustain + irelease
longenvelope:

; KONTROL                                          
k100 randi   1,10
k101 oscili  i1 / 65, 5 + k100, 1
k102 linseg  0, .5, 1, p3 - .5, 1
k100 =  i1 + (k101 * k102)
; Envelope for driving oscillator.
k1 linen .5, p3 * .4, p3 , p3 * .2
k2 line 1, p3, .5
k1 =  k2 * k1
if ip7=2 goto cresc
if ip7=3 goto dim
if ip7=4 goto sfz
if ip7=5 goto slow
; Amplitude envelope.
k10 expseg  .0001, iattack, iamplitude , isustain, iamplitude * .8, irelease, .0001
; Power to partials.
k20 linseg 1.485, iattack, 1.5, isustain + irelease, 1.485              
goto next
cresc:
; Amplitude envelope.
k8 expseg  .0001, iattack, p5 * .25, isustain, p5, irelease, .0001
k9 linseg 1, p3 - .15, 1.5, .1, 0
k10  = (k8 * k9) / 2
; Power to partials.
k20 line 1.475, p3, 1.5
goto next
dim:
; Amplitude envelope.
k10 linseg  0, .05, iamplitude, .05, iamplitude * .8, p3 * .33, p5 *.7, (p3 * .66) - .1, 0
; Power to partials.
k20 line 1.5, p3, 1.475
goto next
sfz:
; Amplitude envelope.
k10 linseg  0, .03, p5, .04, p5, .03, p5 * .3, p3 - .15, p5 * .3, .05, 0
; Power to partials.
k20 linseg  1.4, .03, 1.7, .04, 1.7, .03, 1.4, p3 - .1, 1.385
goto next
slow:
; Amplitude envelope.
k10 linseg  0,.06, p5 * .45, .04, p5 * .2, (p3 / 3) - .1, p5, p3 / 3, p5 * .9, p3 / 3, 0 
; Power to partials.
k20 linseg 1.475, p3 / 3, 1.5, p3 / 3, 1.4999, p3 / 3, 1.475
next:      
;a1-3 are for cheby with p6=1-4
a1 oscili  k1, k100 - .025, 3
; Tables a1 to fn13, others normalize,
a2 tablei  a1, ip6, 1, .5
a3 balance a2,a1
; Try other waveforms as well.
a4 foscil  1, k100 + .04, 1, 2.005, k20, 1
a5 oscili  1, k100, 1
a6  =  ((a3 * .1) + (a4 * .1) + (a5 * .8)) * k10
a7 comb a6, .5, 1 / i1
a6  = (a6 * .9) + (a7 * .1)
outs a6 * ileftpan, a6 * irightpan




























endin
instr 3
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
iamplitude = ampdb(p5) * 15848.926 / 330
ileftpan = (0.5 - p6) / 2.0
irightpan = (0.5 + p6) / 2.0
i1 = cpsoct(p4)
ip6 = .15
i2 = log(i1)/10.0 - ip6
icosinetable = 34
iattack = .03
irelease = .03
isustain = p3
p3 = iattack + isustain
if p3 > .06 then goto longenvelope
p3 = .06
longenvelope:

; KONTROL
; Envelope.
k1 expseg  1.0 / 100000.0, iattack, iamplitude, isustain, 1.0 / 100000.0
k25 linseg  1, iattack, 1, isustain, 3
k1= k25 * k1
; Power to partials.
k10 linseg 2.25, .03, 3, p3 - .03, 2

; AUDIO
a1 gbuzz k1, i1, k10, 0, 35, icosinetable 
a2 reson a1, 500, 50, 1
a3 reson a2, 1500, 100, 1
a4 reson a3, 2500, 150, 1
a5 reson a4, 3500, 150, 1
a6 balance a5, a1
i6 = ip6
a7 = a6 * ileftpan
a8 = a6 * irightpan
outs a7, a8





endin
