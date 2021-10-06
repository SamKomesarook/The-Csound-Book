;-----------------------------------------------------------------
; Julia Set Instruments
; Coded by Hans Mikelson June 28, 1999
;-----------------------------------------------------------------
sr=44100                         ; Sample rate
kr=22050                         ; Control rate
ksmps=2                          ; Samples per control period
nchnls=2                         ; Number of channels

;-----------------------------------------------------------------
; Julia Set Waveform, Rastor Scan
;-----------------------------------------------------------------
          instr  10

  idur    =      p3              ; Duration
  aamp    init   p4              ; Amplitude
  ifqc    =      cpspch(p5)      ; Frequency
  kxtrace init   p6              ; X-Scan
  kytrace init   p7              ; Y-Scan
  kxstep  init   p8              ; X-Step size
  kystep  init   p9*ifqc/55      ; Y-Step size
  ilpmax  init   p10             ; Maximum number of inner loops
  ipanl   =      sqrt(p11)       ; Pan left
  ipanr   =      sqrt(1-p11)     ; Pan right
  kcx     init   p12             ; Real constant
  kcy     init   p13             ; Complex constant
  kclk    init   1               ; A square clock going from -1 to 1
  aout2   init   0               ; Output 2
  kdy     init   1               ; Step direction because of the rastor scan
  aout1   init   0               ; step direction reverses each cycle.

  kclkold =      kclk            ; Remember the previous clock value
  kclk    oscil  1, ifqc, 9      ; Obtain the new clock value

  kdclick linseg 0, .002, 1, idur-.004, 1, .002, 0 ; Declick envelope
  kfco    linseg 500, .1, 2000, .2, 1400, idur-.3, 800
  
  kcount = 0                     ; Initialize loop counter
  kx     = kxtrace               ; Initialize X coordinate (real)
  ky     = kytrace               ; Initialize Y coordinate (complex)

julialoop:      ; Iteration for calculating the Julia Set.

  kxx = kx*kx-ky*ky+kcx          ; Compute Z^2 + C
  kyy = 2*kx*ky+kcy              ; (x+iy)^2=x^2+ixy-y^2
  kx  = kxx
  ky  = kyy
  kcount = kcount + 1

if ((kx*kx+ky*ky<4) && (kcount<ilpmax)) goto julialoop ; Check for loop exit

; Update the traces.
kytrace = kytrace + kystep*kclk  ; Continue the rastor scan

if (kclkold == kclk) goto endif1 ; If (kclkold != kclk) then
  kxtrace=kxtrace+kxstep         ;   Update the X position
endif1:

acount =        kcount
arez   rezzy    acount, kfco, 20  ; Add resonant filter effect
adcblk butterhp arez, 20          ; Remove the DC bias
abal   balance  adcblk, aamp      ; Try to compensate for varying amplitudes

      outs abal*ipanl*kdclick, abal*ipanr*kdclick  ; Declick, Pan and output

      endin

;-----------------------------------------------------------------
; Julia Set Additive
;-----------------------------------------------------------------
          instr  11

idur    =      p3              ; Duration
iamp    =      p4              ; Amplitude
ifqc    =      cpspch(p5)      ; Frequency
kxtrace init   p6              ; X-Scan
kytrace init   p7              ; Y-Scan
kxstep  init   p8*.0002/idur   ; X-Step size
kystep  init   p9              ; Y-Step size
ilpmax  =      p10             ; Maximum number of inner loops
ipanl   =      sqrt(p11)       ; Pan left
ipanr   =      sqrt(1-p11)     ; Pan right
kcx     init   p12             ; Real constant
kcy     init   p13             ; Complex constant
iport   =      p14             ; Portamento time

kdclick linseg 0, .005, 1, idur-.01, 1, .005, 0  ; Declick envelope
  
; Loop1
kx     =   kxtrace               ; Initialize X coordinate (real)
ky     =   kytrace               ; Initialize Y coordinate (complex)
kcnt1  =   0                     ; Initialize loop counter
julialoop1:                      ; Iteration for calculating the Julia Set.

  kxx = kx*kx-ky*ky+kcx          ; Compute Z^2 + C
  kyy = 2*kx*ky+kcy              ; (x+iy)^2=x^2+ixy-y^2
  kx  = kxx
  ky  = kyy
  kcnt1 = kcnt1 + 1

if ((kx*kx+ky*ky<4) && (kcnt1<ilpmax)) goto julialoop1 ; Check for loop exit

; Loop2
kx     =   kxtrace               ; Initialize X coordinate (real)
ky     =   kytrace+kystep        ; Initialize Y coordinate (complex)
kcnt2  =   0                     ; Initialize loop counter
julialoop2:                      ; Iteration for calculating the Julia Set.

  kxx = kx*kx-ky*ky+kcx          ; Compute Z^2 + C
  kyy = 2*kx*ky+kcy              ; (x+iy)^2=x^2+ixy-y^2
  kx  = kxx
  ky  = kyy
  kcnt2 = kcnt2 + 1

if ((kx*kx+ky*ky<4) && (kcnt2<ilpmax)) goto julialoop2 ; Check for loop exit

