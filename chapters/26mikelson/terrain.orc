;-----------------------------------------------------------
; Terrain Mapping Example
; Coded by Hans Mikelson
; July 15, 1998
;-----------------------------------------------------------

sr=44100         ; Sample rate
kr=22050         ; Control rate
ksmps=2          ; sr/kr
nchnls=2         ; Stereo output
zakinit 50, 50   ; Initialize the Zak channels

;-----------------------------------------------------------
; Sine Modulation
;-----------------------------------------------------------
        instr   3

idur    =       p3                     ; Duration
iamp    =       p4                     ; Amplitude
ifqc    =       p5                     ; Frequency
iphase  =       p6                     ; Phase offset
ioutch  =       p7                     ; Output channel

krad1   oscili  iamp, ifqc, 1, iphase  ; Sine wave oscillator
kout    =       krad1+2*iamp           ; Make it positive
        zkw     kout, ioutch           ; Send it out on the K-channel

        endin

;-----------------------------------------------------------
; 4D
; w=sin^2*(sqrt(x^2+y^2+z^2))
;-----------------------------------------------------------
       instr   5

idur    =    p3                       ; Duration
iamp    =    p4                       ; Amplitude
ifqc    =    cpspch(p5)               ; Convert pitch to frequency
iwamp   =    p6                       ; Amplitude of the w dimension
ioutch1 =    p7                       ; Output audio channel 1
ioutch2 =    p8                       ; Output audio channel 2
ioutch3 =    p9                       ; Output audio channel 3
ioutch4 =    p10                      ; Output audio channel 4

kdclick linseg 0, .02, iamp, idur-.04, iamp, .02, 0 ; De-click envelope
krminor oscil  5, .2, 1                             ; Modulate the minor radius
krminor =      krminor+6                            ; Make it positive
krmajor =      krminor+1                            ; Major radius is 1 bigger than minor

asin1  oscil krminor, ifqc, 1         ; Minor circle Y coordinate
acos1  oscil krminor, ifqc, 1, .25    ; Minor circle X coordinate
asin2  oscil krmajor, ifqc/4, 1       ; Major circle Y coordinate
acos2  oscil krmajor, ifqc/4, 1, .25  ; Major circle X coordinate

ax     =     asin1+acos2              ; This orbit is a spiral on
ay     =     acos1                    ; the surface of a torus whose
az     =     asin2                    ; radius is being modulated.

aw1    =     sin(sqrt(ax*ax+ay*ay+az*az))   ; Compute the surface a bumpy 4 dimensional surface
aw     =     aw1*aw1-.5               ; Remove some DC offset

       zawm  ax*kdclick, ioutch1      ; Output to the Zak audio channels
       zawm  ay*kdclick, ioutch2
       zawm  az*kdclick, ioutch3
       zawm  aw*kdclick*iwamp, ioutch4

       endin

;-----------------------------------------------------------
; Z=X-1/12*X^3-1/4*Y^2
; Lead 1
;-----------------------------------------------------------
       instr 12

idur   =     p3                 ; Duration
iamp   =     p4                 ; Amplitude
ifqc   =     cpspch(p5)         ; Convert pitch to frequency
imodch =     p6                 ; Control channel input
ipetal =     p7                 ; Number of petals on the rose curve
ioutch =     p8                 ; Output audio channel

kmod1  zkr   imodch             ; Read control channel

kdclick linseg 0, .002, iamp, idur-.004, iamp, .002, 0  ; De-Click envelope
kpfade  linseg 0, .2, 0, .2, .01, idur-.4, .005         ; Vibrato fade
kplfo   oscil  kpfade, 6, 1             ; Vibrato
kfqc    =      (1+kplfo)*ifqc           ; Modulate the pitch

arose  oscil kmod1, ipetal*kfqc, 1      ; Rose Curve
ax     oscil arose, kfqc, 1             ; Convert from polar to
ay     oscil arose, kfqc, 1, .25        ; rectangular coordinates

