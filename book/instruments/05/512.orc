sr      =       44100
kr      =       4410
ksmps   =       10
nchnls  =       1

garvb   init    0

        turnon  599

gi1 ftgen 1, 0, 4096, 10, 1
gi2 ftgen 2, 0, 4096, 10, 10, 0, 5, 0, 2, 0, 1
gi3 ftgen 3, 0, 4096, 10, 16, 15, 14, 13, 12, 11, 10, 9, 8, 7, 6, 5, 4, 3, 2, 1
gi4 ftgen 4, 0, 4096, 10, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1


        instr 513   
a1      oscil   p4, p5, p6
garvb   =       garvb+a1
        out     a1
        endin   
        
        instr 514
; ar    wgpluck2    iplk, xam, icps, kpick, krefl
a1      wgpluck2    p8, p4, p5, p6, p7
garvb   =       garvb+a1
        out     a1
        endin
    
        instr   599
a1      nreverb garvb*.1, 12.6, .1
        out     a1
garvb   =       0
        endin
