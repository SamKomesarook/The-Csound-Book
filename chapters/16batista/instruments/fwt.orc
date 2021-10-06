;=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=;
;=           A Wavelet Transform Instrument            =;
;=         Coded by Pedro A. G. Batista, 1998          =;
;=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=;

sr	=	44100
kr	=	90
ksmps	=	490

;=-=-=-=-=-=-=-=-=-=-=- F I L T E R S -=-=-=-=-=-=-=-=-=-=-=-=-=;
;standard 4
ifn	ftgen	1, 0, 4, -2, 0.4829629131445341, 0.8365163037378079, 0.2241438680420134, -0.1294095225512604

;standard 10
ifn	ftgen	2, 0, 16, -2, 0.160102397974, 0.603829269797, 0.724308528438, 0.138428145901, -0.242294887066, -0.032244869585, 0.077571493840, -0.006241490213, -0.012580751999, 0.003335725285 

;standard 12
ifn	ftgen	3, 0, 16, -2, 0.111540743350, 0.494623890398, 0.751133908021, 0.315250351709, -0.226264693965, -0.129766867567, 0.097501605587, 0.027522865530, -0.031582039318, 0.000553842201, 0.004777257511, -0.001077301085 

;mirror filter
ifn	ftgen	4, 0, 16, -7, 0, 16, 0

;size table
ifn	ftgen	5, 0, 4, -2, 4, 10, 12

gifilt	=	0
gimirr	=	0
gifsz	=	0
gistr	=	0

	zakinit	1, 1535

;=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=;
	instr	1
;=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=;
; InitializeFilters
;=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=;
ifilter	=	p4
imirror	=	4
isztab	=	5
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
	endin

;=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=;
	instr	2
;=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=;
; InitializeSound
;=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=;
ivector	=	p4
isig	=	p5    ; soundin.#
asig	soundin	isig
kndx	=	0
kndx	tablewa	ivector, asig, 0
	endin

;=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=;
	instr	3
;=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=;
; ConvolveDecimate
;=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=;
ivector	=	p4
ivectsz	=	p5
ifilter	=	gifilt; filter table number
imirror	=	gimirr; mirror table number
ifiltsz	=	gifsz ; filter table size
iwavsz	=	p6    ; lowest wavelet size
istart	=	gistr ; start of storage area
	igoto	perf
ini:
indx	=	0
dump:
isig	table	indx, ivector
	ziw	isig, istart+indx
indx	=	indx+1
	if (indx<ivectsz) igoto dump
ivlen	=	ivectsz
iivec	=	istart
iovec	=	iivec+ivlen
main:
ii	=	0
loop1:
ij	=	0
isumh	=	0
isumg	=	0
loop2:
ipos	=	2*ii+ij-int((2*ii+ij)/ivlen)*ivlen
i_h	table	ij, ifilter
i_g	table	ij, imirror
i_v	zir	iivec+ipos
isumh	=	isumh+i_h*i_v
isumg	=	isumg+i_g*i_v
ij	=	ij+1
	if (ij<ifiltsz) igoto loop2
	ziw	isumh, iovec+ii
	ziw	isumg, iovec+(ivlen/2)+ii
ii	=	ii+1
	if (ii<ivlen/2) igoto loop1
iivec	=	iovec
iovec	=	iivec+ivlen
ivlen	=	ivlen/2
	if (ivlen>=iwavsz) igoto main
gilen	=	ivlen
givec	=	iovec-ivlen*2
	rireturn
perf:	reinit	ini
	endin


;=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=;
	instr	5
;=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=;
; AntiConvolve
;=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=;
ivector	=	p4
ivectsz	=	p5
ifilter	=	gifilt; filter table number
imirror	=	gimirr; mirror table number
ifiltsz	=	gifsz ; filter table size
istart	=	gistr ; start of storage area
	igoto	perf
ini:
iovec	=	givec
ivlen	=	gilen
main:
iivec	=	iovec
iovec	=	iivec-ivlen*4
iovec	=	(iovec<istart ? istart:iovec)
ii	=	0
loop0:
	ziw	0, iovec+ii
ii	=	ii+1
	if (ii<ivlen*2) igoto loop0
ij	=	0
loop1:
ii	=	0
loop2:
ipos	=	2*ij+ii-int((2*ij+ii)/(2*ivlen))*2*ivlen
i_h	table	ii, ifilter
i_g	table	ii, imirror
i_v1	zir	iivec+ij
i_v2	zir	iivec+ij+ivlen
i_vv	zir	iovec+ipos
i_vv	=	i_vv+i_v1*i_h+i_v2*i_g
	ziw	i_vv, iovec+ipos
ii	=	ii+1
	if (ii<ifiltsz) igoto loop2
ij	=	ij+1
	if (ij<ivlen) igoto loop1
ivlen	=	ivlen*2
	if (ivlen<ivectsz) igoto main
indx	=	0
load:
isig	zir	istart+indx
	itablew	isig, indx, ivector
indx	=	indx+1
	if (indx<ivectsz) igoto load
	rireturn
perf:	reinit	ini

	endin

;=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=;
	instr	6
;=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=;
; PlaySound
;=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=;
ivector	=	p4
asig	tablera	ivector, 0, 0
	out	asig
	endin


