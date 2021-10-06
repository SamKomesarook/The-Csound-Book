;-----------------------------------------------------
; Panorama examples
; Coded by Hans Mikelson
; October 9, 1999
;-----------------------------------------------------
sr=44100                         ; Sample rate
kr=4410                          ; Control rate
ksmps=10                         ; Samples per control period
nchnls=2                         ; Stereo sound output

;-----------------------------------------------------
;     Simple Pan
;-----------------------------------------------------
      instr   1

idur  =       p3                  ; Duration
iamp  =       p4                  ; Amplitude
ifqc  =       cpspch(p5)          ; Convert pitch to frequency
ipani =       p6                  ; Initial pan position
ipanf =       p7                  ; Final pan position
iq    =       .9                  ; Resonance

kfco  expseg  500, .1, 10000, .4, 2000, idur-.5, 1000 ; Frequency cut-off
kamp  linseg  0, .002, iamp, idur-.004, iamp, .002, 0 ; Amplitude envelope

kpan  linseg  ipani, idur, ipanf  ; Pan from left to right over note duration
kpanl =       kpan                ; Left pan value
kpanr =       1-kpan              ; Right pan value

asig  vco     1, ifqc, 1, 1, 1, 1 ; Use vco to generate an analog style signal
aout  moogvcf asig, kfco, iq      ; Use moogvcf as an analog style filter

      outs    aout*kamp*kpanl, aout*kamp*kpanr ; Scale, pan and output

      endin

;-----------------------------------------------------
;     Square Root Pan
;-----------------------------------------------------
      instr   2

idur  =       p3                  ; Duration
iamp  =       p4                  ; Amplitude
ifqc  =       cpspch(p5)          ; Convert pitch to frequency
ipani =       p6                  ; Initial pan position
ipanf =       p7                  ; Final pan position
iq    =       .9                  ; Resonance

kfco  expseg  500, .1, 10000, .4, 2000, idur-.5, 1000 ; Frequency cut-off
kamp  linseg  0, .002, iamp, idur-.004, iamp, .002, 0 ; Amplitude envelope

kpan  linseg  ipani, idur, ipanf  ; Pan from left to right over note duration
kpanl =       sqrt(kpan)          ; Left pan value
kpanr =       sqrt(1-kpan)        ; Right pan value

asig  vco     1, ifqc, 1, 1, 1, 1 ; Use vco to generate an analog style signal
aout  moogvcf asig, kfco, iq      ; Use moogvcf as an analog style filter

      outs    aout*kamp*kpanl, aout*kamp*kpanr ; Scale, pan and output

      endin

;-----------------------------------------------------
; Sine pan
;-----------------------------------------------------
       instr   3

idur   =       p3                  ; Duration
iamp   =       p4                  ; Amplitude
ifqc   =       cpspch(p5)          ; Convert pitch to frequency
ipani  =       p6                  ; Initial pan position
ipanf  =       p7                  ; Final pan position
iq     =       .9                  ; Resonance

kfco   expseg  500, .1, 10000, .4, 2000, idur-.5, 1000 ; Frequency cut-off
kamp   linseg  0, .002, iamp, idur-.004, iamp, .002, 0 ; Amplitude envelope

kpan   linseg ipani, idur, ipanf   ; Pan from left to right over note duration
kangle =      kpan * 3.14159265359 * .5 ; Compute pan*pi/2
kpanl  =      sin(kangle)          ; Left pan value
kpanr  =      cos(kangle)          ; Right pan value

asig   vco     1, ifqc, 1, 1, 1, 1 ; Use vco to generate an analog style signal
aout   moogvcf asig, kfco, iq      ; Use moogvcf as an analog style filter

       outs    aout*kamp*kpanl, aout*kamp*kpanr ; Scale, pan and output

       endin

;-----------------------------------------------------
;      Equal power pan by Michael Gogins
;-----------------------------------------------------
       instr   4

idur   =       p3                  ; Duration
iamp   =       p4                  ; Amplitude
ifqc   =       cpspch(p5)          ; Convert pitch to frequency
ipani  =       p6                  ; Initial pan position
ipanf  =       p7                  ; Final pan position
iq     =       .9                  ; Resonance

kfco   expseg  500, .1, 10000, .4, 2000, idur-.5, 1000 ; Frequency cut-off
kamp   linseg  0, .002, iamp, idur-.004, iamp, .002, 0 ; Amplitude envelope

kpan   linseg ipani, idur, ipanf   ; Pan from left to right over note duration
kangle =      (kpan-.5) * 3.14159265359                     ; Compute (pan-1/2)*pi
kpanl  =      sqrt(2.0) / 2.0 * (cos(kangle) + sin(kangle)) ; Left complicated equation
kpanr  =      sqrt(2.0) / 2.0 * (cos(kangle) - sin(kangle)) ; Right complicated equation

asig  vco     1, ifqc, 1, 1, 1, 1 ; Use vco to generate an analog style signal
aout  moogvcf asig, kfco, iq      ; Use moogvcf as an analog style filter

      outs    aout*kamp*kpanl, aout*kamp*kpanr ; Scale, pan and output

      endin

;-----------------------------------------------------
;      Delay and filtered panning
;-----------------------------------------------------
       instr   5

idur   =       p3                  ; Duration
iamp   =       p4                  ; Amplitude
ifqc   =       cpspch(p5)          ; Convert pitch to frequency
ipani  =       p6                  ; Initial pan position
ipanf  =       p7                  ; Final pan position
iq     =       .9                  ; Resonance

kfco   expseg  500, .1, 10000, .4, 2000, idur-.5, 1000 ; Frequency cut-off

kdclki linseg  0, .002, 1, idur-.002, 1                ; Fade in  envelope
kdclko linseg  1, idur-.002, 1, .002, 0                ; Fade out envelope

asig  vco     1, ifqc, 1, 1, 1, 1  ; Use vco to generate an analog style signal
aflt  moogvcf asig, kfco, iq       ; Use moogvcf as an analog style filter

kpan   linseg ipani, idur, ipanf   ; Pan from left to right over note duration
kangle =      kpan * 3.14159265359 * .5 ; Compute pan*pi/2
kpanl  =      sin(kangle)          ; Left pan value
kpanr  =      cos(kangle)          ; Right pan value

kpl    =      kpanl*.5+.5                   ; Generate a value between .5 and 1
kpr    =      kpanr*.5+.5                   ; Generate a value between .5 and 1

adell  vdelay3 aflt*kdclki, kpanr*.7+.05, 2 ; Delay left  side .05 to .7 msec
adelr  vdelay3 aflt*kdclki, kpanl*.7+.05, 2 ; Delay right side .05 to .7 msec

afltl  butterlp adell, 4000+kpanl*10000     ; Generate a low pass filtered signal
afltr  butterlp adelr, 4000+kpanr*10000     ; Same for the right side

aoutl  =      adell*kpan+afltl*(1-kpan)     ; Crossfade between delayed and filtered signal
aoutr  =      adelr*(1-kpan)+afltr*kpan     ; Same for the right side

      outs    aoutl*iamp*kpl*kdclko, aoutr*iamp*kpr*kdclko ; Declick and output

      endin


