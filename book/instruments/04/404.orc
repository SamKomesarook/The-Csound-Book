sr      =      	44100
kr    	=     	4410
ksmps  	=     	10
nchnls	=		1

        instr   404                         
a1      oscil   5, 1, 1             ; GENERATE THE VIBRATO
a2      oscil   32000, 440+a1, 1    ; USE IT ON AN OSCILATOR
        out     a2                  ; AND PLAY THE RESULT
        endin