az     =     ax-ax*ax*ax/12-ay*ay/4+.5  ; Compute the surface
adcblk butterhp az, 20                  ; Remove the DC component

       zaw   adcblk*kdclick, ioutch     ; Output to a zak audio channel

       endin

;-----------------------------------------------------------
; Z=-5*X/(X^2+Y^2+1)
; Squarish Lead 2
;-----------------------------------------------------------
       instr 13

idur   =     p3                 ; Duration
iamp   =     p4                 ; Amplitude
ifqc   =     cpspch(p5)         ; Convert pitch to frequency
imodch =     p6                 ; Control channel
ipetal =     p7                 ; Number of petals on the rose curve
idetun =     p8                 ; Detune amount

ifqc1  =     ifqc*(1+idetun)    ; Add some chorusing
ifqc2  =     ifqc*(1-idetun*.9) ; and stereo detuning

kmod1  zkr   imodch             ; Read from the modulation control channel
kdclick linseg 0, .002, iamp, idur-.004, iamp, .002, 0  ; De-Click envelope

arose  oscil kmod1+1, ipetal*ifqc, 1    ; Rose Curve
ax     oscil arose, ifqc, 1             ; Convert from polar to
ay     oscil arose, ifqc, 1, .25        ; rectangular coordinates
az     =     -5*ax/(ax*ax+ay*ay+1)      ; Compute the surface for oscillator 1

arose1 oscil kmod1+1, ipetal*ifqc1, 1   ; Rose Curve
ax1    oscil arose1, ifqc1, 1           ; Convert from polar to
ay1    oscil arose1, ifqc1, 1, .25      ; rectangular coordinates
az1    =     -5*ax1/(ax1*ax1+ay1*ay1+1) ; Compute the surface for oscillator 2

arose2 oscil kmod1+1, ipetal*ifqc2, 1   ; Rose Curve
ax2    oscil arose2, ifqc2, 1           ; Convert from polar to
ay2    oscil arose2, ifqc2, 1, .25      ; rectangular coordinates
az2    =     -5*ax2/(ax2*ax2+ay2*ay2+1) ; Compute the surface for oscillator 3

adcblkl butterhp (az+az1)/2, 20         ; Block DC
adcblkr butterhp (az+az2)/2, 20         ; Block DC

       outs   adcblkl*kdclick, adcblkr*kdclick  ; Output stereo

       endin

;-----------------------------------------------------------
; Z=-5*X/(X^2+Y^2+1)
; Squarish Lead 2
;-----------------------------------------------------------
       instr 14

idur   =     p3                 ; Duration
iamp   =     p4                 ; Amplitude
ifqc   =     cpspch(p5)         ; Convert pitch to frequency
imodch =     p6                 ; Control channel
ipetal =     p7                 ; Number of petals on the rose curve
idetun =     p8                 ; Detune amount
ifade  =     p9                 ; Fade in and out

ifqc1  =     ifqc*(1+idetun)    ; Add some chorusing
ifqc2  =     ifqc*(1-idetun*.9) ; and stereo detuning

kmod1  zkr   imodch             ; Read from the modulation control channel
kdclick linseg 0, ifade, iamp, idur-2*ifade, iamp, ifade, 0  ; De-Click envelope

arose  oscil kmod1+1, ipetal*ifqc, 1    ; Rose Curve
ax     oscil arose, ifqc, 1             ; Convert from polar to
ay     oscil arose, ifqc, 1, .25        ; rectangular coordinates
az     =     -5*ax/(ax*ax+ay*ay+1)      ; Compute the surface for oscillator 1

arose1 oscil kmod1+1, ipetal*ifqc1, 1   ; Rose Curve
ax1    oscil arose1, ifqc1, 1           ; Convert from polar to
ay1    oscil arose1, ifqc1, 1, .25      ; rectangular coordinates
az1    =     -5*ax1/(ax1*ax1+ay1*ay1+1) ; Compute the surface for oscillator 2

