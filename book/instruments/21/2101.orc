sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         1


          instr     2101
          asig      in                       ; GET MICROPHONE INPUT
                                             ; FORM A SPECTRAL DATA TYPE
wsig1     spectrum  asig, .01, 8, 12, 8, 0, 1, 0
wsig2     specscal  wsig1, 3, 4              ; FLETCHER-MUNSON SCALING
wsig3     specdiff  wsig2                    ; POSITIVE DIFFERENCE SPECTRUM
wsig4     specfilt  wsig3, 5                 ; INJECT INTO INTEGRATING FILTERS
ksum4     specsum   wsig4, 1
                                             ; GET TEMPO...
ktempo    tempest   ksum4, .01, .1, 3, 1, 30, .005, 90, 2, .04, 1
          tempo     ktempo, 60               ; ... AND CONTROL THE PERFORMANCE
          endin

          instr     2102, 2103, 2104
icps      =         cpsoct(p4)
kenv      envlpx    p5, .02, p3, .1, 2, .3, .01
a1        oscil     kenv, icps, 3
          out       a1
          endin

          instr     2105, 2106, 2107, 2108
icps      =         cpspch(p4)
kenv      envlpx    p5, .02, p3, .1, 2, .3, .01
a1        oscil     kenv, icps, 3
          out       a1
          endin
