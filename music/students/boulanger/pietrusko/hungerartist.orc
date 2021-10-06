
;================================================================
; HUNGER ARTIST (simple piece for manipulated cello)
; by: bobby
; thanks to mahogany for original cello performance
;
; please note: render using "floats rescaled to 16-bit ints"
;================================================================


sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         2


garvb4    init      0

;=========================
; CELLO INSTRUMENT
;=========================

          instr     15

irvb4     =         p6

kenv      oscil     1, 1/p3, 2
a1        soundin   "celloop1.aif" , 1
a1        =         a1 * kenv
amod      =         a1
a2        oscil     1, p4, p5
a3        =         a2   * amod
a4        =         a2 + a3 
;         outs a4, a4    
garvb4    =         garvb4  + (a4 * irvb4)

          endin 

;===============
; REVERB
;===============

          instr     16

it60      =         p4
ihihz     =         p5
ibw       =         p6
iamp      =         p7
irise     =         p8
ifin      =         p9
icf1      =         p10  
ict1      =         p11
icf2      =         p12
ict2      =         p13
icf3      =         p14
icf4      =         p15


kcf       linseg    icf1, ict1, icf2, ict2, icf3, p3 -(ict1 + ict2), icf4 
kenv      linseg    0, 5, 1, 20, 1, p3 - ( 5 + 20 + 5), .5, 5, 0
; kenv     oscil    iamp, 4/p3, 4
a1        nreverb   garvb4, it60, ihihz
a1        butterbp  a1, kcf, ibw
a1        =         a1 * kenv
          outs      a1, a1    

garvb4    =              0
          endin

