;Function  1 uses the GEN10 subroutine to compute a sine wave
;Function  2 uses the GEN10 subroutine to compute the first sixteen partials of a sawtooth wave
;Function  8 uses the GEN05 subroutine to compute an exponential ADSR envelope function
;Function  9 uses the GEN05 subroutine to compute an exponential Attack for use with envlpx
;Function 10 uses the GEN05 subroutine to compute an exponential Attack for use with envlpx
;Function 11 uses the GEN01 subroutine to read in an AIF audio file "piano.aif"
;Function 12 uses the GEN01 subroutine to read in an AIF audio file "marimba.aif"
;Function 13 uses the GEN01 subroutine to read in an AIF audio file "brass.aif.aif"
;Function 14 uses the GEN01 subroutine to read in an AIF audio file "violin.aif"
;Function 15 uses the GEN05 subroutine to compute an exponential ADSR envelope function
;Function 16 uses the GEN07 subroutine to compute a linear triangle function for AM
;Function 17 uses the GEN07 subroutine to compute a square function for AM

f1  0 4096 10   1    
f2  0 4096 10   1  .5 .333 .25 .2 .166 .142 .125 .111 .1 .09 .083 .076 .071 .066 .062
f5  0 0    1   "hellorcb.aif" 	0 	4 	0 
f8  0 1024 5   .01  32  1   288   .8   512  .7   192  .01
f9  0 513  5    .001 128 .8  128 .6  256  1
f10 0 513  5   .01  64   1   64   .5   64  .99  64   .6  64  .98  64  .7  64 .97  32  .8  32 1
f11 0 0   -1   "piano.aif" 0 4 0
f12 0 0   -1   "marimba.aif" 0 4 0
f13 0 0   -1   "brass.aif" 0 4 0
f14 0 0   -1   "violin.aif" 0 4 0
f15 0 512  5    1   64  .7   136  .65    312  .001
f16	0 513	7	0	256	1	256		0	 
f17	0 513	7	0	10  1  246	1	10   0  246    0	
f18	0 513	7	0	10  1  502 0

;ins	strt	dur amp     frq     fn  atk	rel	atkfn
;==================================================
i 120		0		2	73	    6.09	2   .5	1	9
i 120		2		2	76	    6.08	2   .5	1	10
i 120		4		2	77	    6.06	2   .5	1	9
i 120		6		2	82	    6.04	2   .5	1	10
i 120		8		5	75	    5.09	2   .5	1	9
i 120		8.2		5	74	    6.04	2   .5	1	10
i 120		8.4		5	70	    7.01	2   .5	1	9
i 120		8.6		5	68	    8.09	2   .5	1	10
		
;ins	strt	dur amp	frq   envfun  wv1	wv1gn	wv2	wv2gn  
;===============================================
i 121 	14		.4	.1	8.09	15     11     1		12	1  
i 121 	14.3	.4	.2	8.07	15     11     1		12	.9
i 121 	14.6 	.4	.3	8.05	15     11     1		12	.8
i 121 	14.9	.4	.4	8.04	15     11     1		12	.7
i 121 	15.2	.4	.1	8.02	15     14     1		12	.6 
i 121 	15.5	.4	.2	8.04	15     14     1		12	1
i 121 	15.8	.4	.3	8.05	15     14     1		12	.9
i 121 	16.1	.4	.4	8.08	15     14     1		12	.8
i 121 	16.4	.4	.1	8.09	15     13     1		12	.7 
i 121 	16.7	.4	.2	8.04	15     13     1		12	.6
i 121 	17		.4	.3	8.00	15     13     1		12	1
i 121 	17.3	.4	.4	7.09	15     13     1		12	.9
i 121 	18		.7	.2	6.09	15     11     1		12	.8
i 121 	18.1	.6	.2	7.04	15     13     1		12	.7 
i 121 	18.2	.5	.2	8.00	15     14     1		12	.6 
i 121 	18.3	.4	.2	8.09	15     14     1		12	1

;ins	st 	dur amp	frq		fun	atk	rel	atkfun indx1 indx2	
;========================================================
i 122		20	 4	70	7.09	 1 .01	.2	10	 1 		30		
i 122		24.5 5	70	7.00	 1  1	.1	9	 10 	60	
i 122		30	10	70	5.09	 1  3	 2	10	 60 	3		
i 122		33	7	66	7.04	 1  .5	 1	9	 3 		100	

;ins	strt	dur amp	frq     fn	atk	rel	atkfun	modpth	modfrq	modfun
;============================================================================
i 123   	40      2	80	8.09	2	.01	.01  9		1		4		16
i 123   	43      2	80	8.07	2	.01	.01  9		1		4		17
i 123   	46      10	80	8.05	2	.01	.01  9		1		3		16
i 123   	48      8	80	8.00	2	.01	.01  9		1		4		18
i 123   	50      6	80	7.09	2	.01	.01  9		1		5		17
i 123   	52      4	80	6.05	2	.01	.01  9		1		2		18
		
;ins	strt	dur amp	frq     fn	atk	rel	atkfun	modp1	modp2	modfr1	modfr2	modfun
;==========================================================================================
i 124   	57      .6	70	8.09	1	.01	.01  10		10		1	    9.00	8.09		1
i 124   	58      .5	70	8.07	1	.01	.01  10		10		5    	5.00	7.07		1
i 124   	59      .4	70	7.05	1	.02	.02  10		10		8	    12.05	6.04		1
i 124   	60      .7	70	6.00	1	.03	.03  10		5		10	    4.00	14.00		1

;ins	strt	dur amp	frq     fn	atk	rel	atkfun	modp1	modp2	modfr1	modfr2	modfun
;==========================================================================================
i 125   	61      9.7	70	8.09	5	.01	.01  10		10		1	    1.09	10.09		1
i 125   	71      9.7	70	8.09	5	.01	.01  10		1 		10	    10.09	1.09		1

;ins	st	dur	amp	frq		atk	rel	lfodel	lfodpth	lfofrq	harm1	
;=================================================================
i 126     82	2.2	70	6.09	.1	 .3	1		 6		5		10
i 126     84	2.2	73	6.11	.2	 .4	.5		 5		6		9
i 126     86	2.2	77	7.01	.01	 .5	.8		 4		5		12
i 126     88	2.2	80	7.02	.3	 .3	1.6		 7		7		6
i 126     90	6.2	70	6.04	1.5	 .3	2		 6		4.7		8
i 126     90	6.2	73	6.08	 .9	 .4	1.5		 5		6		11
i 126     90	6.2	77	6.11	3.01 .5	.18		 4		5		5
i 126     90	6.2	80	7.04	2.4	 .3	3.6		 5.3	5.6		7

;ins	st		dur	amp	frq		atk	 rel lfodel	lfodpth	lfofrq	mdf1  mdf2 mdndx1	mdndx2
;=========================================================================================
i 127     97	    3.1	 	76	7.09	.01	 .3	  1.2	 6		5		7.10  7.09 10		4
i 127     100	    3.1	 	76	6.04	.1	 .4	  2.2	 4		7		6.04  8.03 	2		12
i 127     103	    3.1	 	76	5.09	.31	 .5	   3	 5		7		10.09  5.09 7		3
i 127     106	    14	 	70	5.09	2     5  	7	 10		36		4.02  12.03 40		20
i 127     106.06	13.94	70	6.09	1     5   	9	 14		56		4.03  12.02 30		10
i 127     106.1	13.9	70	7.09	.5    5   	11	 18		86		4.04  12.01 15		30
