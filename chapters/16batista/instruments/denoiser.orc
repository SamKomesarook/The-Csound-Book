;=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-;
;          A modest denoiser using the FWT           ;
;           Coded by Pedro Batista, 1998             ;
;=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-;

sr	=	44100
kr	=	6
ksmps	=	7350

;=-=-=-=-=-=-=-=-=-=-=- F I L T E R S -=-=-=-=-=-=-=-=-=-=-=-=-=;
;standard 4
ifn	ftgen	1, 0, 4, -2, 0.4829629131445341, 0.8365163037378079, 0.2241438680420134, -0.1294095225512604

;standard 10
ifn	ftgen	2, 0, 16, -2, 0.160102397974, 0.603829269797, 0.724308528438, 0.138428145901, -0.242294887066, -0.032244869585, 0.077571493840, -0.006241490213, -0.012580751999, 0.003335725285 

;standard 12
ifn	ftgen	3, 0, 16, -2, 0.111540743350, 0.494623890398, 0.751133908021, 0.315250351709, -0.226264693965, -0.129766867567, 0.097501605587, 0.027522865530, -0.031582039318, 0.000553842201, 0.004777257511, -0.001077301085 

;mirror filter
ifn	ftgen	4, 0, 16, -7, 0, 16, 0
gimirr	=	4

;size table
ifn	ftgen	5, 0, 4, -2, 4, 10, 12
giszt	=	5

;vector table
ifn	ftgen	6, 0, 8192, -7, 0, 8192, 0
givect	=	6

givecsz	=	8192

gistrw	=	0

	zakinit	1, 8192

;=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=;
	instr	1; InitializeFilters
;=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=;
ifilter	=	p4
ifiltsz	table	ifilter-1, giszt
indx	=	0
loop:
ifil	table	ifiltsz-indx-1, ifilter
	itablew	(frac((indx+1)/2)==0 ? +1:-1)*ifil, indx, gimirr
indx	=	indx+1
	if (indx<ifiltsz) igoto loop
gifilt	=	ifilter
gifilsz	=	ifiltsz
	endin

;=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=;
	instr	2; InitializeSound
;=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=;
isig	=	p4
asig	soundin	isig
kndx	=	0
kndx	tablewa	givect, asig, 0
	endin

;=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=;
	instr	3; ConvolveDecimate
;=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=;
iwavsz	=	p4
	igoto	perf
ini:
ivector	=	givect
ivlen	=	givecsz
main:
ii	=	0
loop1:
ij	=	0
isumh	=	0
isumg	=	0
loop2:
ipos	=	2*ii+ij-int((2*ii+ij)/ivlen)*ivlen
i_h	table	ij, gifilt
i_g	table	ij, gimirr
i_v	table	ipos, ivector
isumh	=	isumh+i_h*i_v
isumg	=	isumg+i_g*i_v
ij	=	ij+1
	if (ij<gifilsz) igoto loop2
	ziw	isumh, gistrw+ii
	ziw	isumg, gistrw+(ivlen/2)+ii
ii	=	ii+1
	if (ii<ivlen/2) igoto loop1
indx	=	0
load:
isig	zir	gistrw+indx
	itablew	isig, indx, ivector
indx	=	indx+1
	if (indx<ivlen) igoto load
ivlen	=	ivlen/2
	if (ivlen>=iwavsz) igoto main
gilen	=	ivlen
	rireturn
perf:	reinit	ini
	endin

;=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=;
	instr	4; Shrinkage
;=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=;
isigma	=	p4
ivector	=	givect
ithrsh	=	sqrt(2*log(givecsz))*(isigma/sqrt(givecsz))

kndx	=	0
loop:
kcoef	table	kndx, ivector
knew	=	(kcoef==0 ? +1:kcoef/abs(kcoef))
knew	=	knew*(abs(kcoef)>ithrsh ? abs(kcoef)-ithrsh:0)
	tablew	knew, kndx, ivector
kndx	=	kndx+1
	if (kndx<givecsz) kgoto loop
	endin

;=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=;
	instr	5; AntiConvolve
;=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=;
	igoto	perf
ini:
ivector	=	givect
ivlen	=	gilen
main:
ii	=	0
loop0:
	ziw	0, gistrw+ii
ii	=	ii+1
	if (ii<ivlen*2) igoto loop0
ij	=	0
loop1:
ii	=	0
loop2:
ipos	=	2*ij+ii-int((2*ij+ii)/(2*ivlen))*2*ivlen
i_h	table	ii, gifilt
i_g	table	ii, gimirr
i_v1	table	ij, ivector
i_v2	table	ij+ivlen, ivector
i_vv	zir	gistrw+ipos
i_vv	=	i_vv+i_v1*i_h+i_v2*i_g
	ziw	i_vv, gistrw+ipos
ii	=	ii+1
	if (ii<gifilsz) igoto loop2
ij	=	ij+1
	if (ij<ivlen) igoto loop1
indx	=	0
load:
isig	zir	gistrw+indx
	itablew	isig, indx, ivector
indx	=	indx+1
	if (indx<ivlen*2) igoto load
ivlen	=	ivlen*2
	if (ivlen<givecsz) igoto main
	rireturn
perf:	reinit	ini

	endin

;=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=;
	instr	6; PlaySound
;=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=;
asig	tablera	givect, 0, 0
	out	asig
	endin
