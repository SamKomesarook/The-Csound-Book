;---------------------------------------------------------------
; Machine Language
; by Hans Mikelson March 2000
;---------------------------------------------------------------
sr     =        44100
kr     =        4410
ksmps  =        10
nchnls =        2

;---------------------------------------------------------------
; Machine language
;---------------------------------------------------------------
       instr    12

idur   =        p3
iamp   =        p4
ifqc   =        p5
iaph   =        p6*sr    ; Amplitude of the phasor in seconds converted to samples
itab   =        p7
iftab  =        p8
iofst  =        p9*sr
ipanl  =        sqrt(p10)
ipanr  =        sqrt(1-p10)
irez   =        p11
ismth  =        2

ifph   =        sr/iaph

kdclk  linseg   0, .002, 1, idur-.004, 1, .002, 0
kfco   oscil    1, 1/idur, iftab

aphas1 phasor   ifph
aphas2 phasor   ifph, .5

ashft1 table3   ifqc*iaph*aphas1+iofst, itab
ashft2 table3   ifqc*iaph*aphas2+iofst, itab

kdclk1 oscil    1, ifph, 1
kdclk2 oscil    1, ifph, 1, .5

kdclk1 =        (tanh(kdclk1*ismth)+1)*.5
kdclk2 =        (tanh(kdclk2*ismth)+1)*.5

aout   rezzy    ashft1*kdclk1+ashft2*kdclk2, kfco, irez
aout2  butterbp ashft1*kdclk1+ashft2*kdclk2, kfco*1.333, kfco/irez*5

       outs     (aout+aout2)*iamp*kdclk*ipanl, (aout+aout2)*iamp*kdclk*ipanr

       endin
