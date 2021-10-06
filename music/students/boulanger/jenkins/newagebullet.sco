f1 0 8192 10 1
f2 0 8192 10 .5 .4 .3 .6 .7 .7 1 1 1 
f103	0	8		2	1	1	-1	1	1	-1	1	-1


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;1	2	3	4	5		6	7	8		(POO)

i4	0	30	80	9.00	3	0	70

i4	0	30	80	9.01	3	0	.

i4  10	30	80	9.05	2	.5	.

i4  20	30	80	9.08	2	.5	.

i4	30	30	70	9.00	1	0	.

i4  40	30	80	9.05	2	.5	.

i4  50	30	80	9.08	2	.5	.

i4	60	30	80	9.00	1	0	.	

i4	70	30	80	9.02	1	.5	.

i4	80	30	75	9.00	1	.5	.

i4	80.5 30	75	8.00	1	0	.

i4	90.0 30	80	9.02	1	.5	.01	

i4	90.5 30	80	10.02	1	0	.01


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;1	2	3	4	5	6	7	8	9		(ZKICK)

i7  41 1  587  .05  55  .5  44  37	.05


i7  61 1  587  .05  55  .5  44  37	.05


i7  85 1  587  .05  55  .5  44  37	.05


i7  105 1  587  .05  55  .5  44  37	.05

i105	41    450					;(ZKICK VERB)


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;1		2		3		4	  5		  6		 7		8		9 	(DING)			;istart	=	p6
																				;iend	=	p7
i5		85		4		90	11.00	.3		.5	   1		3					;ipan	=	p8

i5		85		4		90	 9.02	.1		.2	   0		3	

i5		100		4		80	11.01	.3		.5	   1		3	

i5		105		4		80	11.00	.3		.5	   0		3

;1		2	 3	4	 5   6	
i103	85	100	0	20	.5											;(DING DELAY)
i103	85	100	0	30	 1											;p4=ipan
i103	100	100	0	3	.6											;idecay	=	p5
i103	105	100	1	2	.6											;idrate	=	p6

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
; 1	2	3	4	5		6	7	8			(beep4)

i6	90	10	90	11.00	.001	.5	1

i6	91	10	90	11.02	.		.8	0

i6	92	10	90	11.01	.		.9	.5


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;1	2	3	4	  5

i8 110	25	78	1000		;noise

i8 125	25	78	1000		;noise

i8 135	25	78	1000	

i8 145	25	78	1000		

i8 155	25	78	1000

i8 165	25	78	1000

i8 175	25	78	1000

i8 185	25	78	1000

i8 195	25	78	1000

i8 205	25	78	1000

i8 215	25	78	1000

i8 225	25	78	1000

i8 235	25	78	1000

i8 245	25	78	1000

i8 255	25	78	1000

i8 265	25	78	1000

i8 275	25	78	1000

i8 285	25	78	1000

i8 285	25	78	1000

i8 295	25	78	1000

i8 305	25	78	1000

i8 315	25	73	1000

i8 325	25	73	1000

i8 335	25	73	1000

i8 350	25	73	1000


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


i3	315	30	85	6.00  80  10  10  0	 1	1

i3	325	30	85	6.00  80  10  10  0	 1	1

i3	335	30	80	6.00  80  10  10  0	 1	1

i3	345	30	80	6.02  80  10  10  0	 1	1

i3	355	30	80	6.00  80  10  10  0	 1	1

i3	365	30	80	6.00  80  10  10  0	 1	1

i3	375	30	80	6.02  80  10  10  0	 1	1

i3	385	30	80	6.00  80  10  10  0	 1	1

i3	395	30	80	6.05  80  10  10  0	 1	1

i3	405	30	80	6.02  80  10  10  0	 1	1

i3	415	30	80	6.00  80  10  10  0	 1	1


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;poo2

;1	2	3	4	5		6

i9	135	30	80	9.00	6	0	103

i9	135	30	80	9.01	6	0	103

i9  155	30	80	9.05	2	.5	103

i9  165	60	80	9.08	2	0	103

i9	175	30	80	9.00	1	.5	103

i9	185	30	80	9.02	1	.5	103

i9	195	60	80	9.05	3	0	103

i9	205	30	80	9.08	1	.5	103

i9	215	30	80	9.00	2	0	103

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

												    ;p4=rvb gain
;p1	 p2 	p3	p4	p5	p6	p7	p8	p9				;p5=delay fedback
i10  235    40 .01	30	3	.5	.2	0				;p6=delay time
													;p7panning: 1=left,.5=center,0=right
i10  255    20 .01	20	2	 0	1	0				;p8=ktime

i10  261    20 .01	20	2	 1	2	1				;p9	khdif(high freq diffusion 0-1)

i10  271.5  112 .01	110	3	.5	.2	0

i10  275    92 .01	90	2	 0	1	0	

i10  278    92 .01	90	2	 1	2	1
