;Text File Funk
;By Matt Moldover  AKA  Dead Ace
;(617)236-0321   deadace@deadace.com     http://www.deadace.com
;INTERESTING THINGS: a lot of the instruments use a little randomness on amplitude or cutoff
;frequency to add realism.  Several of the beats use instrument 103 which randomly chooses to
;play a kick drum, snare drum or nothing.  I use the index counter ($dex) on many parameter fields
;to create dynamic effects lasting 8 bars even though the repeated sections are usually only 2 bars.  

;f tables -----------------------------------------------------------------
f 1  0 4096 10	1    ;sine
f 2  0 2048 7	0	34	1	990	1	34	0	990	0	;square
f3  0 4097 20   1  1  							  ;Hamming

;instrument exaples -------------------------------------------------------
;Gverb	strt	dur	time	HFRoll(0-1) 
;i 900	0	10	1	.2
;Gcomb	strt	dur	time	LoopT(beats)
;i 901		0	6	7	.5
;HHat		strt	dur	amp	cutoff(10K)	length(0-1)(.2)	
;i 	100	0 	.25 	10000 10000       .1	
;Kick		strt	dur	amp	freq(60)
;i 101 	0	1	10000	60
;Snare	strt	dur	amp	freq(900)
;i 102	.5	1	10000	900
;rndKS	strt	dur	amp	freq(N/A defaults to 60 and 900)
;i 103 	0	.5	10000	600
;Bass		strt	dur	amp	pch1	pch2	coff1	coff2	resmix(.001-1)	
;i 200	0	1	10000	5.01  5.01	1000	1	.001
;String	strt	dur	amp	pch	fmamp	fmratio
;i 201	0	1	10000	5.01	10	1
;FM		start	dur	amp	frqbas	funct	fc	fmodend	indxmax	sinfreqstrt
;i69		0	8	10000	40		1	2	10		3		.1
;grainfilt		strt	  dur	   atk     rel    amp   ampoff	frq  maxfrqoff	dens1 dens2  gdur  gduroff	funct   randPdepth   lfodpth  lfoitts  lfodurmod   lfofiltmod   lpfmix
;i 420        	0	   8		.5 	.3	80  	  10		8.04  3.01		10    1000    .005  .01   	  1         10          0        0        0            0          0 1
;gverb	strt	dur	time	HFRoll(0-1) 
;i 900		0	14	1	.1
;Gcomb	strt	dur	time	LoopT(beats)
;i 901	0	6	7	.5

i 300 0 .001
s


;INTRO=================================================================
;a 0 0 14
;gverb	strt	dur	time	HFRoll(0-1) 
i 900		0	14	1	.1
;FM		start	dur	amp	frqbas	funct	fc	fmodend	indxmax	sinfreqstrt
i69		0	14	5000	40		1	2	2		3		.1
i69		2	12	<	<		.	.	~		<		.
i69		4	10	.	.		.	.	.		.		.
i69		6	8	.	.		.	.	.		.		.
i69		8	6	3000	20		.	.	7		10		.
;grainfilt		strt	  dur	   atk     rel    amp   ampoff	frq  maxfrqoff	dens1 dens2  gdur  gduroff	funct   randPdepth   lfodpth  lfoitts  lfodurmod   lfofiltmod   lpfmix
i 420        	9	   3		2 	.5	40  	  10		10.04  2.3      	4     600    .003  .0009          1         2          2         60          .0002          30       .5 1
i 420        	11	   3		1 	1	20  	  10		10.04  2.3      	4     600    .003  .0009          1         2          2         60          .0002          30       .5 1
i 420        	10	   4		.2 	.1	60  	  10		2.04   7.01		10    100    .005  .01   	  1         10          2        .        .001            3          .5 1
;HHat		strt	dur	amp	cutoff(10K)	length(0-1)(.2)	
i100		2	.25	100	300		1
i100		+	.	~	<		<
i100		.	.	.	.		.
i100		.	.	.	.		.
i100		.	.	.	.		.
i100		.	.	.	.		.
i100		.	.	.	.		.
i100		.	.	.	.		.
i100		.	.	.	.		.
i100		.	.	.	.		.
i100		.	.	.	.		.
i100		.	.	.	.		.
i100		.	.	.	.		.
i100		.	.	.	.		.
i100		.	.	.	.		.
i100		.	.	.	.		.
i100		.	.	.	.		.
i100		.	.	.	.		.
i100		.	.	.	.		.
i100		.	.	.	.		.
i100		.	.	.	.		.
i100		.	.	.	.		.
i100		.	.	.	.		.
i100		.	.	.	.		.
i100		.	.	.	.		.
i100		.	.	.	.		.
i100		.	.	.	.		.
i100		.	.	.	.		.
i100		.	.	.	.		.
i100		.	.	.	.		.
i100		.	.	.	.		.
i100		.	.	.	.		.
i100		.	.	.	.		.
i100		.	.	.	.		.
i100		.	.	.	.		.
i100		.	.	.	.		.
i100		.	.	.	.		.
i100		.	.	.	.		.
i100		.	.	.	.		.
i100		.	.	.	.		.
i100		.	.	.	.		.
i100		.	.	.	.		.
i100		.	.	.	.		.
i100		.	.	.	.		.
i100		.	.	.	.		.
i100		.	.	.	.		.
i100		.	.	.	.		.
i100		.	.	5000	4000		2
s


