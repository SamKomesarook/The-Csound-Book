; 1101.ORC    Simple oscillator
;               (c) Rajmil Fischman, 1997
sr      =      	44100
kr    	=     	4410
ksmps  	=     	10
nchnls	=		1

;---------------------------------------- 
        instr 1101
;-------------------------------;PARAMETER LIST
; p4: amplitude
; p5: frequency
; p6: function table
;-------------------------------;
kenv    linen   p4,0.1,p3,0.2   ; ENVELOPE
asig    oscili  kenv,p5,p6      ; OSCILLATOR
;-------------------------------; OUTPUT
        out     asig
        endin
