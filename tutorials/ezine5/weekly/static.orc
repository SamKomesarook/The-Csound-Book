;---------------------------------------------------------
; Fractal Static
; by Hans Mikelson March 2000
;---------------------------------------------------------
sr      =        44100                      ; Sample rate
kr      =        4410                       ; Kontrol rate
ksmps   =        10                         ; Samples/Kontrol period
nchnls  =        2                          ; Normal stereo

;---------------------------------------------------------
; Static
;---------------------------------------------------------
           instr   64

idur       =       p3          ; Duration
iamp       =       p4          ; Amplitude
ifqc       =       cpspch(p5)  ; Pitch to frequency
ipan       =       p6          ; Panning
idstgn     =       p9          ; Distortion gain
iq         =       p10         ; Resonance

ay         init    p7          ; Initial Y value
ax         init    p8          ; Initial X value

kfco1      oscil   ifqc*4, .1, 1     ; Sine LFO
kfco       =       kfco1+ifqc*4+200  ; Adjust it for filter cut-off

axx        =       .004*ax + ay      ; This is the dynammical system
ay         =       (-1/ay - ay)/ax   ; save X and restore after y is
ax         =       axx               ; updated.

aox1       distort1 ax*idstgn        ; Clip to keep the large values under control
aoy1       distort1 ay*idstgn

aox        rezzy   aox1, kfco, iq    ; Do some filtering to make it sound better
aoy        rezzy   aoy1, kfco, iq


           outs    aox*iamp, aoy*iamp ; Amplify and output

           endin


