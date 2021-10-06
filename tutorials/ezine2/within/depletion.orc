;; depletion.orc
;; Grant Chu Covell
;; gcovell@c-bridge.com
;; 15 March 1999

sr 		= 44100
kr 		= 441
ksmps 	= 100
nchnls 	= 1

instr 1
	;; INITS
	idur			= p3
	iseed			= p4
	seed			iseed
	iorigtbllen		= 10
	iftable		= 21
	itablelen		= iorigtbllen
	iindex		= 0
	
	core:			
		
		;; SELECT VALUE
		iindex 		unirand ( itablelen ) 
		iindex 		= int ( iindex )	
		ielement		table iindex, iftable

		;; DEPLETE VALUE FROM TABLE
		ioldindex 		= iindex 			
		loop:	
			ival	 	table ioldindex + 1, iftable
			tableiw 	ival, ioldindex, iftable			
			ioldindex 	= ioldindex + 1
					
			if ioldindex < itablelen goto loop			
		itablelen 		= itablelen - 1

		;; FOR TESTING
		;; iidxval1		= 0
		;; testtable:
		;; 	ival1	 	table iidxval1, iftable
		;; 	print		iidxval1, ival1, iindex
		;; 	iidxval1	= iidxval1 + 1
		;; 	if iidxval1 < itablelen goto testtable	
		
		;; THE TIMOUT LOOP	
		timout		0, idur / iorigtbllen, do
			
	reinit core
	
	do:		
		kshape		linen	1, 0.1, idur / iorigtbllen, 0.1
		a1			oscili 5000, ielement, 1
			out a1 * kshape

	rireturn
		
endin