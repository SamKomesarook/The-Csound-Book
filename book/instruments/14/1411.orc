sr      =      	44100
kr    	=     	4410
ksmps  	=     	10
nchnls	=		1

        instr   1411
k1      linseg  .8, p3, .003
a1      fof     15000, 1, 300, 0, 0, .003, .9, k1, 2, 1, 2, p3
        out     a1
        endin
