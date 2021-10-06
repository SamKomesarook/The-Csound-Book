;---------------------------------------------------------
; Filters
; Coded by Hans Mikelson April 2000
;---------------------------------------------------------
sr      =        44100                      ; Sample rate
kr      =        4410                       ; Kontrol rate
ksmps   =        10                         ; Samples/Kontrol period
nchnls  =        2                          ; Normal stereo

;---------------------------------------------------------
; Low pass filtered noise
;---------------------------------------------------------
       instr     10

idur   =         p3                         ; Duration
iamp   =         p4                         ; Amplitude
ifc1   =         p5                         ; Frequency 1
ifc2   =         p6                         ; Frequency 2

; Declick envelope
kdclk  linseg    0, .2, 1, idur-.4, 1, .2, 0
kfco   expseg    ifc1, idur, ifc2           ; Freq sweep

arnd   rand      1                          ; White noise

aout   butterlp  arnd, kfco                 ; Low pass filter
aout   =         aout*iamp*kdclk            ; Amplify

       outs      aout, aout                 ; Output the sound

       endin

;---------------------------------------------------------
; High pass filtered noise
;---------------------------------------------------------
       instr     11

idur   =         p3                         ; Duration
iamp   =         p4                         ; Amplitude
ifc1   =         p5                         ; Frequency 1
ifc2   =         p6                         ; Frequency 2

; Declick envelope
kdclk  linseg    0, .2, 1, idur-.4, 1, .2, 0
kfco   expseg    ifc1, idur, ifc2           ; Freq sweep

arnd   rand      1                          ; White noise

aout   butterhp  arnd, kfco                 ; High pass filter
aout   =         aout*iamp*kdclk*.5         ; Amplify

       outs      aout, aout                 ; Output the sound

       endin

;---------------------------------------------------------
; Band pass filtered noise
;---------------------------------------------------------
       instr     12

idur   =         p3                         ; Duration
iamp   =         p4                         ; Amplitude
ifc1   =         p5                         ; Frequency 1
ifc2   =         p6                         ; Frequency 2

; Declick envelope
kdclk  linseg    0, .2, 1, idur-.4, 1, .2, 0
kfco   expseg    ifc1, idur, ifc2           ; Freq sweep

arnd   rand      1                          ; White noise

aout   butterbp  arnd, kfco, kfco/4         ; Band pass filter
aout   =         aout*iamp*kdclk            ; Amplify

       outs      aout, aout                 ; Output the sound

       endin

;---------------------------------------------------------
; Band pass filtered noise
;---------------------------------------------------------
       instr     13

idur   =         p3                         ; Duration
iamp   =         p4                         ; Amplitude
ifc1   =         p5                         ; Frequency 1
ifc2   =         p6                         ; Frequency 2

; Declick envelope
kdclk  linseg    0, .2, 1, idur-.4, 1, .2, 0
kfco   expseg    ifc1, idur, ifc2           ; Freq sweep

arnd   rand      1                          ; White noise

aout   butterbr  arnd, kfco, kfco/4         ; Band reject filter
aout   =         aout*iamp*kdclk*.5         ; Amplify

       outs      aout, aout                 ; Output the sound

       endin

;---------------------------------------------------------
; Low pass filtered sample
;---------------------------------------------------------
       instr     20

idur   =         p3                         ; Duration
iamp   =         p4                         ; Amplitude
isamp  =         p5                         ; Sample
ifc    =         p6                         ; Frequency 1

; Declick envelope
kdclk  linseg    0, .2, 1, idur-.4, 1, .2, 0

asig   diskin    isamp, 1                   ; Read sample from disk

aout   butterlp  asig, ifc                  ; Low pass filter
aout   =         aout*iamp*kdclk            ; Amplify

       outs      aout, aout                 ; Output the sound

       endin

;---------------------------------------------------------
; High pass filtered sample
;---------------------------------------------------------
       instr     21

idur   =         p3                         ; Duration
iamp   =         p4                         ; Amplitude
isamp  =         p5                         ; Sample
ifc    =         p6                         ; Frequency 1

; Declick envelope
kdclk  linseg    0, .2, 1, idur-.4, 1, .2, 0

asig   diskin    isamp, 1                   ; Read sample from disk

aout   butterhp  asig, ifc                  ; High pass filter
aout   =         aout*iamp*kdclk            ; Amplify

       outs      aout, aout                 ; Output the sound

       endin

;---------------------------------------------------------
; Band pass filtered sample
;---------------------------------------------------------
       instr     22

idur   =         p3                         ; Duration
iamp   =         p4                         ; Amplitude
isamp  =         p5                         ; Sample
if1    =         p6                         ; Frequency 1
if2    =         p7                         ; Frequency 1
if3    =         p8                         ; Frequency 1

; Declick envelope
kdclk  linseg    0, .2, 1, idur-.4, 1, .2, 0

asig   diskin    isamp, 1                   ; Read sample from disk

af1    butterbp  asig, if1, if1/8           ; Band pass filter
af2    butterbp  asig, if2, if2/8           ; Band pass filter
af3    butterbp  asig, if3, if3/8           ; Band pass filter

aout   =         (af1+af2+af3)*iamp*kdclk   ; Amplify

       outs      aout, aout                 ; Output the sound

       endin
