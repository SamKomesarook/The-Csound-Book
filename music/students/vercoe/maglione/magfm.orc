;FILENAME: FM.ORC
;PURPOSE: TO CREATE AN INSTRUMENT CAPABLE OF TESTING THE LATEST FM SYNTHESIS
;      TECHNIQUES.
;WRITTEN BY:
;    TOM V. J. MAGLIONE
;    29 RICE ROAD
;    WAYLAND, MASSACHUSETTS 01778
;    (508) 655-9120
;WRITTEN ON: WEDNESDAY 26-OCTOBER-1988, 16:59

sr             =         44100
kr             =         4410
ksmps          =         10
nchnls         =         2
;gipi          =         3.1415926
;
          instr          1
; NOTE THAT:
;    P6        =         I (Modulation index);
;    P7        =         r = control ratio;
;    P8        =         fc = carrier frequency;
;    P9        =         fm = modulating frequency;
;    table1    =         gen12 Bessel functions
;    table2    =         sine wave table
;    table3    =         cosine wave table
kenv           linseg    0,0.1,1,p3-0.3,1,0.2,0
k1             =         p6 * (p7 - 1/p7)/2
k2a            =         p6 * (p7 + 1/p7)/2
k2b            =         p9 * k2a
k3a            table     k1*2,1,0,0,0
k3b            =         k3a*(-1/2)
a1             oscil     k2b,p9,3
a2             oscil     k1,p9,3
a3             =         kenv*10000*exp(a2+k3b)
;asig          oscil     a3,p8,2,frac(a1/(2*gapi))
asig           oscil     a3,p8+a1,2
               outs1     asig
               endin
;
               instr     2
; THIS INSTRUMENT EXPLORES THE EFFECT OF RAMPING THE MODULATION INDEX FOR THREE
; DIFFERENT VALUES OF RATIO, R:
kenv           linseg    0,0.1,1,p3-0.3,1,0.2,0
kramp          linseg    0,p3/2,p6,p3/2,0
k1             =         kramp * (p7 - 1/p7)/2
k2a            =         kramp * (p7 + 1/p7)/2
k2b            =         p9 * k2a
k3a            table     k1*2,1,0,0,0
k3b            =         k3a * (-1/2)
a1             oscil     k2b,p9,3
a2             oscil     k1,p9,3
a3             =         kenv * 10000 * exp(a2+k3b)
asig           oscil     a3,p8+a1,2
               outs2     asig
               endin
;
               instr     3
; THIS INSTRUMENT EXPLORES THE RAMPING OF THE RATIO, R:
kenv           linseg    0,0.1,1,p3-0.3,1,0.2,0
kramp          linseg    0.8,p3/2,1.25,p3/2,0.8
k1             =         p6 * (kramp - 1/kramp)/2
k2a            =         p6 * (kramp + 1/kramp)/2
k2b            =         p9 * k2a
k3a            table     k1*2,1,0,0,0
k3b            =         k3a * (-1/2)
a1             oscil     k2b,p9,3
a2             oscil     k1,p9,3
a3             =         kenv * 10000 * exp(a2+k3b)
asig           oscil     a3,p8+a1,2
               outs1     asig
               endin
