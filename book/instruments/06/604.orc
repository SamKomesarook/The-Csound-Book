sr      =      	44100
kr    	=     	4410
ksmps  	=     	10
nchnls	=		1

        instr    604        
index   =       p4                  ; LOOKUP INDEX FOR F-TABLE
ift     table   index, 99           ; ift HOLDS F-TABLE 99 FOR AMP
kenv    linen   ampdb(p4), p3*.1,p3, p3*.1 
asig    oscil   kenv, cpspch(p5), ift ; OSCIL USES INDEXED VALUE...
        out     asig                ; ... TO SELECT F-TABLE 1-10
        endin       
