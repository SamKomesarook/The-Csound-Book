sr =    44100
kr =    44100
ksmps =     1
nchnls =    2

; Frequency modulation instrument.
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
iwavetable = 1
imodulator = .5
ifmamplitude = 1
index = 1.375
iattack = .025
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
aouta foscili iamplitude, ifrequency, icarrier, imodulator, kindex, iwavetable
aoutb foscili iamplitude, ifrequency, icarrierb, imodulator, kindex, iwavetable
afmout = (aouta + aoutb) * kindenv * 2.556
outs ileftpan * afmout, irightpan * afmout
endin

