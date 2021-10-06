;ASYMETRIC SYMETRY BY JAHWAN KOO
;MAR 1, 2000 COMPORCH CLASS SOUND OBJECT PROJECT

;ENDLESS GLISANDO WITH COMB SET REPEAT ITSELF EVERY SINGLE SEC

;HSBOSCIL TAKES TONALITY AND BRIGHTNESS AS ARGUMENTS, RELATIVE TO A BASE 
;FREQUENCY (IBASFREQ). TONALITY IS A CYCLIC PARAMETER IN THE LOGARITHMIC OCTAVE, 
;BRIGHTNESS IS REALIZED BY MIXING MULTIPLE WEIGHTED OCTAVES. IT IS USEFUL WHEN 
;TONE SPACE IS UNDERSTOOD IN A CONCEPT OF POLAR COORDINATES.
;MAKING KTONE A LINE, AND KBRITE A CONSTANT, PRODUCES RISSET'S GLISSANDO.

sr			=		44100
kr			=		4410
ksmps		=		10
nchnls		=		2
  
ga1		init		0
ga2		init		0 


  
		instr		1
kenv	linseg		0, 4, 1, p3-5, 1, 1, 0							;INITIAL ENVELOPE
kdamp	linseg		0, 4, 1, p3-15, 1, 11, 0						;ADDITIONAL ENV

iamp	=			ampdb(p4)

;IOCTCNT - NUMBER OF OCTAVES USED FOR BRIGHTNESS BLENDING. MUST BE IN THE RANGE 2 TO 10. DEFAULT IS 3.
ioctfn1	=			p9
ioctfn2	=			p10

;KTONE - CYCLIC TONALITY PARAMETER RELATIVE TO IBASFREQ IN LOGARITHMIC OCTAVE, RANGE 0 TO 1, VALUES > 1 CAN BE USED, AND ARE INTERNALLY REDUCED TO FRAC(KTONE).
ktona	linseg		p5, p3-1, p6, 1, p6
ktonb	linseg		p7, p3-1, p8, 1, p8

asig	hsboscil	iamp*kenv, ktona, 0, 200, 1, ioctfn1, 10		;GLIDING UPWARD
asig1	hsboscil	iamp*kenv, ktonb, 0, 200, 1, ioctfn2, 10		;GLIDING DOWNWARD

;ENVELOPES FOR COMBS
kenv1	linseg		0, 20, 0, 10, 1, p3-30, 1
kenv2	linseg		0, 40, 0, 10, 1, p3-50, 1
kenv3	linseg		0, 55, 0, 10, 1, p3-65, 1
kenv4	linseg		0, 70, 0, 10, 1, p3-80, 1
kenv5	linseg		0, 80, 0, 10, 1, p3-90, 1
kenv6	linseg		0, 90, 0, 10, 1, p3-100, 1
kenv7	linseg		0, 95, 0, 10, 1, p3-105, 1
kenv8	linseg		0, 100, 0, 10, 1, p3-110, 1

;COMB SET FOE ASIG
ac1		comb		asig*kenv1, 5, 1/200
ac2		comb		asig*kenv2, 5, 1/303
ac3		comb		asig*kenv3, 5, 1/402
ac4		comb		asig*kenv4, 5, 1/516
ac5		comb		asig*kenv5, 5, 1/611
ac6		comb		asig*kenv6, 5, 1/708
ac7		comb		asig*kenv7, 5, 1/815
ac8		comb		asig*kenv8, 5, 1/924
acomb	=			(ac1+ac2+ac3+ac4+ac5+ac6+ac7+ac8)/10

;COMB SET FOR ASIG1
ac11	comb		asig1*kenv1, 5, 1/201
ac12	comb		asig1*kenv2, 5, 1/312
ac13	comb		asig1*kenv3, 5, 1/410
ac14	comb		asig1*kenv4, 5, 1/518
ac15	comb		asig1*kenv5, 5, 1/617
ac16	comb		asig1*kenv6, 5, 1/705
ac17	comb		asig1*kenv7, 5, 1/819
ac18	comb		asig1*kenv8, 5, 1/914
acomb1	=			(ac11+ac12+ac13+ac14+ac15+ac16+ac17+ac18)/10

;PANNING
kpan1	oscil		.5, 3/110, 3
kpan	=			.5+kpan1
kpan3	oscil		.5, 5.5/120, 3	
kpan2	=			.5+kpan3

aleft1	=			asig+(acomb1*kpan2+acomb*(1-kpan2))/2*kdamp
aright1	=			asig1+(acomb*kpan2+acomb1*(1-kpan2))/2*kdamp

;LO FQ CUT
kcf		expseg		20, 40, 20, p3-100, 500, 20, 20, 40, 20
ahp		butterhp	aleft1, kcf
ahp1	butterhp	aright1, kcf

		outs		ahp*kenv, ahp1*kenv
ga1		=			(ga1+ahp*kenv)*.7
ga2		=			(ga2+ahp1*kenv)*.7
		endin




			instr		100				;REV SOUNDS ONLY AT THE END
kenv		expseg		.001, 140, .001, 10, 1, p3-150, .001
arvb1		reverb2		ga1, 15, .7
arvb2		reverb2		ga2, 15, .7
			outs		arvb1*kenv, arvb2*kenv
ga1			=			0
ga2			=			0
			endin			


