sr = 44100
kr = 882
ksmps = 50
nchnls = 2
instr 1 ; Plucked String
; LOGGING
; p1 = Instrument
; p2 = Start
; p3 = Length
; p4 = Octave
; p5 = Decibels
; p6 = Pan
print p2, p3, p4, p5, p6

; INITIALIZATION
iattack = .012
irelease = .075
isustain = p3 - (iattack + irelease)
if isustain > 0 goto longenvelope
isustain = 0
p3 = iattack + isustain + irelease
longenvelope:
ifrequency = cpsoct(p4)
; Normalize to 80 dB = ampdb(80).
iamplitude = ampdb(p5) * 15848.926 / 5398.0
ileftpan = 0.5 - p6 / 2
irightpan = 0.5 + p6 / 2

; KONTROL
kenvelope expseg .00001, iattack, iamplitude, isustain, iamplitude, irelease, .00001

; AUDIO
asignal1 pluck 1, ifrequency, ifrequency * 1.002, 0, 1
asignal2 pluck 1, ifrequency * 1.003, ifrequency, 0, 1
apluckout = (asignal1 + asignal2) * kenvelope
outs ileftpan * apluckout, irightpan * apluckout
endin
instr 2 ; Plucked String
; LOGGING
; p1 = Instrument
; p2 = Start
; p3 = Length
; p4 = Octave
; p5 = Decibels
; p6 = Pan
print p2, p3, p4, p5, p6

; INITIALIZATION
iattack = .012
irelease = .075
isustain = p3 - (iattack + irelease)
if isustain > 0 goto longenvelope
isustain = 0
p3 = iattack + isustain + irelease
longenvelope:
ifrequency = cpsoct(p4)
; Normalize to 80 dB = ampdb(80).
iamplitude = ampdb(p5) * 15848.926 / 5398.0
ileftpan = 0.5 - p6 / 2
irightpan = 0.5 + p6 / 2

; KONTROL
kenvelope expseg .00001, iattack, iamplitude, isustain, iamplitude, irelease, .00001

; AUDIO
asignal1 pluck 1, ifrequency, ifrequency * 1.002, 0, 1
asignal2 pluck 1, ifrequency * 1.003, ifrequency, 0, 1
apluckout = (asignal1 + asignal2) * kenvelope
outs ileftpan * apluckout, irightpan * apluckout
endin
instr 3 ; Kelley Harpsichord
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
instr 4 ; Plucked String
; LOGGING
; p1 = Instrument
; p2 = Start
; p3 = Length
; p4 = Octave
; p5 = Decibels
; p6 = Pan
print p2, p3, p4, p5, p6

; INITIALIZATION
iattack = .012
irelease = .075
isustain = p3 - (iattack + irelease)
if isustain > 0 goto longenvelope
isustain = 0
p3 = iattack + isustain + irelease
longenvelope:
ifrequency = cpsoct(p4)
; Normalize to 80 dB = ampdb(80).
iamplitude = ampdb(p5) * 15848.926 / 5398.0
ileftpan = 0.5 - p6 / 2
irightpan = 0.5 + p6 / 2

; KONTROL
kenvelope expseg .00001, iattack, iamplitude, isustain, iamplitude, irelease, .00001

; AUDIO
asignal1 pluck 1, ifrequency, ifrequency * 1.002, 0, 1
asignal2 pluck 1, ifrequency * 1.003, ifrequency, 0, 1
apluckout = (asignal1 + asignal2) * kenvelope
outs ileftpan * apluckout, irightpan * apluckout
endin
instr 5 ; FM Low Index
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
