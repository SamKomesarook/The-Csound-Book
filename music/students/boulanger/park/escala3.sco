;				Escala3 (score file)
;					composition by Joo Won Park (druntune@hotmail.com)
;								Feb. 24th, 2001


;scale note value MACRO
#define C	#300#
#define D	#372#
#define E	#446#
#define F	#520#
#define G	#596#
#define	A	#673#
#define B	#751#
#define	CC	#830#
#define	DD	#910#

f1  0 4096 10   1    
f2  0 4096 10   1  .5 .333 .25 .2 .166 .142 .125 .111 .1 .09 .083 .076 .071 .066 .062


;a 0 0 30
;section1	motif up
t	0	60	3	55	
;inst	st	dur	dB	frq		f#	atk rvb	cmb		prepost
i1		0	.5	50	300		1	.1	0	0		1	
i1		+	.	<	<		.	<	.	.		.	
i1		.	.	.	.		.	.	.	.		.	
i1		.	.	.	.		.	.	.	.		.	
i1		.	.	.	.		.	.	.	.		.	
i1		.	.	.	.		.	.	.	.		.	
i1		.	.	.	.		.	.	.	.		.	
i1		.	.	.	.		.	.	.	.		.	
i1		.	4	70	910		.	.3	.	0		.
;inst	st	dur	dB	frq		f#	atk	ind	panf rvb cmb
i2		4	4	55	455		1	.4	20	.5	.7	0
i2		4.5	3.5	55	150		1	.4	20	.25	.4	0

i199	4	6	4	0
s




;a 0 0 30
;section2 motif down
t	0	50	3	55	7	60
;inst	st	dur	dB	frq		f#	atk rvb	cmb	
i1		0	.5	70	910		1	.1	0	.1	1
i1		+	.	<	<		.	<	.	<	.
i1		.	.	.	.		.	.	.	.	.
i1		.	.	.	.		.	.	.	.	.
i1		.	.	.	.		.	.	.	.	.
i1		.	.	.	.		.	.	.	.4	.
i1		.	.	.	.		.	.	.	<	.
i1		.	.	.	.		.	.	.	.	.
i1		.	3	50	300		.	.9	.	.1	.
;inst	st	dur	dB	frq		f#	atk	ind	panf rvb cmb
i2		4	3	50	150		1	.4	20	.75	.7	0
i2		4.5	3	50	455		1	.4	40	.5	.4	0
i2		5	4	50	600		1	.6	50	4	.6	0

i198	0	8	10	.3
i199	4	8	5	0
s




;a 0 0 30
;section3 developement 1-1
t	0	60	3	45
;inst	st	dur	dB	frq		f#	atk rvb	cmb	
i1		0	.5	50	300		1	.1	0	.1		1	
i1		+	.	<	<		.	<	<	<		.	
i1		.	.	.	.		.	.	.	.		.	
i1		.	.	.	.		.	.	.	.		.	
i1		.	.	.	.		.	.	.	.		.	
i1		.	.	.	.		.	.	.	.		.	
i1		.	.	.	.		.	.	.	.		.	
i1		.	.	.	.		.	.	.	.		.	
i1		.	2	70	910		.	.3	.5	.3		.

;inst	st	dur	dB	frq		f#	atk	ind	panf rvb cmb	
i2		4	4	50	455		1	.4	40	1	.7	0
i2		4.5	4	50	150		1	.4	30	.75	.4	0
i2		5	4	50	600		1	.6	50	4	.6	0

i198	0	10	10	.2
i199	0	10	6	0
s




;a 0 0 30
;section4 developement 1-2
t	0	45	3	50	6	55
;inst	st	dur	dB	frq		f#	atk rvb	cmb	
i1		0	.5	65	$DD.	1	.1	.3	.7	1; scale variation1
i1		+	.	<	$CC.	.	<	<	<	.
i1		.	.	.	$A.		.	.	.	.	.
i1		.	.	.	$B.		.	.	.	.	.
i1		.	.	.	$F.		.	.	.	.	.
i1		.	.	.	$G.		.	.	.	.	.
i1		.	.	.	$D.		.	.	.	.	.
i1		.	.	.	$E.		.	.	.	.	.
i1		.	3	50	$C.		.	.9	.7	.1	.	

