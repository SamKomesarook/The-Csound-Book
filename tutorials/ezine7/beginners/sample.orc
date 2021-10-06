;--------------------------------------
; Simple Sampler Instruments
; Coded by Hans Mikelson February 2000
;--------------------------------------
sr      =     44100      ; Sample rate
kr      =     4410       ; Control rate
ksmps   =     10        ; Samples per control rate
nchnls  =     2          ; Number of channels


;------------------------------
; Simple Sample Input
;------------------------------
      instr     1

idur  =         p3         ; Duration
iamp  =         p4         ; Amplitude
ipanl =         sqrt(p5)   ; Pan left
ipanr =         sqrt(1-p5) ; Pan right
iskip =         p6         ; Skip time
isamp =         p7         ; Sample

; Declick envelope
kamp  linseg    0, .002, iamp, idur-.004, iamp, .002, 0

asig  soundin   isamp, iskip  ; Sound input

; Declick, amplify, pan and output
      outs      asig*kamp*ipanl, asig*kamp*ipanr

      endin

;------------------------------
; Simple Sample Input
;------------------------------
      instr     2

idur  =         p3         ; Duration
iamp  =         p4         ; Amplitude
ipanl =         sqrt(p5)   ; Pan left
ipanr =         sqrt(1-p5) ; Pan right
iskip =         p6         ; Skip time
isamp =         p7         ; Sample
irate =         p8         ; Rate
iratab =        p9         ; Rate table

; Declick envelope
kamp  linseg    0, .002, iamp, idur-.004, iamp, .002, 0
krate oscil     irate, 1/idur, iratab

asig  diskin    isamp, krate, iskip, 1  ; Sound input

; Declick, amplify, pan and output
      outs      asig*kamp*ipanl, asig*kamp*ipanr

      endin

;------------------------------
; Sample Input
;------------------------------
      instr     3

idur  =         p3         ; Duration
iamp  =         p4         ; Amplitude
ipanl =         sqrt(p5)   ; Pan left
ipanr =         sqrt(1-p5) ; Pan right
iskip =         p6         ; Skip time
isamp =         p7         ; Sample
irate =         p8         ; Rate
ifm   =         p9         ; FM amount
ifmrt =         p10        ; FM frequency

; Declick envelope
kamp  linseg    0, .002, iamp, idur-.004, iamp, .002, 0
kfm   oscil     ifm, ifmrt, 1
krate =         kfm +irate

asig  diskin    isamp, krate, iskip, 1  ; Sound input

; Declick, amplify, pan and output
      outs      asig*kamp*ipanl, asig*kamp*ipanr

      endin
