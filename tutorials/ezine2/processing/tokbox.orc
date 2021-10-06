;===========================================================================
; Talk Box
; Hans Mikelson March 1999
;===========================================================================
sr=44100
kr=22050
ksmps=2
nchnls=2
zakinit 50, 50

;---------------------------------------------------------------------------
; Pluck
;---------------------------------------------------------------------------
       instr  2

iamp   =      p4          ; Amplitude
ifqc  =       cpspch(p5)  ; Convert pitch to frequency
ioutch =      p6          ; Output channel

kamp   linseg 0, .002, iamp, p3-.004, iamp, .002, 0  ; Declick

aplk   pluck  kamp, ifqc, ifqc, 0, 1                 ; Pluck waveguide model
       zawm   aplk, ioutch                           ; Write to output
       endin

;---------------------------------------------------------------------------
; Talk-Box
;---------------------------------------------------------------------------
         instr   10

idur     =       p3          ; Duration
ixtab    =       p4          ; Index table
ifmtab1  =       p5          ; Formant table 1
ifmtab2  =       p6          ; Formant table 2
ifmtab3  =       p7          ; Formant table 3
iatab1   =       p8          ; Amplitude table 1
iatab2   =       p9          ; Amplitude table 2
iatab3   =       p10         ; Amplitude table 3
izin     =       p11         ; Input channel

iptime   =       idur/16     ; Time to slide half way to next formant set
ibw      =       8          ; Bandwidth

kdeclick linseg  0, .002, 1, p3-.004, 1, .002, 0  ; Declick
kformi   oscil   1, 1/idur, ixtab        ; Read the formant index table

kform1   table   kformi, ifmtab1         ; Read the first formant frequency
kdb1     table   kformi, iatab1          ; Read the first formant dB's
kamp1    =       dbamp(60+kdb1)          ; Convert from decibels to amplitude
kform2   table   kformi, ifmtab2         ; Read the second formant frequency
kdb2     table   kformi, iatab2          ; Read the second formant dB's
kamp2    =       dbamp(60+kdb2)          ; Convert dB to amp
kform3   table   kformi, ifmtab3         ; Read the third formant frequency
kdb3     table   kformi, iatab3          ; Read the third formnat dB's
kamp3    =       dbamp(60+kdb3)          ; Convert dB to amp

kfrm1p   port    kform1, iptime, 300     ; Portamento to the next formant
kamp1p   port    kamp1,  iptime, .15     ; Portamento to the next amplitude
kfrm2p   port    kform2, iptime, 2000    ; Repeat for second
kamp2p   port    kamp2,  iptime, .15
kfrm3p   port    kform3, iptime, 4000    ; and again for the third
kamp3p   port    kamp3,  iptime, .15

asig     zar     izin                    ; Output channel
adist    =       tanh(asig/4000)*8000

aform1   butterbp adist, kfrm1p, kfrm1p/ibw  ; Compute the three resonances
aform2   butterbp adist, kfrm2p, kfrm2p/ibw
aform3   butterbp adist, kfrm3p, kfrm3p/ibw

aout     =       (aform1*kamp1p+aform2*kamp2p+aform3*kamp3p)/5  ; Scale and sum

         outs    aout*kdeclick, aout*kdeclick    ; Write to the output channel

         endin

         instr   99
         zacl    0, 50
         endin

