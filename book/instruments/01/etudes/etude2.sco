;Function 1 uses the GEN10 subroutine to compute a sine wave
;Function 2 uses the GEN10 subroutine to compute the first sixteen partials of a sawtooth wave
;Function 3 uses the GEN20 subroutine to compute a Hanning window for use as a grain envelope
;Function 4 uses the GEN01 subroutine to read in an AIF audio file
;Function 5 uses the GEN01 subroutine to read in annother AIF audio file

f1  0 4096 10   1    
f2  0 4096 10   1  .5 .333 .25 .2 .166 .142 .125 .111 .1 .09 .083 .076 .071 .066 .062
f3  0 4097 20   2  1
f4  0 0    1   "sing.aif" 0 4 0

;inst		start	duration
i107		0		1		10000	440		1
i107		1.5		1		20000	220		2
i107		3		3		10000	110		2
i107		3.5		2.5		10000	138.6	2
i107		4		2 		5000	329.6	2
i107		4.5		1.5		6000	440		2

i108		7		1       10000		440  	1  2  		3  		1
i108		8.5   	1       20000		220  	1  13  		8  	    1
i108		10	    3       10000		110   	1  1  		13  	1
i108		10.5	2.5     10000		130.8  	1  2.001  	8  	   	1
i108		11	    2       5000		329.6  	1  3.003  	5  	    1
i108		11.5	1.5     6000		440    	1  5.005  	3  		1

i109  		14        1	      10000		440		10	1
i109  		15.5      1	      20000		220  	20	1
i109  		17        3      10000		110		30	1
i109  		17.5      2.5	  10000		130.8	5	1
i109  		18        2	      5000		311.1	9	1
i109  		18.5      1.5	  6000		440	    2	1

i110    	21      1		10000  		440     440  2  1
i110    	22.5    1		20000  		220     220  0  1
i110    	24      3		10000  		110     55   0  1
i110   		24.5    2.5		10000  		138.6   110  2  1
i110   		25      2		5000  		329.6    220  0  3
i110    	25.5    1.5		6000  		440      55  2  3

i111     	28      3	4000  440  55  4000  10   .05  1  3  1
i111     	32      3	4000  220  20  2000  110  .08  1  3  1
i111     	35      4	1000  110 1760  0   7040  .03  1  3  1

i112     	41      2.31	    10000  440    4
i112     	39.5    4.62	    10000  220    4
i112     	44.5    1.155	10000  880    4
i112     	46      4.62	    10000  220    4
i112     	47      2.31	    10000  440    4
i112     	48.5    2	     9000  554.4  4
i112     	49      1.5	     7000  659.2  4
i112     	49.5    1.15	 6000  880    4
