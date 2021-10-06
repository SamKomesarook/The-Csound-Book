;BETH LEIBOWITZ MID-TERM PROJECT
; AN FM INSTRUMENT WITH TIME DEPENDENT INDEX OF MODULATION
; AND SCORE CONTROLLED FC/FM RATIO

sr             =         44100
kr             =         4410
ksmps          =         10
nchnls         =         1

instr          1

ifc            =         p6*cpspch(p5)                           ; CARRIER FREQUENCY
ifm            =         p7*cpspch(p5)                           ; MODULATION FREQUENCY
kndx           envlpx    11, p3/2, p3, p3/2, 2, 1, .01           ; F2 IS STRAIGHT LINE
kamp           envlpx    6000, .1*p3, p3, .2*p3, 2, .8, .01
amod           oscil     kndx*ifm, ifm, 1                        ; F1 IS SIMPLE SINE WAVE
asig           oscil     kamp, ifc+amod, 1
asigo          tone      asig, 9000                              ; I DON'T WANT FOLDOVER AS AN ADDED FACTOR.
out            asigo
endin
