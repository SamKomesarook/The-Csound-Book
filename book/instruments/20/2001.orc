sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         1

        instr   2001
itwopi  =       2*3.141592653589793238
a1      phasor  440
a2      =       32767*sin(itwopi*a1)
        out     a2
        endin
