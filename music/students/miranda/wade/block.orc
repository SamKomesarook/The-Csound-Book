
;------------------------------------------------
;CENTRE FOR MUSIC TECHNOLOGY - GLASGOW UNIVERSITY
;SOFTWARE SYNTHESIS AND COMPOSITION SYSTEMS
;TUTOR: DR MIRANDA
;STUDENT NAME: NEAL WADE
;INSTRUMENT: BLOCK.ORC
;-------------------------------------------------
sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         1
          
garev     init      0
                                                  
          instr     1
kenv      linseg    0,0.01,1,p3-0.02,1,0.01,0
krat1     oscili    300,50,1
krat2     oscili    5,2,1
krat3     oscili    1,15+krat2,1
k1        oscili    300,krat1*krat3,1
a1        oscili    p4,p5+k1,1
          out       a1*kenv
          endin

;==============

          instr     2
kenv      linseg    0,0.01,1,p3-0.02,1,0.01,0
krat1     oscili    300,50,1
krat2     oscili    5,2,1
krat3     oscili    1,15+krat2,1
k1        oscili    300,krat1*krat3,1
a1        oscili    p4,p5+k1,1
a2        =         a1*kenv
          out       a2
garev     =         a2
          endin
;===============

          instr     3 ; REVERB
a1        comb      garev,p4,p5
          out       a1/2
garev     =         0
          endin
