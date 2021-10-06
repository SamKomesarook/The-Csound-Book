; Parametric Equation oscillators
sr=44100
kr=22050
ksmps=2
nchnls=2

; Cycloid curve
; This set of parametric equations defines the path traced by
; a point on a circle of radius B rotating outside or inside
; a circle of radius A.
         instr  2

idur     =      p3           ; Duration
iamp     =      p4           ; Amplitude
ifqc     =      cpspch(p5)   ; Convert pitch to frequency
ia       =      p6           ; Radius circle a
ib       =      p7           ; Radius circle b
ihole    =      p8           ; Position along circle b radius which is followed
isgn     =      p9           ; Sign +=outside circle, -=inside circle
ipbnd    =      p10          ; Pitch bend table
ibndrt   =      p11          ; Pitch bend rate
iscale   =      1/(ia+2*ib)  ; Scaling factor to normalize volume

apbnd    oscil  1, ibndrt/idur, ipbnd              ; Pitch bend
aamp     linseg 0, .02, iamp*iscale, idur-.04, iamp*iscale, .02, 0 ; DeClick envelope
afqc     =      apbnd*ifqc                         ; Bend the pitch

; Sine and Cosine
acos1    oscil  ia+ib*isgn, afqc, 1, .25           ; Cosine equation 1
acos2    oscil  ib*ihole, (ia-ib)/ib*afqc, 1, .25  ; Cosine equation 2
ax       =      acos1 + acos2                      ; X value is the sum of the cosines

asin1    oscil  ia+ib*isgn, afqc, 1                ; Sine equation 1
asin2    oscil  ib*ihole, (ia-ib)/ib*afqc, 1       ; Sine equation 2
ay       =      asin1 - asin2                      ; Y value is the difference of the sines

         outs   aamp*ax, aamp*ay                   ; Declick and output

         endin

; Butterfly Curves
        instr  7

idur    =      p3          ; Duration
iamp    =      p4          ; Amplitude
ifqc    =      cpspch(p5)  ; Convert pitch to frequency
ia      =      p6          ; Parameter A
ib      =      p7          ; Parameter B
ic      =      p8          ; Parameter C
id      =      p9          ; Parameter D
ie      =      p10         ; Parameter E

kamp    linseg 0, .001, iamp, idur-.002, iamp, .001, 0 ; Declick amplitude envelope

klfo1   oscil  .01, 6, 1                            ; LFO 1
krmp1   linseg 0, .1, 0, .2, 1, p3-.3, 1            ; Ramp 1

klfo2   oscil  .02, 4, 1                            ; LFO 2
krmp2   linseg 0, .4, 1, p3-.2, 1                   ; Ramp 2

kc      linseg .5*ic, idur*.5, ic*2, idur*.5, .5*ic ; Modulate C with an envelope
kb      =      ib*(1+klfo1*krmp1)                   ; Modulate B with an LFO
kd      =      id*(1+klfo2*krmp2)                   ; Modulate D with an LFO

; Cosines
acos1   oscil  1,  ifqc,    1, .25                  ; Cosine 1
acos2   oscil  ia, kb*ifqc, 1, .25                  ; Cosine 2
acos3   oscil  1, ifqc/kd,  1, .25                  ; Cosine 3

; Sines
asin1   oscil  1, ifqc,   1                         ; Sine 1
asin2   pow    asin1, ic                            ; Sine 2
asin3   oscil  1, ifqc/kd,   1                      ; Sine 3

arho    =      exp(ie*acos1)-acos2+asin2            ; Generate the radius

ax      =      arho*acos3                           ; Generate X value
ay      =      arho*asin3                           ; Generate Y value

        outs   ax*kamp, ay*kamp                     ; Declick and output

        endin

; Spherical Lissajous Figures
        instr   8

idur    =       p3          ; Duration
iamp    =       p4          ; Amplitude
ifqc    =       cpspch(p5)  ; Convert pitch to frequency
iu      =       p6          ; U parameter
iv      =       p7          ; V parameter
irt2    =       sqrt(2)     ; Square root of 2
iradius =       1           ; Radius is 1

kamp    linseg  0, .002, iamp, idur-.004, iamp, .002, 0 ; Declick envelope

acos1   oscil   1, .5, 1, .25
asin1   oscil   1, .5, 1

; Cosines
acosu   oscil   1, iu*ifqc,   1, .25       ; Cosine of frequency U
acosv   oscil   1, iv*ifqc,   1, .25       ; Cosine of frequency V

; Sines
asinu   oscil   1, iu*ifqc,   1            ; Sine of frequency U
asinv   oscil   1, iv*ifqc,   1            ; Sine of frequency V

; Compute X and Y
ax      =       iradius*asinu*acosv        ; Compute X value
ay      =       iradius*asinu*asinv        ; Compute Y value
az      =       iradius*acosu              ; Compute Z value
az1     =       az*acos1                   ; Modulate Z value for X
az2     =       az*asin1                   ; Modulate Z value for Y
        outs    (ax+az1)*kamp/2, (ay+az2)*kamp/2 ; Scale X and Y values and add Z

        endin


