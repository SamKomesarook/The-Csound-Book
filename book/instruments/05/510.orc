sr      =       44100
kr      =       4410
ksmps   =       10
nchnls  =       1

        instr   510
kenv    linseg  0,p3*.01, p4, p3*.3, p4*.7, p3*.69, 0
asig1   oscil   kenv, cpspch(p5), 1
asig2   oscil   kenv, cpspch(p5)*p6, 2
asig3   oscil   kenv, cpspch(p5)*p7, 3
amix    =       asig1 + asig2 + asig3
aflt    butterbp amix, p8*10, p8
aflt    balance aflt, amix
        out     aflt
        endin
