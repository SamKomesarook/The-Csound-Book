sr      =      	44100
kr    	=     	4410
ksmps  	=     	10
nchnls	=		1

        instr   410         
a1      oscil   p5, 440, 1          ; GENERATE A SIGNAL
a2      =       sin(a1)             ; USE A VALUE CONVERTER
        out     a2*p4               ; AND PLAY THE OUTPUT
        endin