;inst	st	dur	dB	frq		f#	atk	ind	panf rvb cmb
i2		4	3	45	150		1	.4	20	.75	.7	0
i2		4.5	3	50	455		1	.4	40	.5	.4	0
i2		5	4	40	600		1	.6	50	4	.6	0

;inst	st	dur	dB	fc1		fc2		atk	rel	trem pan rvb
i3		6.5 3	70	350		7000 	.4	.2 	4	4	.2

i198	0	12.5	10	.07
i199	0	12.5	8	0
s




;a	0	0	30
;section5 development 2
t	0	55	2	40	3	35	5	30	7	20 11 40  13 45	16	50
i1	0	.5	50	$C.		1	.1	.2	.5		1; scale varation2	
i1	+	.	<	$F.		.	<	<	<		.	
i1	.	.	.	$E.		.	.	.	.		.	
i1	.	.	.	$A.		.	.	.	.		.	
i1	.	.	.	$F.		.	.	.	.		.	
i1	.	.	.	$B.		.	.	.	.		.	
i1	.	.	.	$A.		.	.	.	.		.
i1	.	.	.	$CC.	.	.	.	.		.	
i1	.	1	65	$DD.	.	.3	.5	.1		.

;inst	st	dur	dB	frq		f#	atk	ind	panf rvb cmb	
i2		4	6	50	455		1	.4	50	1	.7	0
i2		4.5	6	50	150		1	.4	40	.75	.4	0
i2		5	7	50	600		1	.6	70	4	.6	0

;inst	st	dur	dB	fc1		fc2		atk	rel	trem pan rvb
i3		6	10	80	350		13000 	.3	.2 	4	4	.2

;inst st	dur	dB	frq		f#	atk rvb	cmb	prepost
i1	8.5	.5	65	$DD.	1	.1	.2	.5	1; scale variation3
i1	+	.	<	$CC.	.	.	<	<	.
i1	.	.	.	$G.		.	.	.	.	.
i1	.	.	.	$F.		.	.	.	.	.
i1	.	.	.	$B.		.	.	.	.	.
i1	.	.	.	$A.		.	.	.	.	.
i1	.	.	.	$E.		.	.	.	.	.
i1	.	.	.	$B.		.	.	.	.	.
i1	.	3	60	$C.		.	.2	.3	.1	.

;inst	st	dur	dB	frq		f#	atk	ind	panf rvb cmb
i2	  12.5	6	55	150		1	.4	50	1	.7	0
i2	  13	6	55	455		1	.4	40	.75	.4	0
i2	  13.5	7	45	600		1	.6	70	4	.6	0
i2	  20	2	35	150		1	.3	30	4	.3	0

;inst	st	dur	dB	fc1		fc2		atk	rel	trem pan rvb
i3	  13.5	7	80	350		10000 	.1	.2 	4	4	.2
i198  0		23.5	10	.006
i199  0		23.5	7.5	0
s




;a	0	0	32
;section6 develope3
t	0	40	3	35	6 30 19	25		

;inst	st	dur	dB	fc1		fc2		atk	rel	trem pan rvb
i3		0	8	80	300		12000 	.5	.8 	4	 7	.3

;inst	st	dur	dB	frq		f#	atk	ind	panf rvb cmb
i2	  	4	6	45	450		1	.1	50	0.5	.4	.7
i2	  	4.5	10	40	75		1	.05	10	7	.2	.4; ddoing~

;inst	st	dur	dB	frq		f#	atk rvb	cmb		pre	
i1		0	.5	60	300		1	.1	0	.1		1	
i1		+	.	<	<		.	<	.	<		.	
i1		.	.	.	.		.	.	.	.		.	
i1		.	.	.	.		.	.	.	.		.	
i1		.	.	.	.		.	.	.	.		.	
i1		.	.	.	.		.	.	.	.		.	
i1		.	.	.	.		.	.	.	.		.	
i1		.	.	.	.		.	.	.	.		.	
i1		.	2	70	910		.	.4	.	.3		.5	

