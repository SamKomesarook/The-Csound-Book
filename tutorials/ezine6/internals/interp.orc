;--------------------------------------
; Interpolation
; Coded by Hans Mikelson August 2000
;--------------------------------------
sr      =     44100      ; Sample rate
kr      =     44100      ; Control rate
ksmps   =     1          ; Samples per control rate
nchnls  =     2          ; Number of channels
        zakinit 100, 100 ; Initialize the Zak system

;---------------------------------------------
; No interpolation
;---------------------------------------------
        instr 1

iamp    =      p4              ; Amplitude
ifqc    =      p5              ; Frequency
ipol    =      p6              ; Unipolar or bipolar table

asig    oscil  iamp, ifqc, 1   ; Oscilator sans interpolation

asig    =      (ipol+1)*asig-ipol*iamp ; Change unipolar to bipolar

        outs   asig, asig      ; Output sound

        endin

;---------------------------------------------
; Linear interpolation
;---------------------------------------------
        instr 2

iamp    =      p4            ; Amplitude
ifqc    =      p5            ; Frequency
ipol    =      p6            ; Unipolar or bipolar table

asig    oscili iamp, ifqc, 1 ; Linear interpolation oscillator

asig    =      (ipol+1)*asig-ipol*iamp ; Change unipolar to bipolar

        outs   asig, asig    ; Output sound

        endin

;---------------------------------------------
; Cubic interpolation
;---------------------------------------------
        instr 3

iamp    =      p4           ; Amplitude
ifqc    =      p5           ; Frequency
ipol    =      p6           ; Unipolar or bipolar table

asig    oscil3 iamp, ifqc, 1 ; Cubic interpolation oscillator

asig    =      (ipol+1)*asig-ipol*iamp ; Change Unipolar to bipolar

        outs   asig, asig   ; Ouput sound

        endin

;---------------------------------------------
; Linear interpolation done manually
;---------------------------------------------
        instr  4

iamp    =      p4              ; Amplitude
ifqc    =      p5              ; Frequency
itbsz   =      16              ; Table size

kphs    phasor ifqc            ; Phasor

kx0     =      int(kphs*itbsz)                ; Get table index for sample on one side of the phasor
kx1     =      (kx0 == itbsz-1) ? 0 : kx0 + 1 ; Get table index for sample on the other side of the phasor

ay0     table  kx0, 1                 ; Get table value for one side of the phasor
ay1     table  kx1, 1                 ; Get table value for other side of the phasor

afrac   =      (kphs*itbsz - kx0)     ; Find the fractional part of the phasor

asig1   =      ay0+(ay1-ay0)*afrac    ; Get the linear interpolation value

asig2   tablei kphs*itbsz, 1          ; Use Csounds internal interpolation for comparison

        outs   asig1*iamp, asig2*iamp ; Output the sound

        endin

;---------------------------------------------
; Sinc interpolation done the hard way
;
; sin((x-t)*sr*pi)*F(t)
; ---------------------
;    ((x-t)*sr*pi)
;
; This instrument sets up sinc interpolation
; for the entire table.
;---------------------------------------------
        instr  5

iamp    =      p4          ; Amplitude
ifqc    =      p5          ; Frequency
itbsz   =      16          ; Table size
ipi     =      3.14159265  ; Pi

kphs    phasor ifqc        ; Phasor of frequency ifqc

ay0     table  0,  1       ; Get all 16 table values
ay1     table  1,  1
ay2     table  2,  1
ay3     table  3,  1
ay4     table  4,  1
ay5     table  5,  1
ay6     table  6,  1
ay7     table  7,  1
ay8     table  8,  1
ay9     table  9,  1
ay10    table  10, 1
ay11    table  11, 1
ay12    table  12, 1
ay13    table  13, 1
ay14    table  14, 1
ay15    table  15, 1

kfrac   =      kphs*16  ; The actual table index

; Get the sinc function for all of the values

