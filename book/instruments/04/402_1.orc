
; ch4_1+2.orc


;	instr 1		
;k1	midictrl	1	;READ A MIDI CONTROLLER
;k2	=	k1/127	;Scale it ...
;k3	=	1/k2	;Invert it ...
;a1	oscil	20000, 440*k3, 1	;And use it;
;	out	a1
;	endin
	
;	instr 2		
;k1	midictrl	1	;READ THE MIDI CONTROLLER AGAIN
;a1	oscil	20000, 440*1/(k1/127), 2	;SCALE, INVERT, SQUARE AND USE IT IN ONE LINE!
;	out	a1
;	endin	
	


massign 1, 41
massign 2, 42

	instr 41		
k1	midictrl	1				;READ A MIDI CONTROLLER
k2	=	k1/127					;SCALE IT ...
k3	=	1/k2					;INVERT IT ...
a1	oscil	10000, 440*k3, 1	;AND USE IT
	out	a1
	endin
	
	instr 42		
k1	midictrl	1				;READ THE MIDI CONTROLLER AGAIN
a1	oscil	10000, 440*1/(k1/127), 2	;SCALE, INVERT, SQUARE AND USE IT IN ONE LINE!
	out	a1
	endin
