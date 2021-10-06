sr 		= 		44100
kr 		= 		4410
ksmps 	= 		10
nchnls 	= 		1

		instr  	113
k1		linen	p4, p7, p3, p8
a1   	oscil	k1, p5, p6
       	out  	a1
		endin

		instr   114
k1      linen   p4, p7, p3, p8
k2      line    p11, p3, p12
a1   	foscil 	k1, p5, p9, p10, k2, p6
		out     a1
		endin

		instr   115
k1      linen   p4, p7, p3, p8
k2      expon  	p9, p3, p10	
a1   	buzz   	1, p5, k2+1, p6
        out     a1*k1
		endin

		instr   116
k1      linen   p4, p7, p3, p8
k2      linseg  p5, p3/2, p10, p3/2, p5	
a1 		pluck 	k1, k2, p5, p6, p9
		out 	a1
		endin

		instr 	117
k2      linseg  p5, p3/2, p9, p3/2, p5
k3      line    p10, p3, p11
k4      line    p12, p3, p13
k5      expon   p14, p3, p15
k6      expon	p16, p3, p17
a1 		grain 	p4, k2, k3, k4, k5, k6, 1, p6, 1
a2      linen   a1, p7, p3, p8
		out 	a2
		endin
				
		instr 	118					
k1      oscil   p4, 1/p3, p7
k2      expseg  p5, p3/3, p8, p3/3, p9, p3/3, p5
a1 		loscil  k1, k2, p6
		out 	a1
		endin
		
		instr   119
k1      oscil   p4, 1/p3 * p8, p7
k2      line    p11, p3, p12
a1   	foscil 	k1, p5, p9, p10, k2, p6
		out     a1
		endin

		
