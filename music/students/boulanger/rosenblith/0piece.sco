; FUNCTION 1 USES THE GEN10 SUBROUTINE TO COMPUTE A SINE WAVE
f 1  0 4096 10   1    


;INST     START     DURATION     MOD1	INDEX	PITCH		MOD2	RVBSND		RINGMOD    RINGDEPTH(0-1)
i 102      0        2           1       2       7.00        6		1			100			.5
i .			+		1			(		.			(		.		1			<			<
i .         +       .5  		(		.			(		.		.			<			<
i .         +       .25 	    (		.			(		.		.			<			<
i .         +       .125		(		.			(		.		.			<
i .         +       .125		(		.			(		.		.			<	
i .         +       .125		(		.			(		.		.			<
i .         +       .125		(		.			(		.		.			<
i .         +       .125		(		.			(		.		.			<
i .         +       .0625		(		.			(		.		.			<
i .         +       .0625   	(		.			(		.		.			<
i .         +       .0625    	6		.		 7.05		.		.			440			1
b -2		
i 102       4.562    2          2       2       7.00        5		.			220			1
i .			+		1			(		.			(		.		.			<			<
i .         +       .5  		(		.			(		.		.			<		
i .         +       .25 	    (		.			(		.		.			<	
i .         +       .125		(		.			(		.		.			<
i .         +       .125		(		.			(		.		.			<
i .         +       .125		(		.			(		.		.			<
i .         +       .125		(		.			(		.		.			<
i .         +       .125		(		.			(		.		.			<		
i .         +       .0625		(		.			(		.		.			<
i .         +       .0625   	(		.			(		.		.			<
i .         +       .0625    	6		.		 7.07		.		.			440			.5
b -2			
i 102       7.124   2           3       2       7.00        4		.			40			.4
i .			+		1			(		.			(		.		.			<			(
i .         +       .5  		(		.			(		.		.			<
i .         +       .25 	    (		.			(		.		.			<
i .         +       .125		(		.			(		.		. 			<
i .         +       .125		(		.			(		.		.			<
i .         +       .125		(		.			(		.		.			<
i .         +       .125		(		.			(		.		.			<
i .         +       .125		(		.			(		.		.			<	
i .         +       .0625		(		.			(		.		.			<
i .         +       .0625   	(		.			(		.		.			<
i .         +       .0625    	6		.		 8.00		.		.			<
i 102       +       2           3       2       7.00        1		.			<
i .			+		1			(		.			(		<		.			<
i .         +       .5  		(		.			(		<		.			<
i .         +       .25 	    (		.			(		<		.			<
i .         +       .125		(		.			(		<		.			<
i .         +       .125		(		.			(		<		.			<
i .         +       .125		(		.			(		<		.			<
i .         +       .125		(		.			(		<		.			<
i .         +       .125		(		.			(		<		.			<
i .         +       .0625		(		.			(		<		.			<
i .         +       .0625   	(		.			(		<		.			<
i .         +       .0625    	4		.		 8.00		5		.			880			1.2
b -4
i 102       14       4           3       2       6.00        1		.			100       .2
i .			+		2			(		.			(		<		.			<		  <
i .         +       1   		(		.			(		<		.			<
i .         +       .5  	    (		.			(		<		. 			<
i .         +       .5  		(		.			(		<		.			<
i .         +       .25 		(		.			(		<		.			<
i .         +       .25 		(		.			(		<		.			<
i .         +       .25  		(		.			(		<		.			<
i .         +       .125		(		.			(		<		.			<
i .         +       .125		(		.			(		<		.			<
i .         +       .0625   	(		.			(		<		.			<	
i .         +       .0625    	4		.		 7.00		5		.			200	       .7

i .         18		10			3		5		6.00		1		.			100      .9

i 102       25       4           3       2       8.00        1		.		1440		.2
i .			+		2			(		.			(		<		.		.			<
i .         +       1   		(		.			(		<		.		.
i .         +       .5  	    (		.			(		<		.		.
i .         +       .5  		(		.			(		<		.		.		
i .         +       .25 		(		.			(		<		.		.
i .         +       .25 		(		.			(		<		.		.
i .         +       .25  		(		.			(		<		.		.
i .         +       .125		(		.			(		<		.		.
i .         +       .125		(		.			(		<		.		.		
i .         +       .0625   	(		.			(		<		.		.
i .         +       .0625    	4		.		 9.00		5		.		.			1.2

i .         27		10			3		5		6.00		1		.		3000		1
i .         33      10          2       3       6.00        4       .       5000        .7

i .         40      .125		(		.	 	 9.00		<		.		.
i .         +       .125		(		.			(		<		.		.		
i .         +       .0625   	(		.			(		<		.		.
i .         +       .0625    	4		.		 6.00		5		.		.			1.2
i .         +       .125		(		.			(		<		.		.
i .         +       .125		(		.			(		<		.		.		
i .         +       .0625   	(		.			(		<		.		.
i .         +       .0625    	4		.		 8.00		5		.		.			1.2

i .         40      10          5       4           7.05    1       .       500         1

i .         49      .125		3		2			9.00	2		.		.		
i .         +       .125		(		.			(		<		.		.		

i .         +       .125		(		.			(		<		.		.
i .         +       .125		1		.			7.00	3		.		.		

;=====================================================
;          start     duration  time    highatten  panfrqst  panfrqend
;=====================================================================
i 199       0        13        4       .5  		   .1		5
i 199		10		 17 	   6	   .2 		    5      	20	
i 199       25       30        5       .8           20      2
		

;--------------------------------------------------------------
;INST     START     DURATION    PITCH	
;--------------------------------------------------------------
;i 103		0		1			8.00
;i 103		+		.			8.01
;i 103  		+		.			7.11


s
f0 4
s