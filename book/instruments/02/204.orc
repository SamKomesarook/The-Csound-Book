sr      =      	44100
kr    	=     	4410
ksmps  	=     	10
nchnls	=		1

        instr 204
ifrq    =       cpspch(p5)
kenv    linseg  0, .05, p4, p3-.1, p4*.8, .05, 0
asig    oscili  kenv, ifrq/21, p6
        out     asig
        endin
