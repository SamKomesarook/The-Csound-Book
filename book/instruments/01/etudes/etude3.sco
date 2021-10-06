;Function 1 uses the GEN10 subroutine to compute a sine wave
;Function 2 uses the GEN10 subroutine to compute the first sixteen partials of a sawtooth wave
;Function 3 uses the GEN20 subroutine to compute a Hanning window for use as a grain envelope
;Function 4 uses the GEN01 subroutine to read in an AIF audio file
;Function 5 uses the GEN01 subroutine to read in annother AIF audio file
;Function 6 uses the GEN07 subroutine to compute a linear AR "GATE" envelope function
;Function 7 uses the GEN07 subroutine to compute a linear ADSR envelope function
;Function 8 uses the GEN05 subroutine to compute an exponential ADSR envelope function

f1  0 4096 10   1    
f2  0 4096 10   1  .5 .333 .25 .2 .166 .142 .125 .111 .1 .09 .083 .076 .071 .066 .062
f3  0 4097 20   2  1
f4  0 0    1   "sing.aif" 		0 	4 	0
f5  0 0    1   "hellorcb.aif" 	0 	4 	0 
f6  0 1024 7    0  	10   	1   1000   1   		14     	0
f7  0 1024 7	0	128		1	128		.6		512		.6		256 	0
f8  0 1024 5   .01  256   	1   192   	.5   	256  	.5   	64  	.01

;ins	strt	dur amp     frq     fn  atk		rel
;==================================================
i113		0		2	10000	440		1    1		1
i113		2.5		2	10000	220		2	 .01	1.99
i113		5		4	10000	110		2    3.9	.1
i113		10		10	10000	138.6	2    9     	1
i113		10		10 	10000	329.6	1    5     	5
i113		10		10	10000	440		1    1     	9

;ins	strt	dur amp     frq     fn	atk		rel    fc   fm  indx1	indx2
;============================================================================
i114		21		3	10000	440  	1   1		1		1	1	6		1   
i114 	24.5   	3 	10000	220  	1   .1		2.9  	1   .5	1		6
i114		28	    3	10000	110   	1   .1		.1   	1   3	10		1
i114 	32	   10	10000	130.8  	1   9  		1    	1   9	1		7
i114		32	   10	10000	329.6  	1   1  		9    	1   1	9		1
i114		32	   10 	10000	440    	1   5   	5    	.5  1	3		2

;ins	strt	dur amp     frq     fn  atk    rel    	#harm1	#harm2
;============================================================================
i115  	43		3	10000	440		1   1     	1 		30		2
i115  	47.5	3	10000	220  	1   2     	.1    	2    	30
i115  	51 		3	10000	110		1   .01  	.01   	20    	6
i115  	55		10	10000	130.8	1   .01   	.01    	1     	15
i115  	55		10	10000	311.1	1   8      	1     	33    	2
i115  	55		10	10000	440	    1   5     	.5    	3     	11

;ins	strt	dur amp     frq     fn	atk		rel		meth  	bend
;============================================================================
i116    66      3	30000	440     0	.6  	.1		1		329.6
i116   	69.5    3	30000  	220     0  	1   	.1		1		138.6
i116   	72      3	10000  	110     0   .05		1		1		220
i116   	76     10	30000  	138.6   0  	.2  	1		1		220			
i116   	76     10	30000  	329.6   0  	.3  	1		1		220		
i116   	76     10	30000  	440     0  	.4  	.1		1		220

;ins	strt	dur amp     frq     fn	atk		rel		bend	dens1	dens2	ampof1	ampof2	pchof1	pchof2	gdur1	gdur2
;=============================================================================================================================
i117     87      5	1000  	440  	3 	1		.1		430 	12000 	4000  	120 	50    	.01  	.05  	.1   	.01 
i117   	93     10	4000  	1760  	3	5		.1		60	    5		200   	500   	1000  	10  	20000   1   	.01

;ins	strt	dur 	amp		frq1	sample	envfn	frq2   frq3
;============================================================================
i118     104      2.31	30000  	440     4		7		430		450
i118     107      4.62	30000  	220     4		8		225		215
i118     112      2.28	10000  	442     5		6		444		438
i118    	112.3    2.28	10000  	438    	5		6		441		435
i118     112.8    2.1	10000  	450    	5		6		460		445
i118     115      4.62	10000  	219    	4		3		221		218
i118    	115      4.62	10000  	440    	4		7		438		442
i118    	115.5    2.31	10000  	554.4  	4		8		550		560		
i118    	116      2.31	10000  	659.2  	4		7		640		666		
i118    	118    	 3		20000  	440    	5		6		439		441

;ins	strt	dur amp     frq     fn	envfn	loopfrq fc  fm  indx1	indx2	
;=====================================================================================
i119		122		3	10000	440  	1   8		30		1	1	10		1		   
i119 	126   	3 	10000	220  	1   7		15  	1   .5	1		10
i119		130	    3	10000	110   	1   2		12   	1   3	20		1
i119 	134	   20	5000	110.9  	1   8  		100    	1   1	3		20
i119		136	   12	5000	329.6  	1   7  		94    	1   1	15		6
i119		138	   12 	5000	659.2   1   2   	70    	1   .5	3		14
i119		140	   12 	5000	329.6   1   7   	67    	4   1	10		2
i119		142	   12 	5000	130.8   1   8   	56    	1   1	1		11
i119		144	   10 	5000	440    	1   2   	41    	1   2	20		3
