; Sine Wave
f1 0 16384 10 1

; Saw Wave 1/n series
f2 0 16384 10 1 .5 .33 .25 .2  .167

; Square Wave 1/n odd series
f3 0 16384 10 1 0  .5  0   .333 0  .25 0 .2 0 .167

; Irregular Wave
f4 0 1024 10 1 .3 .1 0 .2 .02 0 .1 .04

; Wave 1/n series 1 point missing
f5 0 16384 10 1 .5 .33 .25 .2  0  .142  .125  .111

; Series with higher harmonics
f6 0 16384 10 1 .5 .33 .25 .2  0  .142  .125  .111 0 .100 0 .09 0 .08 .01 .06 .015

; Pitch Bend Table
f10 0 1024 -7 1 250 1 12 2 240 2 12 1.5 120 1.5 10 .5 55 .5 10 2 55 2 20 .5 240 .5
f11 0 1024 -7 1 256 .5 10 1 118 .5 10 1 246 .5 10 1 118 .5 10 1 246 .5

; Sonatina in G major, Hob. XVI:8 Haydn
; Treble
;  Sta  Dur   Amp   Freq   Table  PBend
i4 0.0  5     20000  7.02  6      10
i4 +    5     20000  6.07  6      10
i4 .    5     20000  6.04  6      11

