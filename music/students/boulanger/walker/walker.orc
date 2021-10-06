
sr = 44100 ; sample rate
kr = 22050 ; control rate
ksmps = 2 ; sr/kr
nchnls = 1 ; mono

instr 1
idur 		=	 p3							; duration
iamp 		= 	 p4 						; amplitude
ifqc 		=	 p5							; frequency
itabl1	 	= 	 p6 						; waveform

kamp linen 1, idur/5, idur, idur-(idur/5) 	;	kr   linen     kamp, irise, idur, idec
aout oscil iamp, ifqc, itabl1   			;	an oscillator
out			aout*kamp						;	output the results to a monoo sound file
display    	kamp,idur    					;	displays envelope
				endin					
