sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         2

          instr 4

a3        linseg    0, p3*.6, 5000, p3*.2, 4500,p3*.05,2000, p3*.05, 800,p3*.1, 0

acarr     linseg    280, p3, 230
index     =         1.5
imodfr    =         40
idev      =         index*imodfr
ifreq     =         p4
kenv      =         p5
amodsig   oscil     idev, imodfr, 1

a1        fof       .15, 2, acarr+amodsig*p4, 0, 1, .00003, .5, .1, 300, 2, 4, p3, 0, 1

          outs      a1*.9*a3, a1*5.5*a3
          endin