;4 BAR HH GRAIN GROOVE===================================================
r4 dex
;a 0 0 16
;gverb	strt	dur	time	HFRoll(0-1) 
i 900		0	4	1	.1
;grainfilt		strt	  dur	   atk     rel    amp   ampoff	frq  maxfrqoff	dens1 dens2  gdur  gduroff	funct   randPdepth   lfodpth  lfoitts  lfodurmod   lfofiltmod   lpfmix
i 420        	0	   4		.2 	.3	[80/[$dex*.2]]  	  10		2.04  [4.01*[[5-$dex]*.06]]		10    100    .005  .01   	  1         10          2        $dex        .001            3          .5 1
i 420        	0	   .5		.01 	.01	30  	  10		5.04  1.01		100    1000    .05  .01   	  1         10          2        $dex        .001            3          [$dex/6]  1
;HHat		strt	dur	amp	cutoff(10K)	length(0-1)(.2)	
i	100	0	.25	5000	[3000+[$dex*1000]]	[2/[$dex*2]]
i 	100	+	.	3000	<		<	
i 	100	.	.	.	.		.	
i 	100	.	.	.	.		.	
i 	100	.	.	.	.		.	
i 	100	.	.	.	.		.	
i 	100	.	.	.	.		.	
i 	100	.	.	.	.		.	
i 	100	.	.	.	.		.	
i 	100	.	.	.	.		.	
i 	100	.	.	.	.		.	
i 	100	.	.	.	.		.	
i 	100	.	.125	.	.		.	
i	100	3.125 .25	.	.		.
i 	100	+	.	.	.		.	
i 	100	.	.	.	.		.	
i 	100	3.875	.125	.	[4000+$dex*1000]		[2/[[$dex+1]*2]]	
;pshhhh on 1
;String	strt	dur	amp	pch	fmamp	fmratio
i 201	0	4	[[[4-$dex]^8]/18]	1.01	500	1000
;FM   start  dur  amp    frqbase    funct    fc   fmodend  indxmax  sinfreqstrt
i69 	     3  1   [$dex^6]  20     	1		1     4   	30   	100   
;bendup
;Bass		strt	dur	amp		pch1	pch2	coff1	coff2	resmix(.001-1)	
i 200		1.5	2.5	[[[$dex-1]^9]/9] 3.01  10.01	1000	4000	.001
s


;4 BAR GROOVE KICK ADDED=============================================
r4 dex2
;a 0 0 16
;gverb	strt	dur	time	HFRoll(0-1) 
i 900		0	4	1	.1
;HHat		strt	dur	amp	cutoff(10K)	length(0-1)(.2)	
i	100	0	.25	3500	8000		.2
i 	100	+	.	2500	<		<	
i 	100	.	.	.	.		.	
i 	100	.	.	.	.		.	
i 	100	.	.	.	.		.	
i 	100	.	.	.	.		.	
i 	100	.	.	.	.		.	
i 	100	.	.	.	.		.	
i 	100	.	.	.	[10000+[$dex2*1200]]		.	
i 	100	.	.	.	<		.	
i 	100	.	.	.	.		.	
i 	100	.	.	.	.		.	
i 	100	.	.125	.	.		.	
i	100	3.125 .25	.	.		.
i 	100	+	.	.	.		.	
i 	100	.	.	.	.		.	
i 	100	3.875	.125	.	7000		.2	
;Kick		strt	dur	amp	freq(60)
i 101 	0	.25	[[[$dex2+1]*[$dex2+1]]*70]	[[[6-$dex2]^2]*70]
i 101       .875	.	<			<
i 101		1.25	.	.			.	
i 101		2	.	.			.
i 101		2.75	.	.			.
i 101		2.875	.	.			.
i 101		3.25	.75	[[[$dex2+2]*[$dex2+2]]*80]	[[[5-$dex2]^2]*70]
;FM   start  dur  amp    frqbase    funct    fc   fmodend  indxmax  sinfreqstrt
i69 	     3  1   [$dex2^6]  20     	1		1     4   	45   	100   
;grainfilt		strt	  dur	   atk     rel    amp   ampoff	frq  maxfrqoff	dens1 dens2  gdur  gduroff	funct   randPdepth   lfodpth  lfoitts  lfodurmod   lfofiltmod   lpfmix
i 420        	0	   4		.2 	.3	[50/[$dex2*.3]]  	  10		2.04  [4.01*[[5-$dex2]*.04]]		10    100    .005  .01   	  1         10          2        $dex2        .001            3          .5 .8
i 420        	0	   .5		.01 	.01	20  	  10		5.04  1.01		100    1000    .05  .01   	  1         10          2        4        .001            3          .66 .8
s


;4 BAR SNARE ADDED================================================================
r4 dex
;a 0 0 16
;gverb	strt	dur	time	HFRoll(0-1) 
i 900		0	4	1	.1
;HHat		strt	dur	amp	cutoff(10K)	length(0-1)(.2)	
i	100	0	.25	3000	8000		.18
i 	100	+	.	2500	<		<	
i 	100	.	.	.	.		.	
i 	100	.	.	.	.		.	
i 	100	.	.	.	.		.	
i 	100	.	.	.	.		.	
i 	100	.	.	.	.		.	
i 	100	.	.	.	.		.	

