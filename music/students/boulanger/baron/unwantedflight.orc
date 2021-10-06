; "Unwanted Flight"	 Severine Baron (Berklee College of Music. Spring 1998. Dr Boulanger's Csound Class.)


sr		=		44100
kr		=		4410
ksmps	=		10
nchnls	=		2



		instr 4

gkpit	rand		.02
gkpit2	rand		.02, .2345
		endin

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


		instr 1, 2, 5

ilast	=		2
iseed	=		p6
ivib		=		.015*iseed
ivoi		=		p8
krik		rand		8, .38413*iseed
kpik		rand		2, .5765*iseed

newvalue:

idu		table	i(krik)	, 34, 0, 0, 1
ipi		table	i(kpik+ilast), 33, 0, 0, 1
kpi		=		cpspch(ipi+p11)
ipo		=		cpspch(ipi+p11)
kvibenv	expseg	ipo*.001, 1.5, ipo*ivib, idu-2, ipo*ivib, .5,  ipo*.015
kbend	rand		.3, .629876*iseed
kford	rand		1.5, .876*iseed
ibend	=		i(kbend+.33)*i(kbend+.33)+.02
igli		=		(idu/2)+.2
ishifsp	=		(i(kford+1.5)*i(kford+1.5)/idu)+.2
ilast	=		i(kpik+ilast)

		timout	0, idu, go
		reinit	newvalue
		rireturn
go:
gkpi		port		kpi, .03, cpspch(ipi+p11)
kam		randh	.25, 1, .46543*iseed
gkam		port		kam+.75, .5, p7


kshif	randh	5, ishifsp, -.4478*iseed
kshif	=		int(kshif+5)*9
	
kind		=		kshif
kif0		=		gkpi *(1+i(gkpit))
kif02	=		gkpi *(1+i(gkpit2))
iind		=		(p5*9)-9

ifif1	table	iind, ivoi, 0
ifif2	table	iind+1, ivoi, 0
ifif3	table	iind+2, ivoi, 0
iria1	table	iind+3, ivoi, 0
iria2	table	iind+4, ivoi, 0
iria3	table	iind+5, ivoi, 0

kdev1	table	kind+6, ivoi, 0
kdev2	table	kind+7, ivoi, 0
kdev3	table	kind+8, ivoi, 0

kdev1	randh	kdev1/2, ishifsp, .0980*iseed
kdev2	randh	kdev2/2, ishifsp, .6983*iseed
kdev3	randh	kdev3/2, ishifsp, .4*iseed
	
kfif1	table	kind, ivoi, 0
kfif2	table	kind+1, ivoi, 0
kfif3	table	kind+2, ivoi, 0
kria1	table	kind+3, ivoi, 0
kria2	table	kind+4, ivoi, 0
kria3	table	kind+5, ivoi, 0

kif1		port		kfif1+kdev1, igli, ifif1
kif2		port		kfif2+kdev2, igli, ifif2
kif3		port		kfif3+kdev3, igli, ifif3
kia1		port		kria1-10, igli, iria1
kia2		port		kria2, igli, iria2
kia3		port		kria3, igli, iria3

krandvib	randi	.15, 1.5, iseed*.123
krandvib2 randi	.14, 1.7, iseed*.1423
; kvibenv			expseg  p4*.001, 1.5, p4*ivib, p3-.35, p4*ivib, 1, p4*.015
kvib		oscil	kvibenv, 5.5*(1+krandvib), 1
kvib2	oscil	kvibenv, 5.6*(1+krandvib2), 1	    

kenv		linseg	0.001, .1+p3*.1, 1, p3-(.2+p3*.15), 1, .1+p3*.05, 0.001

kdev		randi	.01, 12, iseed*.765
kdev		=		1+kdev
kdev2	randi	.01, 13, iseed*.8765
kdev2	=		1+kdev2

kpit		linseg	.95, .1, 1, p3-.2, 1, .1, 0.95

ar		fof		ampdb(kia1)*kenv*gkam, kdev*kif0*kpit+kvib,	 kif1,   .0,	50,	 .003, .01, .007, 50, 1, 2, p3
ar1		fof		ampdb(kia2)*kenv*gkam*gkam,  kdev*kif0*kpit+kvib,	  kif2,	.0,	 100, .003, .01, .007, 50, 1, 2, p3
ar2		fof		ampdb(kia3)*kenv*gkam*gkam*gkam, kdev*kif0*kpit+kvib,	 kif3,   .0,	150, .003, .01, .007, 50, 1, 2, p3
ar3		fof		ampdb(kia3)*kenv*gkam*gkam*gkam*.7, kdev*kif0*kpit+kvib,   kif3+1000,	  .0,   150, .003, .01, .007, 50, 1, 2, p3

ag		fof		ampdb(kia1)*kenv*gkam, kdev2*kif02*kpit+kvib2,   kif1,	  .0,   50,   .003, .01, .007, 50, 1, 2, p3
ag1		fof		ampdb(kia2)*kenv*gkam*gkam, kdev2*kif02*kpit+kvib2,   kif2,	  .0,   100, .003, .01, .007, 50, 1, 2, p3
ag2		fof		ampdb(kia3)*kenv*gkam*gkam*gkam, kdev2*kif02*kpit+kvib2,   kif3,	  .0,   150, .003, .01, .007, 50, 1, 2, p3
ag3		fof		ampdb(kia3)*kenv*gkam*gkam*gkam*.7, kdev2*kif02*kpit+kvib2,	  kif3+1000,	.0,	 150, .003, .01, .007, 50, 1, 2, p3


		outs		(ar+ar1+ar2)+ar3, (ag+ag1+ag2)+ag3
		endin


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


		instr 15

kmod		expseg	p5, .0151, p5*.06, p3*0.9, .005
asid		foscil	ampdb(p5), cpspch(p4), 2.380, 3.667, kmod, 1
asid2	foscil	ampdb(p5), cpspch(p4+.005), 2.383, 3.767, kmod, 1
agon		expseg	0.001, .0151, 1, .1, .7, p3*0.9, .005
		outs		(asid)*agon, asid2*agon
		endin


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


		instr 17

gkpit	rand		.02
gkpit2	rand		.02, .2345
		endin



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


		instr 8, 9, 11

ilast	=		2
iseed	=		p6
ivib		=		.015*iseed
ivoi		=		p8
krik		rand		8, .38413*iseed
kpik		rand		2, .5765*iseed

newvalue:

idu	   	table	i(krik)	 , 34, 0, 0, 1
ipi	   	table	i(kpik+ilast), 33, 0, 0, 1
kpi	   	=	  	cpspch(ipi+p11)
ipo	   	=		cpspch(ipi+p11)
kvibenv 	expseg  	ipo*.001, 1.5, ipo*ivib, idu-2, ipo*ivib, .5,	 ipo*.015
kbend	rand    	.3, .629876*iseed
kford	rand    	1.5, .876*iseed
ibend	=	    	i(kbend+.33)*i(kbend+.33)+.02
igli	 	=	    	(idu/2)+.2
ishifsp 	=	    	(i(kford+1.5)*i(kford+1.5)/idu)+.2
ilast	 =	    	i(kpik+ilast)

		timout  	0, idu, go
		reinit 	newvalue
		rireturn
go:
gkpi		port	 	kpi, .03, cpspch(ipi+p11)
kam		randh	.25, 1, .46543*iseed
gkam		port	 	kam+.75, .5, p7


kshif   	randh	5, ishifsp, -.4478*iseed
kshif   	=		int(kshif+5)*9

kind	   	=		kshif
kif0	   	=		gkpi *(1+i(gkpit))
kif02   	=		gkpi *(1+i(gkpit2))
iind	   	=		(p5*9)-9

ifif1   	table	iind, ivoi, 0
ifif2   	table	iind+1, ivoi, 0
ifif3   	table	iind+2, ivoi, 0
iria1   	table	iind+3, ivoi, 0
iria2   	table	iind+4, ivoi, 0
iria3   	table	iind+5, ivoi, 0

kdev1   	table	kind+6, ivoi, 0
kdev2   	table	kind+7, ivoi, 0
kdev3   	table	kind+8, ivoi, 0

kdev1   	randh	kdev1/2, ishifsp, .0980*iseed
kdev2   	randh	kdev2/2, ishifsp, .6983*iseed
kdev3   	randh	kdev3/2, ishifsp, .4*iseed

kfif1   	table	kind, ivoi, 0
kfif2   	table	kind+1, ivoi, 0
kfif3   	table	kind+2, ivoi, 0
kria1   	table	kind+3, ivoi, 0
kria2   	table	kind+4, ivoi, 0
kria3   	table	kind+5, ivoi, 0

kif1	   	port	 	kfif1+kdev1, igli, ifif1
kif2	   	port	 	kfif2+kdev2, igli, ifif2
kif3	   	port	 	kfif3+kdev3, igli, ifif3
kia1	   	port	 	kria1-10, igli, iria1
kia2	   	port	 	kria2, igli, iria2
kia3	   	port	 	kria3, igli, iria3

krandvib	randi   	.15, 1.5, iseed*.123
krandvib2	randi   	.14, 1.7, iseed*.1423
; kvibenv	expseg  	p4*.001, 1.5, p4*ivib, p3-.35, p4*ivib, 1, p4*.015
kvib	  	oscil	kvibenv, 5.5*(1+krandvib), 1
kvib2   	oscil	kvibenv, 5.6*(1+krandvib2), 1	

kenv	 	linseg	0.001, .1+p3*.1, 1, p3-(.2+p3*.15), 1, .1+p3*.05, 0.001

kdev	   	randi	.01, 12, iseed*.765
kdev	   	=		1+kdev
kdev2   	randi	.01, 13, iseed*.8765
kdev2   	=		1+kdev2

kpit	   	linseg	.95, .1, 1, p3-.2, 1, .1, 0.95

ar	   	fof	 	ampdb(kia1)*kenv*gkam,			   kdev*kif0*kpit+kvib,	 kif1,   .0,	50,	 .003, .01, .007, 50, 1, 2, p3
ar1	   	fof	 	ampdb(kia2)*kenv*gkam*gkam,		  kdev*kif0*kpit+kvib,	kif2,   .0,   100, .003, .01, .007, 50, 1, 2, p3
ar2	   	fof	 	ampdb(kia3)*kenv*gkam*gkam*gkam,	 kdev*kif0*kpit+kvib,   kif3,	  .0,   150, .003, .01, .007, 50, 1, 2, p3
ar3	   	fof	 	ampdb(kia3)*kenv*gkam*gkam*gkam*.7,   kdev*kif0*kpit+kvib,	  kif3+1000,	.0,	 150, .003, .01, .007, 50, 1, 2, p3

ag	   	fof	 	ampdb(kia1)*kenv*gkam,			   kdev2*kif02*kpit+kvib2,   kif1,	  .0,   50,   .003, .01, .007, 50, 1, 2, p3
ag1	   	fof	 	ampdb(kia2)*kenv*gkam*gkam,		  kdev2*kif02*kpit+kvib2,   kif2,	 .0,	  100, .003, .01, .007, 50, 1, 2, p3
ag2	   	fof	 	ampdb(kia3)*kenv*gkam*gkam*gkam,	 kdev2*kif02*kpit+kvib2,	  kif3,	.0,	 150, .003, .01, .007, 50, 1, 2, p3
ag3	   	fof	 	ampdb(kia3)*kenv*gkam*gkam*gkam*.7,   kdev2*kif02*kpit+kvib2,	kif3+1000,   .0,   150, .003, .01, .007, 50, 1, 2, p3


		outs	   	((ar+ar1+ar2)+ar3)*.9, ((ag+ag1+ag2)+ag3)*.9
	   	endin


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


		instr 16

kmod	   	expseg	p5, .0151, p5*.06, p3*0.9, .005
asid	   	foscil	ampdb(p5), cpspch(p4), 2.380, 3.667, kmod, 1
asid2   	foscil	ampdb(p5), cpspch(p4+.005), 2.383, 3.767, kmod, 1
agon	   	expseg	0.001, .0151, 1, .1, .7, p3*0.9, .005
		outs	   	(asid)*agon, asid2*agon
	   	endin


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



		instr    7

iamp		=	   	p4
ipitch   	=	   	cpspch(p5)
ipanhz   	=	   	p6
irandhz  	=	   	p7
iminhz   	=	   	p8
imaxhz   	=	   	p9
idepth   	=	   	p10
igatefn  	=	   	p11
irise    	=	   	p12
idecay   	=	   	p13
iseed    	=	   	p14
ivaramp  	=	   	iamp*idepth
iminamp  	=	   	iamp-ivaramp
kpanfac  	randi	.5,ipanhz,iseed
kpanfac  	=	   	.5+kpanfac						
kvarhz   	randi	imaxhz-iminhz,irandhz,iseed
kgate    	oscili   	idepth,iminhz+kvarhz,igatefn,0		
kenv	    	expseg   	.01,irise,1,p3-irise-idecay,1,idecay,.001
asig	    	oscili   	(iminamp+ivaramp*kgate)*kenv,ipitch,1
kleft    	=	   	sqrt(kpanfac)
kright   	=	   	sqrt(1-kpanfac)
		outs		(asig*kleft)*.8,(asig*kright)*.8
	    	endin



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;



		instr 23			; THANK YOU FOR INSPIRATION FROM CECILIA...



irvt 	= 		2.0					; REVERB TIME OF THIS ROOM (S)
irvl 	= 		0.2					; REVERB LEVEL AT REFERENCE POINT (1 M)
imaxdist 	= 		100.0				; MAXIMUM DISTANCE OF SOURCE (M)

imaxdel 	= 		imaxdist / 343 		; MAXIMUM DELAY TIME (SAMPLES) 

adist 	linseg 	30, 3, 2, 6, 2, 3, 60
atheta 	linseg 	0, 3, 1, 6, 10, 3, 11
asound1 	buzz 	10000, 220, 5, 1
asound 	soundin 	"sev.aif"

adistdel 	= 		adist/343

aspam 	delayr 	imaxdel

adirect 	deltapi 	adistdel

aleft 	deltapi 	adistdel-0.1*sin(atheta)/343 
aright 	deltapi 	adistdel+0.1*sin(atheta)/343 

		delayw 	asound/adist

arevb 	reverb 	adirect*sqrt(adist)*irvl, irvt 

aleftout 	= 		aleft*(1+sin(atheta))/2 + arevb 
arightout =		aright*(1-sin(atheta))/2 + arevb 
		
		outs 	aleftout, arightout

		endin


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


		instr 3

ifunc 	= 		p11					; BASIC WAVEFORM
irel 	= 		.01					;VIBRATO RELEASE TIME
idel1 	= 		p3 - (p10 * p3)		; CALCULATE INITIAL DELAY (% OF DUR)
isus	  	= 		p3 - (idel1- irel)		; CALCULATE REMAINING DURATION
			   
iamp 	= 		ampdb(p4)
iscale 	= 		iamp * .333			; p4=AMP
inote 	= 		cpspch(p5)			; p5=FREQ
			    
k3	 	linseg  	0, idel1, p9, isus, p9, irel, 0 ; p6=ATTACK TIME
k2	 	oscil   	k3, p8, 1				; p7=RELEASE TIME
k1	 	linen   	iscale, p6, p3, p7		; p8=VIB RATE
a3	 	oscil   	k1, inote*.999+k2, ifunc	; p9=VIB DEPTH
a2	 	oscil   	k1, inote*1.001+k2, ifunc ; p10=VIB DELAY (0-1)
a1	 	oscil   	k1, inote+k2, ifunc
    	
    		outs		a1+a2+a3, a1+a2+a3
    
		endin



;-)
