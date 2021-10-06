sr	=	44100
kr	=	4410
ksmps	=	10

	zakinit	1, 1

	instr	1
	igoto	perf

neural:	;------------------------------------------
ival	zir	1
;	print	ival
	rireturn

perf:	;------------------------------------------
a1	soundin	"c:\csound\samples\soundin.1"
k1	downsamp a1

kval	=	dbamp(k1+32768)/96
	zkw	kval, 1

;-----------------------------------------
	reinit neural
;-----------------------------------------

kval	zkr	1
k2	=	ampdb(kval*96)-32768
a2	interp	k2
	out	a2
	endin
