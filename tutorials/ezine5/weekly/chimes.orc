;---------------------------------------------------------
; Chimes
; Coded by Hans Mikelson March 2000
;---------------------------------------------------------
sr      =        44100                      ; Sample rate
kr      =        4410                       ; Kontrol rate
ksmps   =        10                         ; Samples/Kontrol period
nchnls  =        2                          ; Normal stereo

;---------------------------------------------------------
; Chimes
;---------------------------------------------------------
       instr     21

idur   =         p3+.5          ; Duration
iamp   =         p4             ; Amplitude
ifqc   =         cpspch(p5)     ; Pitch to frequency
ipanl  =         sqrt(p6)       ; Pan left
ipanr  =         sqrt(1-p6)     ; Pan right
ifadj  =         (1+40/ifqc)    ; Frequency adjustment
is     =         p7             ; S
it     =         p8*ifadj       ; T
iu     =         p9*ifadj       ; U
iv     =         p10*ifadj      ; V
itabl  =         p11            ; Table
idec   =         p12            ; Decay
p3     =         p3+.5          ; Release
ipbend =         1.01           ; Pitch bend amount
iptim  =         .8             ; Pitch bend time
iatk   =         (.001+.1/ifqc) ; Attack

adclck linseg    0, .001, 1, idur-.051, 1, .05, 0 ; Declick envelope
kamp   expseg    .01, iatk, 1, idec, .001
kptch  expseg    ipbend, 1, 1, .1, 1

kfqc   =        ifqc*kptch

irnd1  =         rnd(.1)
irnd2  =         rnd(.5)

asin1   oscil   1, .4+irnd1,   1, irnd2     ; Sine of frequency U
acos1   oscil   1, .4+irnd1,   1, irnd2+.25 ; Cosine of frequency V

; Cosines
acoss   oscil   1, is*kfqc, itabl, .25     ; Cosine of frequency U
acost   oscil   1, it*kfqc, itabl, .25     ; Cosine of frequency V
acosu   oscil   1, iu*kfqc, itabl, .25     ; Cosine of frequency U
acosv   oscil   1, iv*kfqc, itabl, .25     ; Cosine of frequency V

; Sines
asins   oscil   1, is*kfqc, itabl          ; Sine of frequency U
asint   oscil   1, it*kfqc, itabl          ; Sine of frequency V
asinu   oscil   1, iu*kfqc, itabl          ; Sine of frequency U
asinv   oscil   1, iv*kfqc, itabl          ; Sine of frequency V

; Compute X, Y and Z
axuv    =       asinu*acosv                ; Compute X value
ayuv    =       asinu*asinv                ; Compute Y value
azuv    =       acosu                      ; Compute Z value
az1uv   =       azuv*acos1                 ; Modulate Z value for X
az2uv   =       azuv*asin1                 ; Modulate Z value for Y

axst    =       asins*acost                ; Compute X value
ayst    =       asins*asint                ; Compute Y value
azst    =       acoss                      ; Compute Z value
az1st   =       azst*acos1                 ; Modulate Z value for X
az2st   =       azst*asin1                 ; Modulate Z value for Y

aenv    =       iamp*adclck*kamp*.5
asigl   =       (axuv+axst+az1uv+az1st)*aenv
asigr   =       (ayuv+ayst+az2uv+az2st)*aenv

       outs      asigl*ipanl, asigr*ipanr            ; Output the sound

       endin