i 	100	.	.	.	[10000+[$dex*1000]]		.	
i 	100	.	.	.	<		.	
i 	100	.	.	.	.		.	
i 	100	.	.	.	.		.	
i 	100	.	.125	.	.		.	
i	100	3.125 .25	.	.		.
i 	100	+	.	.	.		.	
i 	100	.	.	.	.		.	
i 	100	3.875	.125	3000	8000		.2	
;Kick		strt	dur	amp	freq(60)
i 101 	0	.25	10000	60
i 101       .875	.	9000	.
i 101		1.25	.	9000	.	
i 101		2	.	10000	.
i 101		2.75	.	9000	.
i 101		2.875	.	10000	.
i 101		3.25	.	9000	.	
i 101		3.875	.125	[$dex^6]	.	
;Snare	strt	dur	amp	freq(900)
i 102		.5	.5	[[$dex*300]+7000]	[400*[[[6-$dex]^2]/3]]
i 102		3.125	.25	[[[$dex-1]^8]*1.02]	400
i 102		+	.25	[[[$dex-1]^8]*1.04]	<
i 102		+	.125	[[[$dex-1]^8]*.98]	.
i 102		+	.125	[[[$dex-1]^8]*1]		.
i 102		+	.125	[[[$dex-1]^8]*1.01]	850
;Bass		strt	dur	amp	pch1	pch2	coff1	coff2	resmix(.001-1)	
i 200		0	4	3000+[$dex*500]	5.01  4.01	3000	[8000+[$dex*2]]	[1*[[5-$dex]/4]]
;grainfilt		strt	  dur	   atk     rel    amp   ampoff	frq  maxfrqoff	dens1 dens2  gdur  gduroff	funct   randPdepth   lfodpth  lfoitts  lfodurmod   lfofiltmod   lpfmix ampatt
i 420        	0	   4		.4 	.5	[50/[$dex*.5]]  	  10		2.04  [4.09*[[5-$dex]*.10]]		10    100    .005  .01   	  1         10          2        $dex        .001            3          .5 .5
i 420        	0	   .5		.4 	.01	20  	  10		5.04  1.01		100    1000    .05  .01   	  1         10          2        4        .001            3          .66  .5
;FM   start  dur  amp    frqbase    funct    fc   fmodend  indxmax  sinfreqstrt
i69 	     3  1   [[$dex^6]-2000]  20     	1		1     4   	60   	100   
;bendup
;Bass		strt	dur	amp		pch1	pch2	coff1	coff2	resmix(.001-1)	
i 200		1.5	2.5	[[[$dex-1]^9]/9] 3.01  10.01	1000	4000	.001
;pshhhh on 1
;String	strt	dur	amp	pch	fmamp	fmratio
i 201	0	3.5	[[[4-$dex]^8]/14]	1.01	2	1000
;i201		0	4	[[[4-$dex]^7]/2]	4.01	2	10
s


;FULL DRUM GROOVE===============================================================
r4 dex
;a 0 0 16

;gverb	strt	dur	time	HFRoll(0-1) 
i 900		0	4	1	.1

;HHat		strt	dur	amp	cutoff(10K)	length(0-1)(.2)	
i	100	0	.125	2800	8000		.1
i	100	+	.	2600	<		<
i 	100	.	.	<	.		.	
i 	100	.	.	.	.		.	
i 	100	.	.25	.	.		.18	
i 	100	.	.	.	.		.	
i 	100	.	.	.	.		.	
i 	100	.	.	.	.		.	
i 	100	.	.	.	.		.	
i 	100	.	.	.	.		.	

i 	100	.	.	.	[10000+[$dex*1000]]		.	
i 	100	.	.	.	<		.	
i 	100	.	.	.	.		.	
i 	100	.	.	.	.		.	
i 	100	.	.125	.	.		.	
i	100	3.125 .25	.	.		.
i 	100	+	.	.	.		.	
i 	100	.	.	.	.		.	
i 	100	3.875	.125	3000	8000		.2	


;Kick		strt	dur	amp	freq(60)
i 101 	0	.25	10000	60
i 101       .875	.	8000	<
i 101		1.25	.	9000	.	
i 101		2	.	12500	63
i 101		2.75	.	9000	<
i 101		2.875	.	11000	.
i 101		3.25	.	10000	.	
i 101		3.875	.125	[$dex^6]	59	

;Snare	strt	dur	amp	freq(900)
i 102		.5	1	6000	850
i 102		+	.	.	800
i 102		+	.	.	875
i 102		+	.5	.	779


i 102		3.125	.25	[[[$dex-1]^8]*0.72]	300
i 102		+	.25	[[[$dex-1]^8]*0.84]	<
i 102		+	.125	[[[$dex-1]^8]*.88]	.
i 102		+	.125	[[[$dex-1]^8]*1]		.
i 102		+	.125	[[[$dex-1]^8]*1.01]	800

;Bass		strt	dur	amp	pch1	pch2	coff1	coff2	resmix(.001-1)	
i 200		0	4	1000+[$dex*500]	5.01  4.01	3000	[8000+[$dex*2]]	[1*[[5-$dex]/4]]

;String	strt	dur	amp		pch	fmamp	fmratio
i 201		0	4	[[[4-$dex]^8]/8]	5.01	0	0

;grainfilt		strt	  dur	   atk     rel    amp   ampoff	frq  maxfrqoff	dens1 dens2  gdur  gduroff	funct   randPdepth   lfodpth  lfoitts  lfodurmod   lfofiltmod   lpfmix ampatt
;i 420        	0	   4		.4 	.5	[50/[$dex*.5]]  	  10		2.04  [4.09*[[5-$dex]*.10]]		10    100    .005  .01   	  1         10          2        $dex        .001            3          .5 .5
i 420        	0	   .5		.4 	.01	20  	  10		5.04  1.01		100    1000    .05  .01   	  1         10          2        4        .001            3          .66  .5

;FM   start	dur	amp	frqbase	funct	fc	fmodend	indxmax	sinfreqstrt
i69	3	1	[[$dex^6]-2000]  	20		1	1	4		60		100   

;bendup
;Bass		strt	dur	amp		pch1	pch2	coff1	coff2	resmix(.001-1)	
i 200		2	2	[70*[$dex^3]]	[[$dex+4]+.01]  6.01	8000	[$dex*2000]	.001
;[[[$dex-1]^9]/9] 
s


;DRUM WITH BASS GROOVE===============================================================
r3 dex
;a 0 0 12

;gverb	strt	dur	time	HFRoll(0-1) 
i 900		0	4	1	.1

