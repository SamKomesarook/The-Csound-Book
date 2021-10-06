;=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=;
; An example of Gray encoding of a binary number  ;
; Coded by Pedro Batista, 1998                    ;
;=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=;

sr	=	44100
kr	=	44100
ksmps	=	1

	zakinit	1, 48

	instr	1

ibin	=	1
igray	=	17
ibout	=	33

isigi	=	12345; some value
	print	isigi

;convert to binary
isig	=	isigi
indx	=	0
loop1:
ibit	=	(frac(isig/2)==0 ? 0:1)
	ziw	ibit, ibin+indx
isig	=	int(isig/2)
indx	=	indx+1
	if (indx<16) igoto loop1

;convert binary to gray
indx	=	15
ibit0	zir	ibin+indx
	ziw	ibit0, igray+indx
loop2:
indx	=	indx-1
ibit1	zir	ibin+indx
ibit	=	(ibit1==ibit0 ? 0:1)
ibit0	=	ibit1
	ziw	ibit, igray+indx
	if (indx>0) igoto loop2

;convert gray to binary
indx	=	15
ibit0	zir	igray+indx
	ziw	ibit0, ibout+indx
loop3:
indx	=	indx-1
ibit	zir	igray+indx
ibit	=	(ibit==ibit0 ? 0:1)
	ziw	ibit, ibout+indx
ibit0	=	ibit
	if (indx>0) igoto loop3

;convert from binary
indx	=	0
isigo	=	0
ipow2	=	1

loop4:
ibit	zir	ibout+indx
isigo	=	isigo+ibit*ipow2
ipow2	=	ipow2*2
indx	=	indx+1
	if (indx<16) igoto loop4

	print isigo; should be the same...

	endin
