sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         1

          instr     2704
iamod     =         p4
ifmodst   =         p5
ifmodnd   =         p6
ismod     =         p7
kfmod     line      ifmodst, p3, ifmodnd
asig      adsyn     iamod, kfmod, ismod, 2
          out       asig
          endin