arose2 oscil kmod1+1, ipetal*ifqc2, 1   ; Rose Curve
ax2    oscil arose2, ifqc2, 1           ; Convert from polar to
ay2    oscil arose2, ifqc2, 1, .25      ; rectangular coordinates
az2    =     -5*ax2/(ax2*ax2+ay2*ay2+1) ; Compute the surface for oscillator 3

adcblkl butterhp (az+az1)/2, 20         ; Block DC
adcblkr butterhp (az+az2)/2, 20         ; Block DC

       outs   adcblkl*kdclick, adcblkr*kdclick  ; Output stereo

       endin

;-----------------------------------------------------------
; Terrain Mapped Bass
; z=sqrt(x^4+y^4-x^2-y^2-x^2Y^2+1)
;-----------------------------------------------------------
        instr   19

idur    =       p3                   ; Duration
iamp    =       p4                   ; Amplitude
aamp1   init    iamp                 ; Used to balance the signal
ifqc    =       cpspch(p5)           ; Convert pitch to frequency
ikch1   =       p6                   ; Input control 1
ikch2   =       p7                   ; Input control 2
ibndtab =       p8                   ; Pitch bend table

kamp    linseg  0, .01, 2, .1, 1.5, idur-.21, 1, .1, 0  ; Amp Envelope

krad1   zkr     ikch1                ; Read in radius 1
krad2   zkr     ikch2                ; Read in radius 2

kbend   oscil   1, 1/idur, ibndtab   ; Pitch bend
kfqc    =       kbend*ifqc           ; Adjust frequency by pitch bend

asin1   oscil   krad1, kfqc, 1       ; Y component of circle radius 1 
acos1   oscil   krad1, kfqc, 1, .25  ; X component of circle radius 1
asin2   oscil   krad2, kfqc, 1, .5   ; Y component of circle radius 2
acos2   oscil   krad2, kfqc, 1, .75  ; X component of circle radius 2

ax1     =       asin1+.35            ; Offset the circle centers a bit
ay1     =       acos1-.80            ; so the waves are assymmetrical.
ax2     =       asin2+.5
ay2     =       acos2-.20

axsq1   =       ax1*ax1              ; Compute X^2 and Y^2 in advance
aysq1   =       ay1*ay1              ; to save time.
axsq2   =       ax2*ax2
aysq2   =       ay2*ay2

; Compute the surface
az1     =       sqrt(axsq1*axsq1+aysq1*aysq1-axsq1-aysq1-axsq1*aysq1+1)
az2     =       sqrt(axsq2*axsq2+aysq2*aysq2-axsq2-aysq2-axsq2*aysq2+1)

abal1   balance az1, aamp1           ; Balance the signal
abal2   balance az2, aamp1           ; Balance the signal

aout1   butterhp abal1, 10           ; DC blocking filter
aout2   butterhp abal2, 10           ; DC blocking filter

        outs    aout1*kamp, aout2*kamp  ; Stereo output

        endin

;-----------------------------------------------------------
; Pulsar
; z=sqrt((1-x^2)*((1-y)+y*cos(1/x)))
;-----------------------------------------------------------
       instr   8

idur    =       p3                         ; Duration
iamp    =       p4                         ; Amplitude
ifqc    =       p5                         ; Frequency
imodch  =       p6                         ; Modulation channel
ipantab =       p7                         ; Panner table
iamptab =       p8                         ; Fader table

kmod    zkr     imodch                     ; Read the modulation
kpan    oscili  1, 1/idur, ipantab         ; Panner
kpanl   =       sqrt(kpan)                 ; Pan left
kpanr   =       sqrt(1-kpan)               ; Pan right
kamp    oscili  iamp, 1/idur, iamptab      ; Amplitude Fader
ka      =       .01+kmod                   ; Cardioid A
kb      =       .1+kmod*.2                 ; Cardioid B