;HHat		strt	dur	amp	cutoff(10K)	length(0-1)(.2)	
i	100	0	.125	3000	8000		.1
i	100	+	.	2300	<		<
i 	100	.	.	<	.		.	
i 	100	.	.	.	.		.	
i 	100	.	.25	.	.		.18	
i 	100	.	.	.	.		.	
i 	100	.	.	.	.		.	
i 	100	.	.	.	.		.	
i 	100	.	.	2500	.		.	
i 	100	.	.	<	.		.	

i 	100	.	.	.	[10000+[$dex*1000]]		.	
i 	100	.	.	.	<		.	
i 	100	.	.	.	.		.	
i 	100	.	.	.	.		.	
i 	100	.	.125	.	.		.	
i	100	3.125 .25	.	.		.
i 	100	+	.	.	.		.	
i 	100	.	.	.	.		.	
i 	100	3.875	.125	2600	8000		.2	

;Kick		strt	dur	amp	freq(60)
i 101 	0	.25	12000	60
i 101       .875	.	10000	<
i 101		1.25	.	9000	.	
i 101		2	.	15000	63
i 101		2.75	.	8000	<
i 101		2.875	.	11000	.
i 101		3.25	.	10000	.	
i 101		3.875	.125	[$dex^6]	59	

;Snare	strt	dur	amp	freq(900)
i 102		.5	1	5000	850
i 102		+	.	.	800
i 102		+	.	.	875
i 102		+	.5	.	779

i 102		3.125	.25	[[[$dex-1]^8]*1.02]	300
i 102		+	.25	[[[$dex-1]^8]*1.04]	<
i 102		+	.125	[[[$dex-1]^8]*.98]	.
i 102		+	.125	[[[$dex-1]^8]*1]		.
i 102		+	.125	[[[$dex-1]^8]*1.01]	800

;Bass		strt	dur	amp	pch1	pch2	coff1	coff2	resmix(.001-1)	
;i 200	0	1	10000	5.01  5.01	1000	1	.001

;Bass		strt	dur	amp	pch1	pch2	coff1	coff2	resmix(.001-1)
i 200 	0	.8	11000	6.01	6.01	10000	5000	[.1*[$dex/4]]
i 200       .875	.25	.	6.04	0.04	<	<	<
i 200		1.25	.75	.	6.06	6.01	13000	500	.
i 200		2	.75	.	6.01	6.01	15000	500	.
i 200		2.75	.125	.	6.06	6.08	8000	1000	[.6*[$dex/4]]
i 200		2.875	.375	.	6.04	6.04	1000	2000	<
i 200		3.25	.625	.	5.11	5.11	<	<	.
i 200		3.875	.125	.	5.11	6.01	800	6000	[.4*[$dex/4]]

;String	strt	dur	amp		pch	fmamp	fmratio
i 201		0	4	[[[4-$dex]^8]/14]	5.01	0	0

;grainfilt		strt	  dur	   atk     rel    amp   ampoff	frq  maxfrqoff	dens1 dens2  gdur  gduroff	funct   randPdepth   lfodpth  lfoitts  lfodurmod   lfofiltmod   lpfmix ampatt
;i 420        	0	   4		.4 	.5	[50/[$dex*.5]]  	  10		2.04  [4.09*[[5-$dex]*.10]]		10    100    .005  .01   	  1         10          2        $dex        .001            3          .5 .5
i 420        	0	   .5		.4 	.01	20  	  10		5.04  1.01		100    1000    .05  .01   	  1         10          2        4        .001            3          .66  .5
;FM   start	dur	amp	frqbase	funct	fc	fmodend	indxmax	sinfreqstrt
i69	3	1	[[$dex^6]-2000]  	20		1	1	4		60		100   
s


;rushes==================================================================
r32 dex
;a 0 0 2
;gverb	strt	dur	time	HFRoll(0-1) 
i 900		0	.0625	1	.1
;Snare	strt	dur	amp	freq(900)
i 102		0	.0625	[1000+[$dex*120]]   [500+[[33-$dex]*30]]
;Bass		strt	dur	amp	pch1	pch2	coff1	coff2	resmix(.001-1)
i 200 	0	.0625	3000	[5.01+[$dex*.006]]	7.01	2000	[5000+[$dex*200]]	[$dex/30]
s


r16 dex
;a 0 0 1
;gverb	strt	dur	time	HFRoll(0-1) 
i 900		0	.0625	1	.1
;Snare	strt	dur	amp	freq(900)
i 102		0	.0625	[8000-[$dex*280]]   [500+[$dex*100]]
;Bass		strt	dur	amp	pch1	pch2	coff1	coff2	resmix(.001-1)
i 200 	0	.0625	3000	[7.01+[$dex*.012]]	7.01	5000	[5000+[$dex*300]]	[$dex/25]
s


r16 dex
;a 0 0 1
;gverb	strt	dur	time	HFRoll(0-1) 
i 900		0	.0625	1	.1
;Snare	strt	dur	amp	freq(900)
i 102		0	.0625	[3000+[$dex*150]]   [2300-[$dex*100]]
;Bass		strt	dur	amp	pch1	pch2	coff1	coff2	resmix(.001-1)
i 200 	0	.0625	3000	[9.01+[$dex*.012]]	7.01	8000	[5000+[$dex*300]]	[$dex/20]
s


;DRUM WITH BASS GROOVE  RANDOM DRUM FILLS===============================================================
r4 dex
;a 0 0 16

;gverb	strt	dur	time	HFRoll(0-1) 
i 900		0	4	1	.1

