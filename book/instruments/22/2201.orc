sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         2



          instr     2201                     ; PLUCK WITH ECHOES
kgate     linseg    p4, .1, 0, 1, 0
icps      =         cpspch(p5)               ; MAKE TWO SLAPBACK ECHOES,
asig      pluck     kgate, icps, icps, 0, 1, 0, 0   ; .. EACH ONE SOFTER
atap1     delay     asig*.7, p6              ; P6 DELAY IN SEC
atap2     delay     asig*.5, p7              ; P7 DELAY IN SEC
          outs      asig+atap1, asig+atap2   ; ADD STEREO ECHOES
          endin
