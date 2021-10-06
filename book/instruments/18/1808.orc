sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         1


gkgauss   init  0

          instr     1818
imean     =         250
idev      =         50
krand     rand      0.5, 0.213
ksig      table     0.5+krand, 3, 1, 0, 0
gkgauss   =         ksig*idev+imean
          endin      

          instr     1819
kgt       oscil     1, p5, 2
kfr       samphold  gkgauss, kgt 
aosc      oscil     1, kfr, 1
          out       aosc*p4
          endin