; Loop3
kx     =   kxtrace               ; Initialize X coordinate (real)
ky     =   kytrace+kystep*2      ; Initialize Y coordinate (complex)
kcnt3  =   0                     ; Initialize loop counter
julialoop3:                      ; Iteration for calculating the Julia Set.

  kxx = kx*kx-ky*ky+kcx          ; Compute Z^2 + C
  kyy = 2*kx*ky+kcy              ; (x+iy)^2=x^2+ixy-y^2
  kx  = kxx
  ky  = kyy
  kcnt3 = kcnt3 + 1

if ((kx*kx+ky*ky<4) && (kcnt3<ilpmax)) goto julialoop3 ; Check for loop exit

; Loop4
kx     =   kxtrace               ; Initialize X coordinate (real)
ky     =   kytrace+kystep*3      ; Initialize Y coordinate (complex)
kcnt4  =   0                     ; Initialize loop counter
julialoop4:                      ; Iteration for calculating the Julia Set.

  kxx = kx*kx-ky*ky+kcx          ; Compute Z^2 + C
  kyy = 2*kx*ky+kcy              ; (x+iy)^2=x^2+ixy-y^2
  kx  = kxx
  ky  = kyy
  kcnt4 = kcnt4 + 1

if ((kx*kx+ky*ky<4) && (kcnt4<ilpmax)) goto julialoop4 ; Check for loop exit

; Loop5
kx     =   kxtrace               ; Initialize X coordinate (real)
ky     =   kytrace+kystep*4      ; Initialize Y coordinate (complex)
kcnt5  =   0                     ; Initialize loop counter
julialoop5:                      ; Iteration for calculating the Julia Set.

  kxx = kx*kx-ky*ky+kcx          ; Compute Z^2 + C
  kyy = 2*kx*ky+kcy              ; (x+iy)^2=x^2+ixy-y^2
  kx  = kxx
  ky  = kyy
  kcnt5 = kcnt5 + 1

if ((kx*kx+ky*ky<4) && (kcnt5<ilpmax)) goto julialoop5 ; Check for loop exit

; Loop6
kx     =   kxtrace               ; Initialize X coordinate (real)
ky     =   kytrace+kystep*5      ; Initialize Y coordinate (complex)
kcnt6  =   0                     ; Initialize loop counter
julialoop6:                      ; Iteration for calculating the Julia Set.

  kxx = kx*kx-ky*ky+kcx          ; Compute Z^2 + C
  kyy = 2*kx*ky+kcy              ; (x+iy)^2=x^2+ixy-y^2
  kx  = kxx
  ky  = kyy
  kcnt6 = kcnt6 + 1

if ((kx*kx+ky*ky<4) && (kcnt6<ilpmax)) goto julialoop6 ; Check for loop exit

; Loop7
kx     =   kxtrace               ; Initialize X coordinate (real)
ky     =   kytrace+kystep*6      ; Initialize Y coordinate (complex)
kcnt7  =   0                     ; Initialize loop counter
julialoop7:                      ; Iteration for calculating the Julia Set.

  kxx = kx*kx-ky*ky+kcx          ; Compute Z^2 + C
  kyy = 2*kx*ky+kcy              ; (x+iy)^2=x^2+ixy-y^2
  kx  = kxx
  ky  = kyy
  kcnt7 = kcnt7 + 1

if ((kx*kx+ky*ky<4) && (kcnt7<ilpmax)) goto julialoop7 ; Check for loop exit

; Loop8
kx     =   kxtrace               ; Initialize X coordinate (real)
ky     =   kytrace+kystep*7      ; Initialize Y coordinate (complex)
kcnt8  =   0                     ; Initialize loop counter
julialoop8:                      ; Iteration for calculating the Julia Set.

  kxx = kx*kx-ky*ky+kcx          ; Compute Z^2 + C
  kyy = 2*kx*ky+kcy              ; (x+iy)^2=x^2+ixy-y^2
  kx  = kxx
  ky  = kyy
  kcnt8 = kcnt8 + 1

if ((kx*kx+ky*ky<4) && (kcnt8<ilpmax)) goto julialoop8 ; Check for loop exit

; Update the traces.
kxtrace =       kxtrace+kxstep   ; Update the X position

ka1    port     kcnt1, iport     ; Use portamento to avoid clicking
ka2    port     kcnt2, iport     ; as the different harmonics are turned on.
ka3    port     kcnt3, iport
ka4    port     kcnt4, iport
ka5    port     kcnt5, iport
ka6    port     kcnt6, iport
ka7    port     kcnt7, iport
ka8    port     kcnt8, iport

ao1    oscil    ka1, ifqc,   1   ; Fundamental
ao2    oscil    ka2, ifqc*2, 1   ; 1st harmonic
ao3    oscil    ka3, ifqc*3, 1   ; 2nd harmonic
ao4    oscil    ka4, ifqc*4, 1   ; 3rd harmonic
ao5    oscil    ka5, ifqc*5, 1   ; 4th harmonic
ao6    oscil    ka6, ifqc*6, 1   ; 5th harmonic
ao7    oscil    ka7, ifqc*7, 1   ; 6th harmonic
ao8    oscil    ka8, ifqc*8, 1   ; 7th harmonic

aamp   init     iamp             ; balance needs arate so convert here.
abal   balance  ao1+ao2+ao3+ao4+ao5+ao6+ao7+ao8, aamp, 100 ; Try to compensate for varying amplitudes

       outs     abal*ipanl*kdclick, abal*ipanr*kdclick     ; Declick, Pan and output

       endin


