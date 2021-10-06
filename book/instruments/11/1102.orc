;1102.ORC   SIMPLE OSCILLATOR WITH ENVELOPE
;             (C) RAJMIL FISCHMAN, 1997
sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         1
          
;------------------------------------------------------- 
        instr 1102
;-------------------------------;PARAMETER LIST
; p4: amplitude
; p5: frequency
; p6: attack
; p7: decay
; p8: function table
;-------------------------------;
kenv    linen   p4, p6, p3, p7  ; ENVELOPE
asig    oscili  kenv, p5, p8    ; OSCILLATOR
;-------------------------------; OUTPUT
        out     asig            
        endin