;HHat		strt	dur	amp	cutoff(10K)	length(0-1)(.2)	
i	100	0	.125	2400	7000		.1
i	100	+	.	2300	<		<
i 	100	.	.	<	.		.	
i 	100	.	.	.	.		.	
i 	100	.	.25	.	.		.18	
i 	100	.	.	.	.		.	
i 	100	.	.	.	.		.	
i 	100	.	.	.	.		.	
i 	100	.	.	2500	.		.	
i 	100	.	.	<	.		.	

i 	100	.	.	.	[10000+[$dex*1000]]		.	
i 	100	.	.	.	<		.	
i 	100	.	.	.	.		.	
i 	100	.	.	.	.		.	
i 	100	.	.125	.	.		.	
i	100	3.125 .25	.	.		.
i 	100	+	.	.	.		.	
i 	100	.	.	.	.		.	
i 	100	3.875	.125	2600	8000		.2	

;Kick		strt	dur	amp	freq(60)
i 101 	0	.25	8000	60
i 101       .875	.	8000	<
i 101		1.25	.	8000	.	
i 101		2	.	10000	63
i 101		2.75	.	8000	<
i 101		2.875	.	9000	.

;Snare	strt	dur	amp	freq(900)
i 102		.5	1	3000	850
i 102		+	.	.	800
i 102		+	.	.	875

i 102		3.125	.25	[[[[$dex-1]^8]*1.02]*.7]	350
i 102		+	.25	[[[[$dex-1]^8]*1.04]*.7]	<
i 102		+	.125	[[[[$dex-1]^8]*.98]*.7]	.
i 102		+	.125	[[[[$dex-1]^8]*1]*.7]		.
i 102		+	.125	[[[[$dex-1]^8]*1.01]*.7]	800

;rndKS	strt	dur	amp	freq(N/A defaults to 60 and 900)
i 103 	3	.125	6000	600 $dex
i 103 	+	.	<	.	<
i 103 	.	.	.	.	.
i 103 	.	.	.	.	.
i 103 	.	.	.	.	.
i 103 	.	.	.	.	.
i 103 	.	.	.	.	.
i 103 	.	.	6800	.	5

;Bass		strt	dur	amp	pch1	pch2	coff1	coff2	resmix(.001-1)
i 200 	0	.8	11000	6.01	6.01	10000	5000	[.1*[$dex/4]]
i 200       .875	.25	.	6.04	0.04	<	<	<
i 200		1.25	.75	.	6.06	6.01	13000	500	.
i 200		2	.75	.	6.01	6.01	15000	500	.
i 200		2.75	.125	.	6.06	6.08	8000	1000	[.6*[$dex/4]]
i 200		2.875	.375	.	6.04	6.04	1000	2000	<
i 200		3.25	.625	.	5.11	5.11	<	<	.
i 200		3.875	.125	.	5.11	6.01	800	6000	[.4*[$dex/4]]

;String	strt	dur	amp		pch	fmamp	fmratio
i 201		0	4	[[[4-$dex]^8]/14]	5.01	0	0

;String	strt	dur	amp	pch	fmamp	fmratio
i 201		0	4	[[[4-$dex]^8]/18]	1.01	50	10000

;grainfilt		strt	  dur	   atk     rel    amp   ampoff	frq  maxfrqoff	dens1 dens2  gdur  gduroff	funct   randPdepth   lfodpth  lfoitts  lfodurmod   lfofiltmod   lpfmix ampatt
;i 420        	0	   .5		.4 	.01	20  	  10		5.04  1.01		100    1000    .05  .01   	  1         10          2        4        .001            3          .66  .5
;FM   start	dur	amp	frqbase	funct	fc	fmodend	indxmax	sinfreqstrt
i69	3	1	[[$dex^6]-2000]  	20	1	1		4		60		100   

i 420        	0	   4		1 	1	30  	  10		10.04  2.3      	4     600    .003  .0009          1         2          2         60          .0002          30       .5  .3
s


;DRUM WITH BASS GROOVE  RANDOM DRUM FILLS===============================================================
r3 dex
;a 0 0 16

;gverb	strt	dur	time	HFRoll(0-1) 
i 900		0	4	1	.1

;HHat		strt	dur	amp	cutoff(10K)	length(0-1)(.2)	
i	100	0	.125	2400	8000		.1
i	100	+	.	2300	<		<
i 	100	.	.	<	.		.	
i 	100	.	.	.	.		.	
i 	100	.	.25	.	.		.18	
i 	100	.	.	.	.		.	
i 	100	.	.	.	.		.	
i 	100	.	.	.	.		.	
i 	100	.	.	2500	.		.	
i 	100	.	.	<	.		.	

i 	100	.	.	.	[10000+[$dex*1000]]		.	
i 	100	.	.	.	<		.	
i 	100	.	.	.	.		.	
i 	100	.	.	.	.		.	
i 	100	.	.125	.	.		.	
i	100	3.125 .25	.	.		.
i 	100	+	.	.	.		.	
i 	100	.	.	.	.		.	
i 	100	3.875	.125	2600	8000		.2	

;Kick		strt	dur	amp	freq(60)
i 101 	0	.25	8000	60
i 101       .875	.	8000	<
i 101		2	.	12000	63
i 101		2.75	.	8000	<
i 101		2.875	.	9000	.

i 101		3.875	.125	[[$dex^6]*.7]	59	

;Snare	strt	dur	amp	freq(900)
i 102		.5	1	4300	850
i 102		2.5	.	.	800

i 102		3.125	.25	[[[[$dex-1]^8]*1.02]*.7]	350
i 102		+	.25	[[[[$dex-1]^8]*1.04]*.7]	<
i 102		+	.125	[[[[$dex-1]^8]*.98]*.7]		.
i 102		+	.125	[[[[$dex-1]^8]*1]*.7]		.
i 102		+	.125	[[[[$dex-1]^8]*1.01]*.7]	800

