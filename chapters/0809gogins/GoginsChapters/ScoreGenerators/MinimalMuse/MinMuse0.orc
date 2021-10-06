sr = 44100
kr = 4410
ksmps = 10
nchnls = 2

instr 1
; INITIALIZATION
iamplitude = ampdb(p5) * 15848.926 / 3978
ileftpan = (0.5 - p6) / 2.0
irightpan = (0.5 + p6) / 2.0
ifrequency = cpsoct(p4)
ioctave = int(p4 * 100)
itablenumber table ioctave, 100
itableoctave table ioctave, 101
itablefrequency = cpsoct (itableoctave)
if p3 > .20  then goto longenvelope
p3 = .20
longenvelope:
; LOGGING
; p1 = Instrument
; p2 = Start
; p3 = Length
; p4 = Octave
; p5 = Decibels
; p6 = Pan
print p2, p3, p4, p5, p6
print itablenumber, itableoctave, itablefrequency
; KONTROL
kamplitude linen iamplitude, -1, p3, .012
; AUDIO
asignal loscil kamplitude, ifrequency, int(itablenumber), itablefrequency
outs ileftpan * asignal, irightpan * asignal

endin
instr 2
; INITIALIZATION
iamplitude = ampdb(p5) * 15848.926 / 3978
ileftpan = (0.5 - p6) / 2.0
irightpan = (0.5 + p6) / 2.0
ifrequency = cpsoct(p4)
ioctave = int(p4 * 100)
itablenumber table ioctave, 100
itableoctave table ioctave, 101
itablefrequency = cpsoct (itableoctave)
if p3 > .20  then goto longenvelope
p3 = .20
longenvelope:
; LOGGING
; p1 = Instrument
; p2 = Start
; p3 = Length
; p4 = Octave
; p5 = Decibels
; p6 = Pan
print p2, p3, p4, p5, p6
print itablenumber, itableoctave, itablefrequency
; KONTROL
kamplitude linen iamplitude, -1, p3, .012
; AUDIO
asignal loscil kamplitude, ifrequency, int(itablenumber), itablefrequency
outs ileftpan * asignal, irightpan * asignal

endin
