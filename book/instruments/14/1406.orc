sr      =      	44100
kr    	=     	4410
ksmps  	=     	10
nchnls	=		1

        instr   1406
a2      line    400, p3, 800
a1      fof     10000, 2, a2, 0, 0, .003, .5, .1, 3, 1, 2, p3, 0, 0
        out     a1
        endin
    
        
        instr   1407
a2      line    400, p3, 800
a1      fof     10000, 2, a2, 0, 0, .003, .5, .1, 3, 1, 2, p3, 0, 1
        out     a1
        endin

