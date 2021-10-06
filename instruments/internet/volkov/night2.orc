sr		=		44100
kr		=		4410
ksmps	=		10
nchnls	=		2

		instr 1
iamp		=		ampdb(p4)/2				
inote	=		cpspch(p5)
ibal		=		p8 
if1		=		0
if2		=		0	
ind1		=		35
ind2		=		30
k1		linseg	0,p3/2,iamp,p3/2, 0
a3		pluck	k1,inote*.997,ind1,if1,1		
a2		pluck	k1,inote*1.003,ind1,if1,1			
; a1		pluck	k1,inote,ind1,if1,1			
aplk1	=		a2+a3

k2 		linseg	0,p3*.66,iamp*1.2,p3/3,0
a6		pluck	k2,inote*.995,ind2,if2,1		
a5		pluck	k2,inote*1.005,ind2,if2,1			
; a4		pluck	k2,inote,ind2,if2,1			
aplk2	=		a5+a6
apluck	=		aplk1+aplk2
		outs		apluck*ibal,apluck*(1-ibal)
		endin

