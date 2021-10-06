;--------------------------------------
; Noise Instruments
; Coded by Hans Mikelson August 2000
;--------------------------------------
sr      =     44100      ; Sample rate
kr      =     4410       ; Control rate
ksmps   =     10         ; Samples per control rate
nchnls  =     2          ; Number of channels

;--------------------------------------
; Simple white noise generator
;--------------------------------------
       instr 1

idur   =     p3               ; Duration
iamp   =     p4               ; Amplitude

asig   rand  iamp             ; Random number generator -iamp to iamp

       outs  asig, asig       ; Output the sound

       endin

;--------------------------------------
; Simple pink noise generator
;--------------------------------------
       instr 2

idur   =     p3                  ; Duration
iamp   =     p4                  ; Amplitude

asig1  rand  iamp,         .5, 1 ; High quality random number
asig2  randh iamp, sr/2,   .5, 1 ; Hold random number for 2 samples
asig3  randh iamp, sr/4,   .5, 1 ; Hold for 4   samples
asig4  randh iamp, sr/8,   .5, 1 ; Hold for 8   samples
asig5  randh iamp, sr/16,  .5, 1 ; Hold for 16  samples
asig6  randh iamp, sr/32,  .5, 1 ; Hold for 32  samples
asig7  randh iamp, sr/64,  .5, 1 ; Hold for 64  samples
asig8  randh iamp, sr/128, .5, 1 ; Hold for 128 samples

asig   =     (asig1+asig2+asig3+asig4+asig5+asig6+asig7+asig8-4*iamp)/3

       outs  asig, asig

       endin

;--------------------------------------
; White noise with filter sweep
;--------------------------------------
       instr 3

idur   =     p3
iamp   =     p4
aadd   init  0

kfqc   expseg 40, idur, 10000

asig   rand  iamp, .5, 1
asig   =     (asig-.5*iamp)*2
aflt   butbp asig, kfqc, kfqc*.1

       outs  aflt*2, aflt*2

       endin

;--------------------------------------
; Pink noise with filter sweep
;--------------------------------------
       instr 4

idur   =     p3
iamp   =     p4

kfqc   expseg 40, idur, 10000

asig1  rand  iamp,         .5, 1 ; High quality random number
asig2  randh iamp, sr/2,   .5, 1 ; Hold random number for 2 samples
asig3  randh iamp, sr/4,   .5, 1 ; Hold for 4   samples
asig4  randh iamp, sr/8,   .5, 1 ; Hold for 8   samples
asig5  randh iamp, sr/16,  .5, 1 ; Hold for 16  samples
asig6  randh iamp, sr/32,  .5, 1 ; Hold for 32  samples
asig7  randh iamp, sr/64,  .5, 1 ; Hold for 64  samples
asig8  randh iamp, sr/128, .5, 1 ; Hold for 128 samples

asig   =     (asig1+asig2+asig3+asig4+asig5+asig6+asig7+asig8-4*iamp)*1.8
aflt   butbp asig, kfqc, kfqc*.1

       outs  aflt, aflt

       endin

;--------------------------------------
; Simple noise generator
;--------------------------------------
       instr 5

idur   =     p3               ; Duration
iamp   =     p4               ; Amplitude
ialpha =     p5

asig   cauchy  ialpha         ; Random number generator -iamp to iamp

       outs  asig*iamp, asig*iamp       ; Output the sound

       endin

;--------------------------------------
; Sample Hold Noise
;--------------------------------------
       instr 6

idur   =     p3                  ; Duration
iamp   =     p4                  ; Amplitude
ifqc   =     p5

asig1  randh iamp, ifqc          ; Generate a new random number at ifqc rate
asig2  randi iamp, ifqc          ; Generate a new random number at ifqc rate

       outs  asig1, asig2

       endin

