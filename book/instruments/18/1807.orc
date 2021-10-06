sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         1


          instr     1816
imean     =         250                 ; THE MEAN FREQUENCY
idev      =         50                  ; THE STANDARD DEVIATION
itwopi    =         6.283185
krnd1     rand      0.5,.05463
krnd2     rand      0.5,.34567
kgs1      =         sqrt(-2.0*log(0.501+krnd1))
kgs2      =         kgs1*cos(itwopi*(0.5+krnd2))
kgauss    =         kgs2*idev+imean
gkgauss   =         kgauss
          endin

          instr     1817
kgt       oscil     1,p5,2
kfr       samphold  gkgauss,kgt 
aosc      oscil     1,kfr,1
asig      =         aosc*p4
          out       asig
          endin
