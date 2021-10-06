sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         1

          instr     2822    
ifreq     =         1                        ; READ THROUGH 7.5 sec.
iamp      =         1                        ; ...OF LPC ANALYSIS.
kpvtime   line      0, p3, 1                 ; pvinterp WILL PRODUCE
klpctime  line      0, p3, 7.6               ; ...THE MARIMBA-VIOLIN MORPH
kinterp   line      0, p3, 1
krmsr, krmso, kerr, kcps    lpread  klpctime, "speech1.lpc"
kfmod     =         kcps/cpspch(9.00)        ; ...WHICH WILL "SPEAK" WITH
          pvbufread kpvtime, "violin.pvc"
apv       pvinterp  kpvtime, kfmod, "marimba.pvc", ifreq, ifreq, iamp, 2, kinterp, kinterp
alpc      lpreson   apv                      ;...THE PITCHES FROM THE LPC
          out       alpc                     ; ...ANALYZED SPEECH!
          endin
