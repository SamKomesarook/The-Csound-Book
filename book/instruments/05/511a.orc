sr      =       44100
kr      =       4410
ksmps   =       10
nchnls  =       1

        instr   511
k1      linen   p4, p3*.01, p3, p3*.1
a1      oscil   k1,cpspch(p5),2
        out     a1
        endin
        
        instr   512
k1      linen   p4, p3*.01, p3, p3*.1
k2      expon   13, p3, 1
a1      foscil  k1,cpspch(p5),1,1,k2,1
        out     a1
        endin

