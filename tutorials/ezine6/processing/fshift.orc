sr         =          44100
kr         =          700
ksmps      =          63
nchnls     =          2

;--------- global ------------------------------------------------------------------;

; useful constant:
gisr4      =          sr * 0.25

; sinewave table:
gisin      ftgen      0,0,65536,10,1.0

; filter coefficients for frequency shifter instrument:
; (6th order elliptical filter, fc=0.25sr)
gifc0      =          0.051532459925
gifb01     =          1.0
gifb11     =          1.6375276435
gifb21     =          1.0
gifa01     =          1.0
gifa11     =          -0.93027644018
gifa21     =          0.37171017225
gifb02     =          1.0
gifb12     =          0.56037176307
gifb22     =          1.0
gifa02     =          1.0
gifa12     =          -0.40320752514
gifa22     =          0.73736786626
gifb03     =          1.0
gifb13     =          0.19165327787
gifb23     =          1.0
gifa03     =          1.0
gifa13     =          -0.15398586410
gifa23     =          0.94001488557

instr 1 ;-------- instrument -------------------------------------------------------;

ifreq      =          cpspch(p4)
ibandw     =          ifreq / p5
iampl      =          p6

; signal source:
aenv       expon      1.0, p7, 0.01
anois      trirand    iampl
afilt      reson      anois, ifreq, ibandw, 2
awsrc      =          aenv * afilt, 

; delay line:
awdel      delayr     p8

; mixer:
kfdbk      init       p9
awin       =          awdel * kfdbk + awsrc

; frequency shift (+/-) in Hertz:
kfrqshf    init       p10

; shift mode: 0.0 ... 1.0 
; 1.0 -> "normal" SSB, spectral components shifted off [0,sr/2] are mirrored and overlap.
; 0.0 -> components shifted off [0,sr/2] are cut, the other end is augmented by mirror image, no overlap.
kshfmod    init       p11

; first quadrature oscillator:
ko1frq     =          gisr4 - (1 - kshfmod) * kfrqshf
aqo1r      oscil      1.0, ko1frq, gisin, 0.25  ; cosine
aqo1i      oscil      1.0, ko1frq, gisin, 0.0   ; sine

; second quadrature oscillator:
ko2frq     =          gisr4 + kshfmod * kfrqshf
aqo2r      oscil      1.0, ko2frq, gisin, 0.25  ; cosine
aqo2i      oscil      1.0, ko2frq, gisin, 0.0   ; sine

; upper branch:
; first multiplier:
awq1r      =          awin * aqo1r
; lowpass filter:
awf1r      biquad     awq1r, gifb01, gifb11, gifb21, gifa01, gifa11, gifa21
awf2r      biquad     awf1r, gifb02, gifb12, gifb22, gifa02, gifa12, gifa22
awf3r      biquad     awf2r, gifb03, gifb13, gifb23, gifa03, gifa13, gifa23
aw1fr      =          awf3r * gifc0
; second multiplier:
awq2r      =          aw1fr * aqo2r

; lower branch:
; first multiplier:
awq1i      =          awin * aqo1i
; lowpass filter:
awf1i      biquad     awq1i, gifb01, gifb11, gifb21, gifa01, gifa11, gifa21
awf2i      biquad     awf1i, gifb02, gifb12, gifb22, gifa02, gifa12, gifa22
awf3i      biquad     awf2i, gifb03, gifb13, gifb23, gifa03, gifa13, gifa23
aw1fi      =          awf3i * gifc0
; second multiplier:
awq2i      =          aw1fi * aqo2i

; summing up:
awfs       =          awq2r + awq2i

; feedback to delay line:
           delayw     awfs

; output sound:
           outs       awfs, awdel

endin