acardi oscil    kb, ifqc, 1                ; Cardioid Curve
ax1    oscil    ka+acardi, ifqc, 1         ; Convert from polar to
ax     =        ax1
ay     oscil    ka+acardi, ifqc, 1, .25    ; rectangular coordinates
az     =        sqrt((1-ax*ax)*((1-ay)+ay*cos(1/(ax*ax+.01))))-1   ; Compute the surface

aout   butterhp az, 20                     ; Remove DC
       outs     aout*kamp*kpanl, aout*kamp*kpanr  ; Output stereo with panning and fading

       endin

;-----------------------------------------------------------
; 4 Space Planar Rotations
;-----------------------------------------------------------
        instr 51

ifqc    =    p4                              ; Frequency
iphase  =    p5                              ; Phase offset
iplane  =    p6                              ; Plane number
inx     =    p7                              ; Input for X coordinate
iny     =    p8                              ; Input for Y coordinate
inz     =    p9                              ; Input for Z coordinate
inw     =    p10                             ; Input for W coordinate
ioutx   =    p11                             ; Output for X coordinate
iouty   =    p12                             ; Output for Y coordinate
ioutz   =    p13                             ; Output for Z coordinate
ioutw   =    p14                             ; Output for W coordinate

kcost  oscil 1, ifqc,   1, .25+iphase        ; Cosine
ksint  oscil 1, ifqc,   1, iphase            ; Sine

ax      zar  inx                             ; Read in audio channels X, Y, Z and W
ay      zar  iny
az      zar  inz
aw      zar  inw

; Rotation in X-Y plane
  if (iplane!=1) goto next1
    axr = ax*kcost + ay*ksint
    ayr =-ax*ksint + ay*kcost
    azr = az
    awr = aw
    goto nextend

; Rotation in X-Z plane
next1:
  if (iplane!=2) goto next2
    axr = ax*kcost + az*ksint
    ayr = ay
    azr =-ax*ksint + az*kcost
    awr = aw
    goto nextend

; Rotation in Y-Z plane
next2:
  if (iplane!=3) goto next3
    axr = ax
    ayr = ay*kcost + az*ksint
    azr =-ay*ksint + az*kcost
    awr = aw
    goto nextend

; Rotation in X-W plane
next3:
  if (iplane!=4) goto next4
    axr = ax*kcost + aw*ksint
    ayr = ay
    azr = az
    awr =-ax*ksint + aw*kcost
    goto nextend

; Rotation in Y-W plane
next4:
  if (iplane!=5) goto next5
    axr = ax
    ayr = ay*kcost + aw*ksint
    azr = az
    awr =-ay*ksint + aw*kcost
    goto nextend

; Rotation in Z-W plane
next5:
  if (iplane!=6) goto nextend
    axr = ax
    ayr = ay
    azr = az*kcost + aw*ksint
    awr =-az*ksint + aw*kcost

nextend:
        zaw axr, ioutx                          ; Output audio X, Y, Z and W
        zaw ayr, iouty
        zaw azr, ioutz
        zaw awr, ioutw

endin

;---------------------------------------------------------------------------
; Mixer Section
;---------------------------------------------------------------------------
          instr  95

idur      =      p3                               ; Duration
iamp      =      p4                               ; Amplitude
ifadtab   =      p5                               ; Fader Table
iinch     =      p6                               ; Input Channel
ipantab   =      p7                               ; Panner Table

ain1      zar    iinch                            ; Read audio input channel

kamp      oscili iamp, 1/idur, ifadtab            ; Fader
kpan      oscili 1, 1/idur, ipantab               ; Panner
kpanl     =      sqrt(kpan)                       ; Pan Left
kpanr     =      sqrt(1-kpan)                     ; Pan Right
          outs   ain1*kamp*kpanl, ain1*kamp*kpanr ; Output stereo with fader and panner

          endin

;---------------------------------------------------------------------------
; Clear audio & control channels
;---------------------------------------------------------------------------
          instr 99

          zacl  0, 50          ; Clear audio channels 0 to 30
          zkcl  0, 50          ; Clear control channels 0 to 30

          endin