as0     =      ((kfrac -  0)==0) ? ay0  : ay0  * sin((kfrac -  0) * ipi)/(kfrac -  0)/ipi
as1     =      ((kfrac -  1)==0) ? ay1  : ay1  * sin((kfrac -  1) * ipi)/(kfrac -  1)/ipi
as2     =      ((kfrac -  2)==0) ? ay2  : ay2  * sin((kfrac -  2) * ipi)/(kfrac -  2)/ipi
as3     =      ((kfrac -  3)==0) ? ay3  : ay3  * sin((kfrac -  3) * ipi)/(kfrac -  3)/ipi
as4     =      ((kfrac -  4)==0) ? ay4  : ay4  * sin((kfrac -  4) * ipi)/(kfrac -  4)/ipi
as5     =      ((kfrac -  5)==0) ? ay5  : ay5  * sin((kfrac -  5) * ipi)/(kfrac -  5)/ipi
as6     =      ((kfrac -  6)==0) ? ay6  : ay6  * sin((kfrac -  6) * ipi)/(kfrac -  6)/ipi
as7     =      ((kfrac -  7)==0) ? ay7  : ay7  * sin((kfrac -  7) * ipi)/(kfrac -  7)/ipi
as8     =      ((kfrac -  8)==0) ? ay8  : ay8  * sin((kfrac -  8) * ipi)/(kfrac -  8)/ipi
as9     =      ((kfrac -  9)==0) ? ay9  : ay9  * sin((kfrac -  9) * ipi)/(kfrac -  9)/ipi
as10    =      ((kfrac - 10)==0) ? ay10 : ay10 * sin((kfrac - 10) * ipi)/(kfrac - 10)/ipi
as11    =      ((kfrac - 11)==0) ? ay11 : ay11 * sin((kfrac - 11) * ipi)/(kfrac - 11)/ipi
as12    =      ((kfrac - 12)==0) ? ay12 : ay12 * sin((kfrac - 12) * ipi)/(kfrac - 12)/ipi
as13    =      ((kfrac - 13)==0) ? ay13 : ay13 * sin((kfrac - 13) * ipi)/(kfrac - 13)/ipi
as14    =      ((kfrac - 14)==0) ? ay14 : ay14 * sin((kfrac - 14) * ipi)/(kfrac - 14)/ipi
as15    =      ((kfrac - 15)==0) ? ay15 : ay15 * sin((kfrac - 15) * ipi)/(kfrac - 15)/ipi

; Add all the values together
asig1   =      as0+as1+as2+as3+as4+as5+as6+as7+as8+as9+as10+as11+as12+as13+as14+as15

asig2   table3  kphs*itbsz, 1         ; Use table3 for comparison

        outs   asig1*iamp, asig2*iamp ; Output the result

        endin

;---------------------------------------------
; Sinc interpolation
;
; sin((x-t)*sr*pi)*F(t)
; ---------------------
;    ((x-t)*sr*pi)
;---------------------------------------------
        instr  7

iamp    =      p4           ; Amplitude
ifqc    =      p5           ; Frequency
ilevel  =      p6           ; Interpolation level
itbsz   =      p7           ; Table size
ipi     =      3.14159265   ; Pi
ibn     =      ilevel+1     ; Base for negative levels
ibp     =      1            ; Base for positive levels

kphs    phasor ifqc         ; Phasor goes from 0 to 1 at fqc ifqc.

kxp     =      int(kphs*itbsz)              ; Get the integer table index of the phasor
kxn     =      kxp                          ; Negative starts out the same as positive
kfrac   =      (kphs*itbsz-int(kphs*itbsz)) ; Get the fractional part of the phasor
ay     table   kxp, 1                       ; Get the initial table value
asig1   =      (kfrac==0) ? ay : ay*sin(kfrac*ipi)/kfrac/ipi ; Compute sinc function for x0 value

kcount  =      0                            ; Loop counter starts at zero
; foreach level do
loop1:
if (kcount>=ilevel) kgoto cont1             ; And goes up to level
  kx     =      (kxp == itbsz-1) ? 0 : kxp + 1 ; Get the next higher index but remember to loop to zero
  ay     table  kx,  1                      ; Get the table value for that index
  kcp1   =      kcount+1                    ; Calculate this ahead to save some time
  kfmcp1 =      kfrac-kcp1                  ; Calculate this ahead to save some time
  khn    =      .5+.5*cos(kfmcp1*ipi/ilevel) ; Hann (Hanning) Window
  as     =      (kfmcp1 == 0) ? ay : khn*ay*sin(kfmcp1*ipi)/kfmcp1/ipi ; Compute the sinc function for this sample
  asig1  =      asig1 + as                  ; Accumulate the sinc values
  kxp    =      kx                          ; Remember which point you were on in the positive direction

  kx     =      (kxn == 0) ? itbsz-1 : kxn - 1 ; Get the next lower index this time loop up to table size
  ay     table  kx,  1                      ; Get the table value
  kfpcp1 =      kfrac+kcp1                  ; Compute this ahead to save some time
  khn    =      .5+.5*cos(kfpcp1*ipi/ilevel) ; Hann (Hanning) Window
  as     =      (kfpcp1 == 0) ? ay : khn*ay*sin(kfpcp1*ipi)/kfpcp1/ipi ; Compute the sinc function for this sample
  asig1  =      asig1 + as                  ; Accumulate the sinc values
  kxn    =      kx                          ; Remember which point you were on in the negative direction

  kcount =      kcount + 1                  ; Update the loop counter
         kgoto  loop1                       ; Loop-Dee-Loop
cont1:

         outs   asig1*iamp, asig1*iamp      ; That's all

         endin


