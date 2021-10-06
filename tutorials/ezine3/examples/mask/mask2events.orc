 ; mask2events.orc
 ; © Dami‡n Keller. November 1998. 
 ; Using CMask in ecological modeling.
 
sr = 44100
kr = 4410
ksmps = 10
nchnls = 2

instr 1

iscale = 20000

	kenv	oscili p4 * iscale, 1/p3, 1

	ainleft	line	p5, sr/ftlen(p7), sr/ftlen(p7) + p5
	a1		tablei ainleft * sr, p7
	
	ainright	line	p6, sr/ftlen(p8), sr/ftlen(p8) + p6
	a2	 	tablei ainright * sr, p8
	
	outs		a1 * kenv, a2 * kenv	
endin	
