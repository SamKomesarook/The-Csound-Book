sr 		= 		44100
kr 		= 		4410
ksmps 	= 		10
nchnls 	= 		1

		instr  	101
a1   	oscil   10000, 440, 1
       	out      a1
		endin

		instr   102
a1   	foscil 	10000, 440, 1, 2, 3, 1 ;simple 2 operator fm opcode
		out     a1
		endin

		instr   103
a1   	buzz   	10000, 440, 10, 1  ;variable pulse train
        out     a1
		endin

		instr   104					
a1 		pluck 	10000, 440, 440, 2, 1   ;karplus-strong plucked string
		out 	a1
		endin

		instr 	105
a1 		grain 	5000, 440, 55, 5000, 10, .05, 1, 3, 1  ;asynchronous granular synthesis
		out 	a1
		endin
		
		instr 	106					
a1 		loscil  10000, 440, 4  ;sample-based looping oscillator
		out 	a1
		endin
		
