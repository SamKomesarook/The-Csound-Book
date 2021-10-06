sr	=	44100
kr	=	441
ksmps	=	100

	zakinit	1, 8

	instr	1
inump	=	3
i_in	=	1
i_out	=	5
	igoto	perf
neural:
;-----------------------------------------------
iin1	zir	i_in
iout1	zir	i_out
iin2	zir	i_in+1
iout2	zir	i_out+1
iin3	zir	i_in+2
iout3	zir	i_out+2
;----------------------------
iins	zir	i_in+inump
iouts	=	iins
	ziw	iouts, i_out+inump
	rireturn
;-----------------------------------------------
perf:
a1	soundin	"c:\csound\samples\soundin.1"
k1	downsamp a1

a2	soundin	"c:\csound\samples\soundin.2"
k2	downsamp a2

a3	soundin	"c:\csound\samples\soundin.3"
k3	downsamp a3

as	soundin	"c:\csound\samples\soundin.1"
ks	downsamp as

;find maximum and minimum values for all patterns
kmax	=	-32768
kmin	=	+32767
kpat	=	0
loop10:
	if (kpat>0) kgoto skip1
kval	=	k1
	kgoto skip9
skip1:	if (kpat>1) kgoto skip2
kval	=	k2
	kgoto skip9
skip2:	if (kpat>2) kgoto skip3
kval	=	k3
	kgoto skip9
skip3:	if (kpat>3) kgoto skip9
kval	=	ks
skip9:	if (kval<=kmax) kgoto next1
kmax	=	kval
next1:	if (kval>=kmin) kgoto next2
kmin	=	kval
next2:
kpat	=	kpat+1
	if (kpat<=inump) kgoto loop10

;if dynamic range is zero, go back to 1st approach
	if (kmax!=kmin) kgoto next3
kmin	=	-32768
kmax	=	+32768

;else scale values using real dynamic range
next3:	zkw	(k1-kmin)/(kmax-kmin), i_in
	zkw	(k1-kmin)/(kmax-kmin), i_out
	zkw	(k2-kmin)/(kmax-kmin), i_in+1
	zkw	(k2-kmin)/(kmax-kmin), i_out+1
	zkw	(k3-kmin)/(kmax-kmin), i_in+2
	zkw	(k3-kmin)/(kmax-kmin), i_out+2

	zkw	(ks-kmin)/(kmax-kmin), i_in+inump

;-----------------------------------------
	reinit neural
;-----------------------------------------
kval	zkr	i_out+inump
ks	=	kval*(kmax-kmin)+kmin
as	interp	ks
	out	as

	endin