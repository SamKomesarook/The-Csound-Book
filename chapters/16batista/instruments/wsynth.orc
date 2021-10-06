;=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=;
;=              A Wave-Packet Synthesizer              =;
;=         Coded by Pedro A. G. Batista, 1998          =;
;= (based on M.V.Wickerhauser's work with tonebursts)  =;
;=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=;

sr	=	44100     ; sr and kr
kr	=	45        ; can be changed at will.
ksmps	=	980       ; I just keep kr short for speed

;=-=-=-=-=-=-=-=-=-=-=- F I L T E R S -=-=-=-=-=-=-=-=-=-=-=-=-=;
;standard 4
ifn	ftgen	1, 0, 4, -2, 0.4829629131445341, 0.8365163037378079, 0.2241438680420134, -0.1294095225512604

;standard 10
ifn	ftgen	2, 0, 16, -2, 0.160102397974, 0.603829269797, 0.724308528438, 0.138428145901, -0.242294887066, -0.032244869585, 0.077571493840, -0.006241490213, -0.012580751999, 0.003335725285 

;standard 12
ifn	ftgen	3, 0, 16, -2, 0.111540743350, 0.494623890398, 0.751133908021, 0.315250351709, -0.226264693965, -0.129766867567, 0.097501605587, 0.027522865530, -0.031582039318, 0.000553842201, 0.004777257511, -0.001077301085 

;coifman 12
ifn	ftgen	4, 0, 16, -2, 1.15875967387, -.02932013798, -.04763959031, .273021046535, .574682393857, .294867193696, -.0540856070917, -.0420264804608, .0167444101633, .00396788361296,-.00128920335614, -.000509505399 

;coifman 6
ifn	ftgen	5, 0, 8, -2, (sqrt(15)-3.0)/32.0, (1.0-sqrt(15))/32.0, (3.0-sqrt(15))/16.0, (sqrt(15)+3.0)/16.0, (sqrt(15)+13.0)/32.0, (9.0-sqrt(15))/32.0 

;mirror filter
ifn	ftgen	6, 0, 16, -7, 0, 16, 0

;size table
ifn	ftgen	7, 0, 8, -2, 4, 10, 12, 12, 6

;seq table
ifn	ftgen	8, 0, 16, -7, 0, 16, 0

gifilt	=	0
gimirr	=	0
gifsz	=	0
gistr	=	0; start of storage area
giseq	=	8; seq table number
giktr	=	0

	zakinit	1, 16384

;=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=;
	instr	1
;=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=;
; MirrorFilter
;=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=;
ifilter	=	p4
imirror	=	6
isztab	=	7
ifiltsz	table	ifilter-1, isztab
indx	=	0
loop:
ifil	table	ifiltsz-indx-1, ifilter
	itablew	(frac((indx+1)/2)==0 ? +1:-1)*ifil, indx, imirror
indx	=	indx+1
	if (indx<ifiltsz) igoto loop
gifilt	=	ifilter
gimirr	=	imirror
gifsz	=	ifiltsz
giktr	=	1
	endin

;=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=;
	instr	2
;=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=;
; FilterTable
;=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=;
;clumsy, but...
iv0	=	p4
iv1	=	p5
iv2	=	p6
iv3	=	p7
iv4	=	p8
iv5	=	p9
iv6	=	p10
iv7	=	p11
iv8	=	p12
iv9	=	p13
iv10	=	p14
iv11	=	p15
iseq	=	giseq
	itablew	iv0, 0, iseq
	itablew	iv1, 1, iseq
	itablew	iv2, 2, iseq
	itablew	iv3, 3, iseq
	itablew	iv4, 4, iseq
	itablew	iv5, 5, iseq
	itablew	iv6, 6, iseq
	itablew	iv7, 7, iseq
	itablew	iv8, 8, iseq
	itablew	iv9, 9, iseq
	itablew	iv10, 10, iseq
	itablew	iv11, 11, iseq
giktr	=	1
	endin

;=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=;
	instr	3
;=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=;
; Toneburst
;=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=;
ivector	=	p4
ivectsz	=	p5
iseqtab	=	giseq
iwavlen	=	p6    ; length of wavelet
i1pos	=	p7    ; position of the single '1'
	igoto	perf
ini:
istart	=	gistr ; start of storage area
ipass	=	-1
iovec	=	istart
ivlen	=	ivectsz
main0:
iivec	=	iovec
iovec	=	iivec+ivlen
ivlen	=	ivlen/2
ipass	=	ipass+1
	if (ivlen>iwavlen) igoto main0
ii	=	0
loop01:
	ziw	(ii==i1pos ? 1:0), iovec+ii
ii	=	ii+1
	if (ii<ivlen) igoto loop01

;=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=;
; AntiConvolve
;=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=;
ifiltsz	=	gifsz ; filter table size
istart	=	0

main:
istp	table	ipass, iseqtab
ipass	=	ipass-1
ifilter	=	(istp==0 ? gifilt:gimirr)
iivec	=	iovec
iovec	=	iivec-ivlen*2
ii	=	0
loop0:
	ziw	0, iovec+ii
ii	=	ii+1
	if (ii<ivlen*2) igoto loop0
ij	=	0
loop1:
ii	=	0
loop2:		;OutVector[(2*j+i)%(2*InVecLen)]+=Filter[i]*InVector[j]
ipos	=	2*ij+ii-int((2*ij+ii)/(2*ivlen))*2*ivlen
i_f	table	ii, ifilter
i_v	zir	iivec+ij
i_vv	zir	iovec+ipos
i_vv	=	i_vv+i_v*i_f
	ziw	i_vv, iovec+ipos
ii	=	ii+1
	if (ii<ifiltsz) igoto loop2
ij	=	ij+1
	if (ij<ivlen) igoto loop1
ivlen	=	ivlen*2
	if (ivlen<ivectsz) igoto main
indx	=	0
imin	=	32767
imax	=	-32768
load:
isig	zir	istart+indx
	if (isig<=imax) igoto next1     ; find maximum and minimum
imax	=	isig                    ; to perform normalization
	igoto	next2
next1:	if (isig>=imin) igoto next2
imin	=	isig
next2:	itablew	isig, indx, ivector
indx	=	indx+1
	if (indx<ivectsz) igoto load
indx	=	0
norm:
isig	table	indx, ivector
isig	=	(isig-imin)/(imax-imin)-.5 ; scale the table to the
	itablew	isig, indx, ivector        ; range [-.5, +.5]
indx	=	indx+1
	if (indx<ivectsz) igoto norm
;=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=;
	rireturn
perf:	if (giktr==0) kgoto end
giktr	=	0
	reinit	ini
end:	endin

;=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=;
	instr	5
;=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=;
; Test : A simple oscilator
;=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=;
ivector	=	p4
iamp	=	p5
ifrq0	=	p6
ifrq1	=	p7

kamp	linseg	0, p3/8 , iamp, 3*p3/4, iamp, p3/8, 0
kfrq	linseg	ifrq0, p3, ifrq1
asig	oscil	kamp, kfrq, ivector

	out	asig

	endin
