sr      =      	44100
kr    	=     	4410
ksmps  	=     	10
nchnls	=		1

        instr   1413
k1      linseg  100, p3/4, 0, p3/4, 100, p3/2, 100  ;kband
k2      linseg  .003, p3/2, .003,p3/4, .01, p3/4, .003  ;kris
a1      fof     15000, 100, 440, 0, k1, k2, .02, .007, 3, 1, 2, p3  
        out     a1
        endin
