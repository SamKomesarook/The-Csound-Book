;-------------------------------------------------
; CENTRE FOR MUSIC TECHNOLOGY - GLASGOW UNIVERSITY
; SOFTWARE SYNTHESIS AND COMPOSITION SYSTEMS
; TUTOR: DR MIRANDA
; STUDENT NAME: STUART BROWN
; INSTRUMENT: BEASTS.ORC
;-------------------------------------------------
;
; TIME-VARYING SPECTRA FM INSTRUMENT WITH AMPLITUDE MODULATION
;----------------------------------------------------------------------

sr      =       44100
kr      =       4410
ksmps   =       10
nchnls  =       1

;--------------------
; PFIELDS
;--------------------
; p4 = amplitude
; p5 = carrier (fc)
; p6 = modulator (fm)
; p7 = maximum fm modulation index (I)
; p9 = am modulation index (mi)
;---------------------

        instr 1
idev    =       p7*cpspch(p6)          ;DEVIATION INDEX
iattk   =       p3*0.3                 ;MOD INDEX ATTACK TIME
idec1   =       p3*0.3                 ;MOD INDEX/AMPLITUDE INITIAL DECAY TIME
idec2   =       p3*0.4                 ;MOD INDEX/AMPLITUDE FINAL DECAY TIME
isust   =       p3-(iattk+idec1+idec2) ;MOD INDEX/ AMPLITUDE SUSTAIN TIME
kenv   linseg  0,iattk,1,idec1,0.75,isust,0.65,idec2,0
kindex linseg  0,iattk,idev,idec1,0.75*idev,isust,0.65*idev,idec2,0
kam    oscili  p4*p8,p5,1  
amod   oscil   kindex,cpspch(p6),1
acar   oscil   (kam+p4)*kenv,cpspch(p5)+amod,1
       out     acar
       endin