;inst	st	dur	dB	fc1		fc2		atk	rel	trem pan rvb
i3		4.5	9	70	400		10000 	.5	.5 	5	 9	.3

;inst	st	dur	dB	frq		f#	atk	ind	panf rvb cmb
i2	  	6	6	40	150		1	.4	50	1	.7	.4
i2	  	6	6	40	455		1	.4	40	.75	.4	.7
i2	  	4	7	40	600		1	.6	70	4	.6	.9
i2	  	9	7	50	227.5	1	.5	90	8	.6	.5

;inst	st	dur	dB	frq		f#	atk rvb	cmb		pre
i1		5	.5	65	$DD.	1	.1	.3	.7	1; scale variation1
i1		+	.	<	$CC.	.	<	<	<	.
i1		.	.	.	$A.		.	.	.	.	.
i1		.	.	.	$B.		.	.	.	.	.
i1		.	.	.	$F.		.	.	.	.	.
i1		.	.	.	$G.		.	.	.	.	.
i1		.	.	.	$D.		.	.	.	.	.
i1		.	.	.	$E.		.	.	.	.	.
i1		.	3	50	$C.		.	.9	.7	.1	.

;inst	st	dur	dB	fc1		fc2		atk	rel	trem pan rvb
i3		10	8	60	700		9000 	.4	.5 	8	 6	.3

;inst	st	dur	dB	frq		f#	atk	ind	panf rvb cmb
i2	  	12	7	60	150		1	.6	50	1	.3	.7
i2	  12.5	7	60	600		1	.4	70	4	.6	.4

;inst	st	dur	dB	frq		f#	atk rvb	cmb		pre
i1	10	.5	60	$C.		1	.1	.2	.5		1; scale varation2	
i1	+	.	<	$F.		.	<	<	<		.	
i1	.	.	.	$E.		.	.	.	.		.	
i1	.	.	.	$A.		.	.	.	.		.	
i1	.	.	.	$F.		.	.	.	.		.	
i1	.	.	.	$B.		.	.	.	.		.	
i1	.	.	.	$A.		.	.	.	.		.
i1	.	.	.	$CC.	.	.	.	.		.	
i1	.	1	45	$DD.	.	.3	.5	.1		.	

;inst	st	dur	dB	fc1		fc2		atk	rel	trem pan rvb
i3		13	5	75	1000	4000 	.4	.5 	10	 6	.5

;inst	st	dur	dB	frq		f#	atk	ind	panf rvb cmb
i2	  	12	5	50	150		1	.3	50	1	.7	.4
i2	   12.5	8	40	455		1	.4	40	5	.4	.7
i2	  	13	6	40	600		1	.6	70	4	.6	.9
i2	  13.5	7	50	227.5	1	.5	90	8	.6	.5

;inst	st	dur	dB	fc1		fc2		atk	rel	trem pan rvb
i3		16	12	75	1000   7000 	.4	.45  15	 4	.6

;inst	st	dur	dB	frq		f#	atk	ind	panf rvb cmb
i2	  	16	4	40	910		1	.2	70	1	.7	.7
i2	   ^+3	.	<	150		.	<	40	<	.	<
i2	  	.	.	.	455		.	.	50	.	.	.
i2		.	.	.	300		.	.	80	.	.	.
i2	    .	.	.	75		.	.	90	.	.	.;sitar
i2	    .	.	.	1200	.	.	60	.	.	.
i2	    .	6	50	300		.	.6	80	2	.	.1

;inst	st	dur	dB	frq		f#	atk rvb	cmb		pre	
i1	17	.5	55	$DD.	1	.1	.2	.5	1; scale variation3
i1	+	.	<	$CC.	.	.	<	<	.
i1	.	.	.	$G.		.	.	.	.	.
i1	.	.	.	$F.		.	.	.	.	.
i1	.	.	.	$B.		.	.	.	.	.
i1	.	.	.	$A.		.	.	.	.	.
i1	.	.	.	$E.		.	.	.	.	.
i1	.	.	.	$B.		.	.	.	.	.
i1	.	4	65	$C.		.	.2	.3	.1	.