;rndKS	strt	dur	amp	freq(N/A defaults to 60 and 900)
i 103 	1	.125	6000	600 $dex
i 103 	+	.	<	.	<
i 103 	.	.	.	.	.
i 103 	.	.	.	.	.
i 103 	.	.	.	.	.
i 103 	.	.	.	.	.
i 103 	.	.	.	.	.
i 103 	.	.	7500	.	5

;rndKS	strt	dur	amp	freq(N/A defaults to 60 and 900)
i 103 	3	.125	6000	600 $dex
i 103 	+	.	<	.	<
i 103 	.	.	.	.	.
i 103 	.	.	.	.	.
i 103 	.	.	.	.	.
i 103 	.	.	.	.	.
i 103 	.	.	.	.	.
i 103 	.	.	7500	.	5

;Bass		strt	dur	amp	pch1	pch2	coff1	coff2	resmix(.001-1)	
;i 200	0	1	10000	5.01  5.01	1000	1	.001

;Bass		strt	dur	amp	pch1	pch2	coff1	coff2	resmix(.001-1)
i 200 	2	2	7000	6.01	[6.0+[[[$dex+1]^2]*.01]]	11000	5000	[.1*[$dex/4]]

;String	strt	dur	amp		pch	fmamp	fmratio
i 201		0	2.5	[1000+$dex*200]	3.01		[3*$dex]	[$dex]

;grainfilt		strt	  dur	   atk     rel    amp   ampoff	frq  maxfrqoff	dens1 dens2  gdur  gduroff	funct   randPdepth   lfodpth  lfoitts  lfodurmod   lfofiltmod   lpfmix ampatt
;i 420        	0	   .5		.4 	.01	20  	  10		5.04  1.01		100    1000    .05  .01   	  1         10          2        4        .001            3          .66  .5
;FM   start	dur	amp	frqbase	funct	fc	fmodend	indxmax	sinfreqstrt
i69	3	1	[[$dex^6]-2000]  	20		1	1	4		60		100   

i 420        	0	   4		1 	1	30  	  10		10.04  2.3      	4     600    .003  .0009          1         2          2         60          .0002          30       .5  .3
s


;RANDOM RUSH===============================================================
r64 dex
;a 0 0 1
;gverb	strt	dur	time	HFRoll(0-1) 
i 900		0	.0625	1	.1
;rndKS	strt	dur	amp	freq(N/A defaults to 60 and 900)
i 103 	0	.0625	[6000-[$dex*30]] 600 $dex
;String	strt	dur	amp		pch	fmamp	fmratio
i 201		0	.04	[2000-[$dex*10]]	3.01		[$dex/10]	1
s


;INTERLUDE=================================================================
;a 0 0 16

;gverb	strt	dur	time	HFRoll(0-1) 
i 900		0	16	1	.1

;FM   start  dur  amp    frqbase    funct    fc   fmodend  indxmax  sinfreqstrt
i69 	     0  16   2000  20     	1		1     8   	500   	100000   
i69	0	5	1500	100		1		3	1	200		500
i69	4	.	<	~		.		.	<	.		<
i69	8	.	.	.		.		.	.	.		.
i69	12	4	3000	1000		.		.	7	.		1

;HHat		strt	dur	amp	cutoff(10K)	length(0-1)(.2)	
i	100	0	.25	4000	5000		.2
i 	100	+	.	4000	<		<	
i 	100	.	.	.	.		.	
i 	100	.	.	.	.		.	
i 	100	.	.	.	.		.	
i 	100	.	.	.	.		.	
i 	100	.	.	.	.		.	
i 	100	.	.	.	.		.	
i 	100	.	.	.	7000		.	
i 	100	.	.	.	<		.	
i 	100	.	.	.	.		.	
i 	100	.	.	.	.		.	
i 	100	.	.125	.	.		.	
i	100	3.125 .25	.	.		.
i 	100	+	.	.	.		.	
i 	100	.	.	.	.		.	
i 	100	3.875	.125	.	6000		.2	

;HHat		strt	dur	amp	cutoff(10K)	length(0-1)(.2)	
i	100	4	.25	4000	6000		.2
i 	100	+	.	4000	<		<	
i 	100	.	.	<	.		.	
i 	100	.	.	.	.		.	
i 	100	.	.	.	.		.	
i 	100	.	.	.	.		.	
i 	100	.	.	.	.		.	
i 	100	.	.	.	.		.	
i 	100	.	.	.	8500			.	
i 	100	.	.	.	<		.	
i 	100	.	.	.	.		.	
i 	100	.	.	.	.		.	
i 	100	.	.125	.	.		.	
i	100	7.125 .25	.	.		.
i 	100	+	.	.	.		.	
i 	100	.	.	.	.		.	
i 	100	7.875	.125	6000	8000		.2	

;HHat		strt	dur	amp	cutoff(10K)	length(0-1)(.2)	
i	100	0	.25	6000	8000		.2
i 	100	+	.	<	<		<	
i 	100	.	.	.	.		.	
i 	100	.	.	.	.		.	
i 	100	.	.	.	.		.	
i 	100	.	.	.	.		.	
i 	100	.	.	.	.		.	
i 	100	.	.	.	.		.	
i 	100	.	.	.	10000			.	
i 	100	.	.	.	<		.	
i 	100	.	.	.	.		.	
i 	100	.	.	.	.		.	
i 	100	.	.125	.	.		.	
i	100	11.125 .25	.	.		.
i 	100	+	.	.	.		.	
i 	100	.	.	.	.		.	
i 	100	11.875	.125	8000	13000		.2	


;Snare	strt	dur	amp	freq(900)
i 102		15.125	.25	10000	7000
i 102		+	.25	<	<
i 102		+	.125	.	.
i 102		+	.125	.	.
i 102		+	.125	11000	1000
s


