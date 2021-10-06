;--------------------------------------------------------------------
; AN ASSORTMENT OF CHAOTIC, FRACTAL AND RELATED INSTRUMENTS
; CODED BY HANS MIKELSON  MARCH 27, 1997
;--------------------------------------------------------------------
; 1. THE LORENZ ATTRACTOR
; 2. THE ROSSLER ATTRACTOR
; 3. PLANET ORBITING IN A BINARY STAR SYSTEM

sr      =       44100
kr      =       4410
ksmps   =       10
nchnls  =       2

;--------------------------------------------------------------------
; THIS INSTRUMENT IS BASED ON THE LORENZ EQUATIONS ONE OF THE 
; FIRST CHAOTIC SYSTEMS DISCOVERED.  I USE IT HERE AS AN
; OSCILLATOR.  AH CAN BE USED TO CHANGE THE PITCH.  SCALE
; WILL CHANGE THE VOLUME.                                  
;--------------------------------------------------------------------

        instr  1

;--------------------------------------------------------------------
ax      init    p5
ay      init    p6
az      init    p7
as      init    p8
ar      init    p9
ab      init    p10
ah      init    p11
ipanl   init    p12
ipanr   init    1-ipanl

kampenv linseg  0,.01,p4,p3-.02,p4,.01,0    ;Amplitude Envelope

;--------------------------------------------------------------------
axnew   =       ax+ah*as*(ay-ax)
aynew   =       ay+ah*(-ax*az+ar*ax-ay)
aznew   =       az+ah*(ax*ay-ab*az)

;--------------------------------------------------------------------
ax      =       axnew
ay      =       aynew
az      =       aznew

;--------------------------------------------------------------------
        outs    ax*kampenv*ipanl,ay*kampenv*ipanr
        endin

;--------------------------------------------------------------------
        instr   2       ; ROSSLER'S ATTRACTOR
;--------------------------------------------------------------------

ax      init    0
ay      init    0
az      init    0
ih      init    p5
aa      init    .375
ib      init    p6
ic      init    p7
ipanl   init    p8
ipanr   init    1-ipanl


; AMPLITUDE ENVELOPE
;--------------------------------------------------------------------
kampenv linseg  0,.01,p4,p3-.02,p4,.01,0

;--------------------------------------------------------------------
aa      oscil   1/7,.5,1
aa      =       .3+aa

;--------------------------------------------------------------------
axnew   =       ax+ih*(-ay-az)
aynew   =       ay+ih*(ax+aa*ay)
aznew   =       az+ih*(ib+ax*az-ic*az)

;--------------------------------------------------------------------
ax      =       axnew
ay      =       aynew
az      =       aznew

;--------------------------------------------------------------------
        outs    kampenv*ax*ipanl,kampenv*ay*ipanr

        endin

;--------------------------------------------------------------------
; THIS SIMULATES A PLANET ORBITING IN A MULTIPLE STAR SYSTEM
;--------------------------------------------------------------------
        instr   3

;--------------------------------------------------------------------
kampenv linseg  0, .01, p4, p3-.02, p4, .01, 0

;--------------------------------------------------------------------
; PLANET POSITION (X, Y, Z) & VELOCITY (VX, VY, VZ)
kx      init    0
ky      init    .1
kz      init    0
kvx     init    .5
kvy     init    .6
kvz     init    -.1
ih      init    p5
ipanl   init    p9
ipanr   init    1-ipanl

;--------------------------------------------------------------------
; STAR 1 MASS & X, Y, Z
imass1  init    p6
is1x    init    0
is1y    init    0
is1z    init    p8

;--------------------------------------------------------------------
; STAR 2 MASS & X, Y, Z
imass2  init    p7
is2x    init    0
is2y    init    0
is2z    init    -p8

;--------------------------------------------------------------------
; CALCULATE DISTANCE TO STAR 1
kdx     =       is1x-kx
kdy     =       is1y-ky
kdz     =       is1z-kz
ksqradius =     kdx*kdx+kdy*kdy+kdz*kdz+1
kradius =       sqrt(ksqradius)

;--------------------------------------------------------------------
; DETERMINE ACCELERATION DUE TO STAR 1 (AX, AY, AZ)
kax     =       imass1/ksqradius*kdx/kradius
kay     =       imass1/ksqradius*kdy/kradius
kaz     =       imass1/ksqradius*kdz/kradius

;--------------------------------------------------------------------
; CALCULATE DISTANCE TO STAR 2
kdx     =       is2x-kx
kdy     =       is2y-ky
kdz     =       is2z-kz
ksqradius =     kdx*kdx+kdy*kdy+kdz*kdz+1
kradius =       sqrt(ksqradius)

;--------------------------------------------------------------------
; DETERMINE ACCELERATION DUE TO STAR 2 (AX, AY, AZ)
kax     =       kax+imass2/ksqradius*kdx/kradius
kay     =       kay+imass2/ksqradius*kdy/kradius
kaz     =       kaz+imass2/ksqradius*kdz/kradius

;--------------------------------------------------------------------
; UPDATE THE VELOCITY
kvx     =       kvx+ih*kax
kvy     =       kvy+ih*kay
kvz     =       kvz+ih*kaz

;--------------------------------------------------------------------
; UPDATE THE POSITION
kx      =       kx+ih*kvx
ky      =       ky+ih*kvy
kz      =       kz+ih*kvz

aoutx   =       kx*kampenv*ipanl
aouty   =       ky*kampenv*ipanr
        outs    aoutx,aouty

        endin

