sr 		= 		44100
kr 		= 		4410
ksmps 	= 		10
nchnls 	= 		1

		instr  	107
a1   	oscil	p4, p5, p6
       	out  	a1
		endin

		instr   108
a1   	foscil 	p4, p5, p6, p7, p8, p9
		out     a1
		endin

		instr   109
a1   	buzz   	p4, p5, p6, p7
        out     a1
		endin

		instr   110					
a1 		pluck 	p4, p5, p6, p7, p8
		out 	a1
		endin

		instr 	111
a1 		grain 	p4, p5, p6, p7, p8, p9, p10, p11, p12
		out 	a1
		endin
		
		instr 	112					
a1 		loscil  p4, p5, p6
		out 	a1
		endin
		