;ORIGINAL DRUM/BASS GROOVE WITH RANDOM FILLS===============================================================
r4 dex
;a 0 0 16

;gverb	strt	dur	time	HFRoll(0-1) 
i 900		0	4	1	.1

;HHat		strt	dur	amp	cutoff(10K)	length(0-1)(.2)	
i	100	0	.125	2000	8000		.1
i	100	+	.	2300	<		<
i 	100	.	.	<	.		.	
i 	100	.	.	.	.		.	
i 	100	.	.25	.	.		.18	
i 	100	.	.	.	.		.	
i 	100	.	.	.	.		.	
i 	100	.	.	.	.		.	
i 	100	.	.	2500	.		.	
i 	100	.	.	<	.		.	

i 	100	.	.	.	[10000+[$dex*1000]]		.	
i 	100	.	.	.	<		.	
i 	100	.	.	.	.		.	
i 	100	.	.	.	.		.	
i 	100	.	.125	.	.		.	
i	100	3.125 .25	.	.		.
i 	100	+	.	.	.		.	
i 	100	.	.	.	.		.	
i 	100	3.875	.125	2600	8000		.2	

;Kick		strt	dur	amp	freq(60)
i 101 	0	.25	10000	60
i 101       .875	.	10000	<
i 101		2	.	10000	63
i 101		2.75	.	8000	<
i 101		2.875	.	11000	.

;Snare	strt	dur	amp	freq(900)
i 102		.5	1	4300	850
i 102		2.5	.	.	800

;rndKS	strt	dur	amp	freq(N/A defaults to 60 and 900)
i 103 	1	.125	7000	600 $dex
i 103 	+	.	<	.	<
i 103 	.	.	.	.	.
i 103 	.	.	.	.	.
i 103 	.	.	.	.	.
i 103 	.	.	.	.	.
i 103 	.	.	.	.	.
i 103 	.	.	8500	.	5

;rndKS	strt	dur	amp	freq(N/A defaults to 60 and 900)
i 103 	3	.125	7000	600 $dex
i 103 	+	.	<	.	<
i 103 	.	.	.	.	.
i 103 	.	.	.	.	.
i 103 	.	.	.	.	.
i 103 	.	.	.	.	.
i 103 	.	.	.	.	.
i 103 	.	.	8500	.	5

;Bass		strt	dur	amp	pch1	pch2	coff1	coff2	resmix(.001-1)	
;i 200	0	1	10000	5.01  5.01	1000	1	.001


;Bass		strt	dur	amp	pch1	pch2	coff1	coff2	resmix(.001-1)
i 200 	0	.8	10000	6.01	6.01	10000	5000	[.1*[$dex/4]]
i 200       .875	.25	.	6.04	0.04	<	<	<
i 200		1.25	.75	.	6.06	6.01	13000	500	.
i 200		2	.75	.	6.01	6.01	15000	500	.
i 200		2.75	.125	.	6.06	6.08	8000	1000	[.6*[$dex/4]]
i 200		2.875	.375	.	6.04	6.04	1000	2000	<
i 200		3.25	.625	.	5.11	5.11	<	<	.
i 200		3.875	.125	.	5.11	6.01	800	6000	[.4*[$dex/4]]

;String	strt	dur	amp		pch	fmamp	fmratio
i 201		0	4	[[[4-$dex]^8]/14]	5.01	0	1

;grainfilt		strt	  dur	   atk     rel    amp   ampoff	frq  maxfrqoff	dens1 dens2  gdur  gduroff	funct   randPdepth   lfodpth  lfoitts  lfodurmod   lfofiltmod   lpfmix ampatt
;i 420        	0	   4		.4 	.5	[50/[$dex*.5]]  	  10		2.04  [4.09*[[5-$dex]*.10]]		10    100    .005  .01   	  1         10          2        $dex        .001            3          .5 .5
i 420        	0	   .5		.4 	.01	20  	  10		5.04  1.01		100    1000    .05  .01   	  1         10          2        4        .001            3          .66  .5
;FM   start	dur	amp	frqbase	funct	fc	fmodend	indxmax	sinfreqstrt
i69	3	1	[[$dex^6]-2000]  	20		1	1	4		60		100   

;Snare	strt	dur	amp	freq(900)
i 102		2	.125	[[[[$dex]^7]*1.02]*.5]	800
i 102		+	.	[[[[$dex]^7]*1.04]*.5]	<
i 102		.	.	[[[[$dex]^7]*.98]*.5]	.
i 102		.	.	[[[[$dex]^7]*1]*.5]	.
i 102		.	.	[[[[$dex]^7]*1.01]*.5]	.
i 102		.	.	[[[[$dex]^7]*.98]*.5]	.
i 102		.	.	[[[[$dex]^7]*1]*.5]	.
i 102		.	.	[[[[$dex]^7]*1.01]*.5]	.
i 102		.	.	[[[[$dex]^7]*.98]*.5]	.
i 102		.	.	[[[[$dex]^7]*1]*.5]	.
i 102		.	.	[[[[$dex]^7]*1.01]*.5]	.
i 102		.	.	[[[[$dex]^7]*.98]*.5]	.
i 102		.	.	[[[[$dex]^7]*1]*.5]	.
i 102		.	.	[[[[$dex]^7]*1.01]*.5]	.
i 102		.	.	[[[[$dex]^7]*.98]*.5]	.
i 102		.	.	[[[[$dex]^7]*1]*.5]	3000
s


;OUTRO ========================================================
;a 0 0 14
t 0 60 9 20
;gverb	strt	dur	time	HFRoll(0-1) 
i 900		0	9	1	.1

;String	strt	dur	amp	pch	fmamp	fmratio
i 201	0	8	350	1.01	50	500