;inst	st	dur	dB	frq		f#	atk	ind	panf rvb cmb
i2	  	24	1	50	75		1	.4	70	1	.6	.7; delay hit
i2	    25	.7	45	455		1	.	80	2	.6	.5
i2	  25.5	.	40	300		1	.	70	.5	.6	.3
i2	  	26	.	35	600		1	.	70	.25	.6	.2

;inst	st	dur	dB	frq		f#	atk rvb	cmb		pre	
i1		25	3	35	150		1	.5	0	.7		1;conneting note

i198	0	28.25	10	.5
i199	0	28.25 	4	0
s




;a	0	0	80
;section7 coda
t	0	75
;inst	st	dur	dB	frq		f#	atk	ind	panf rvb cmb
i2	  	0	1	50	75		1	.4	70	1	.6	.7; delay hit
i2	    1.5	.	<	455		1	.	80	.75	.6	.5
i2	  	3	.	.	300		1	.	70	.5	.6	.3
i2	  	4.5	.	30	600		1	.	70	.25	.6	.2

i2	  	8	1	50	75		1	.4	70	1	.8	.7; delay hit
i2	  ^+1.5	.	<	455		1	.	80	<	.8	.5
i2	  ^+1.5	.	.	300		1	.	70	.	.8	.3
i2	  ^+1.5	.	30	600		1	.	70	.25	.8	.2


i2	  	15	1	45	75		1	.4	70	.25	.9	.7; delay hit
i2	  ^+1.5	.	<	455		1	.	80	<	.9	.5
i2	  ^+1.5	.	.	300		1	.	70	.	.9	.3
i2	  ^+1.5	.	20	600		1	.	70	1	.9	.2

i2	  	21	1	40	75		1	.4	90	.25	.8	.7; delay hit
i2	  ^+1.5	.	<	455		1	.	80	<	.8	.5
i2	  ^+1.5	.	.	300		1	.	90	.	.8	.3
i2	  ^+1.5	.	15	600		1	.	70	1	.8	.2

i2	  	28	1	35	75		1	.4	90	.25	.8	.7; delay hit
i2	  ^+1.5	.	<	455		1	.	80	<	.8	.5
i2	  ^+1.5	.	.	300		1	.	90	.	.8	.3
i2	  ^+1.5	.	15	600		1	.	70	1	.8	.2

i2	  	37	1	30	75		1	.4	90	.25	.8	.7; delay hit
i2	  ^+1.5	.	<	455		1	.	80	<	.8	.5
i2	  ^+1.5	.	.	300		1	.	90	.	.8	.3
i2	  ^+1.5	.	10	600		1	.	70	1	.8	.2

;inst	st	dur	dB	frq		f#	atk rvb	cmb		pre
i1		6	5	45	300		1	.6	.2	0		0
i1		+	.	<	<		.	<	<	<		<
i1		.	.	.	.		.	.	.	.		.
i1		.	.	.	.		.	.	.	.		.
i1		.	.	60	.		.	.	.	.		.
i1		.	.	<	.		.	.	.	.		.
i1		.	.	.	.		.	.	.	.		.
i1		.	.	45	910		.	.7	.6	.		1
i1		.	2	<	<		.	.5	.	.		1
i1		.	.	.	.		.	<	.	.		1
i1		.	.	.	.		.	.	.	.		1
i1		.	.	.	.		.	.	.	.		1
i1		.	.	.	.		.	.	.	.		1
i1		.	.	.	.		.	.	.	.		1
i1		.	.	.	.		.	.	.	.		1
i1		.	.	.	.		.	.	.	.		1
i1		.	.	20	840		.	.9	.	.7		1

;inst	st	dur	dB	fc1		fc2		atk	rel	trem pan rvb
i3		14	50	70	1000   10000 	.6	.4 	.4	 4	.6
i3		30	40	70	500    12000 	.8	.4 	.5	 4	.6

i198	0	82	10	.5
i199	0	82	6	0
