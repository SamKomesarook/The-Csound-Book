;------------------------------------------------------------------------------
; Modified Hyperbolic Distortion
; Coded by Hans Mikelson December 1998
;------------------------------------------------------------------------------
sr=44100
kr=4410
ksmps=10
nchnls=2
zakinit 50, 50

;------------------------------------------------------------------------------
; Plucked instrument
;------------------------------------------------------------------------------
        instr   1

idur    =       p3                                 ; Duration
iamp    =       p4                                 ; Amplitude
ipch    =       cpspch(p5)                         ; Pitch
itab1   =       p6
ioutch  =       p7                                 ; Out Channel

asig    pluck   iamp, ipch, ipch, itab1, 1         ; Generate a plucked tone
        zawm    asig, ioutch                       ; Mix to the Zak channel

        endin

;------------------------------------------------------------------------------
; Sine Wave
;------------------------------------------------------------------------------
        instr   2

idur    =       p3                                 ; Duration
iamp    =       p4                                 ; Amplitude
ifqc    =       cpspch(p5)                         ; Pitch
itab1   =       p6
ioutch  =       p7                                 ; Out Channel

asig    oscil   iamp, ifqc, itab1                  ; Generate a plucked tone
        zawm    asig, ioutch                       ; Mix to the Zak channel

        endin

;------------------------------------------------------------------------------
; Tanh Distortion
;------------------------------------------------------------------------------
         instr   11

idur     =       p3
kpregn   =       p4/8000                          ; Pregain/Overdrive
kpostg   =       p5*20000                         ; Postgain/Volume
ka1      =       p6/8000                          ; Shape 1 0=flat
ka2      =       p7/8000                          ; Shape 2
irect    =       p8                               ; Rectification
iinch    =       p9                               ; Input Channel
ioutch   =       p10                              ; Output Channel
ioutlvl  =       p11                              ; Output Level

kdclick linseg  0, .002, 1, idur-.004, 1, .002, 0  ; DeClick Envelope

asig     zar     iinch
krms     rms     asig, 10
asig     =       asig + irect*krms

koffs1   =       irect*krms*(p4/1000+(p6-.5)/8000)
koffs2   =      -irect*krms*(p4/1000+(p7-.5)/8000)
koffs3   =       irect*krms*p4/1000
koffs    =       (exp(koffs1)-exp(koffs2))/(exp(koffs3)+exp(-koffs3))


ax1      =       asig*(kpregn+ka1)                ; Precalculate a few values to save time
ax2      =      -asig*(kpregn+ka2)
ax3      =       asig*kpregn

aout     =       ((exp(ax1)-exp(ax2))/(exp(ax3)+exp(-ax3))-koffs)*kpostg ; modified tanh distortion

         zaw      aout*kdclick, ioutch         ; Output the result
         outs     aout*kdclick*ioutlvl, aout*kdclick*ioutlvl   ; Output the result

         endin

;------------------------------------------------------------------------------
; Clear Zak
;------------------------------------------------------------------------------
         instr   99
         zacl    0, 50
         zkcl    0, 50
         endin