;grainfilt		strt	  dur	   atk     rel    amp   ampoff	frq  maxfrqoff	dens1 dens2  gdur  gduroff	funct   randPdepth   lfodpth  lfoitts  lfodurmod   lfofiltmod   lpfmix
i 420        	0	   8.5	.5 	.3	160  	  10		8.04  3.01		10    1000    .005  .01   	  1         10          0        0        0            0          0

;HHat		strt	dur	amp	cutoff(10K)	length(0-1)(.2)	
i 100		0	.5	6000	8000		1
i 100		+	.	<	<		.
i 100		.	.	.	.		.
i 100		.	.	.	.		.
i 100		.	.	.	.		.
i 100		.	.	.	.		.
i 100		.	.	.	.		.
i 100		.	.	.	.		.
i 100		.	.	.	.		.
i 100		.	.	.	.		.
i 100		.	.	.	.		.
i 100		.	.	.	.		.
i 100		.	.	.	.		.
i 100		.	.	.	.		.
i 100		.	.	.	.		.
i 100		.	.	1	1		.

;rndKS	strt	dur	amp	freq(N/A defaults to 60 and 900)
i 103 	0	.0625	5000 600 	0
i 103		+	.	<	.	~
i 103		.	.	.	.	.
i 103		.	.	.	.	.
i 103		.	.	.	.	.
i 103		.	.	.	.	.
i 103		.	.	.	.	.
i 103		.	.	.	.	.
i 103		.	.	.	.	.
i 103		.	.	.	.	.
i 103		.	.	.	.	.
i 103		.	.	.	.	.
i 103		.	.	.	.	.
i 103		.	.	.	.	.
i 103		.	.	.	.	.
i 103		.	.	.	.	.

i 103 	.	.	.	 600 	.
i 103		.	.	.	.	.
i 103		.	.	.	.	.
i 103		.	.	.	.	.
i 103		.	.	.	.	.
i 103		.	.	.	.	.
i 103		.	.	.	.	.
i 103		.	.	.	.	.
i 103		.	.	.	.	.
i 103		.	.	.	.	.
i 103		.	.	.	.	.
i 103		.	.	.	.	.
i 103		.	.	.	.	.
i 103		.	.	.	.	.
i 103		.	.	.	.	.
i 103		.	.	.	.	.

i 103 	.	.	. 600 	.
i 103		.	.	.	.	.
i 103		.	.	.	.	.
i 103		.	.	.	.	.
i 103		.	.	.	.	.
i 103		.	.	.	.	.
i 103		.	.	.	.	.
i 103		.	.	.	.	.
i 103		.	.	.	.	.
i 103		.	.	.	.	.
i 103		.	.	.	.	.
i 103		.	.	.	.	.
i 103		.	.	.	.	.
i 103		.	.	.	.	.
i 103		.	.	.	.	.
i 103		.	.	.	.	.

i 103 	.	.	.	600 	.
i 103		.	.	.	.	.
i 103		.	.	.	.	.
i 103		.	.	.	.	.
i 103		.	.	.	.	.
i 103		.	.	.	.	.
i 103		.	.	.	.	.
i 103		.	.	.	.	.
i 103		.	.	.	.	.
i 103		.	.	.	.	.
i 103		.	.	.	.	.
i 103		.	.	.	.	.
i 103		.	.	.	.	.
i 103		.	.	.	.	.
i 103		.	.	.	.	.
i 103		.	.	.	.	.

i 103 	.	.	. 600 	.
i 103		.	.	.	.	.
i 103		.	.	.	.	.
i 103		.	.	.	.	.
i 103		.	.	.	.	.
i 103		.	.	.	.	.
i 103		.	.	.	.	.
i 103		.	.	.	.	.
i 103		.	.	.	.	.
i 103		.	.	.	.	.
i 103		.	.	.	.	.
i 103		.	.	.	.	.
i 103		.	.	.	.	.
i 103		.	.	.	.	.
i 103		.	.	.	.	.
i 103		.	.	.	.	.

i 103 	.	.	.	600 	.
i 103		.	.	.	.	.
i 103		.	.	.	.	.
i 103		.	.	.	.	.
i 103		.	.	.	.	.
i 103		.	.	.	.	.
i 103		.	.	.	.	.
i 103		.	.	.	.	.
i 103		.	.	.	.	.
i 103		.	.	.	.	.
i 103		.	.	.	.	.
i 103		.	.	.	.	.
i 103		.	.	.	.	.
i 103		.	.	.	.	.
i 103		.	.	.	.	.
i 103		.	.	.	.	.

i 103 	.	.	. 600 	.
i 103		.	.	.	.	.
i 103		.	.	.	.	.
i 103		.	.	.	.	.
i 103		.	.	.	.	.
i 103		.	.	.	.	.
i 103		.	.	.	.	.
i 103		.	.	.	.	.
i 103		.	.	.	.	.
i 103		.	.	.	.	.
i 103		.	.	.	.	.
i 103		.	.	.	.	.
i 103		.	.	.	.	.
i 103		.	.	.	.	.
i 103		.	.	.	.	.
i 103		.	.	.	.	.

i 103 	.	.	.	600 	.
i 103		.	.	.	.	.
i 103		.	.	.	.	.
i 103		.	.	.	.	.
i 103		.	.	.	.	.
i 103		.	.	.	.	.
i 103		.	.	.	.	.
i 103		.	.	.	.	.
i 103		.	.	.	.	.
i 103		.	.	.	.	.
i 103		.	.	.	.	.
i 103		.	.	.	.	.
i 103		.	.	.	.	.
i 103		.	.	.	.	.
i 103		.	.	.	.	.
i 103		.	.	1	.	10000

e
