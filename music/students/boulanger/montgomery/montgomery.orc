sr		=		44100
kr		=		4410
ksmps	=		10
nchnls	=		2

garvb1	init	0
garvb2	init	0
garvb3	init	0
garvb4	init	0
gadist	init	0
gadistb	init	0
gadist2 init	0

;----------------------------------
;			saw ping	  
;----------------------------------


			instr 	1
iamp		=		p4
ifreq		=		p5
iffreq		=		p6
ibw			=		p7
ifdstart	=		p8	
ifdend		=		p9
kpan		line	1, p3, 0
kfdepth		expon	ifdstart, p3, ifdend
kfiltmod	oscil	kfdepth, iffreq, 2
abuzz1		buzz	iamp / 4, ifreq, 100, 1
abuzz2		buzz	iamp / 4, ifreq, 10, 1
abuzz3		buzz	iamp / 4 , ifreq / .99, 100, 1
abuzz4		buzz	iamp / 4, ifreq / .99, 10, 1
amix		=		abuzz1 + abuzz2 + abuzz3 +abuzz4
afilt1		butterlp	amix, kfiltmod, ibw
			outs	afilt1 * kpan , afilt1 * (1 - kpan)
garvb		=		afilt1 * .1
			endin

;----------------------------------
;			bass left
;----------------------------------


			
			instr 	2

iamp		=		p4
ifreq		=		p5
ipndpth 	=		p6
ipnmod		=		p7
istfreq		=		p8
ienfreq		=		p9
ibw			=		p10
kamp		linen	iamp, p3*.035, p3, p3*.04	
kpn			oscil	ipndpth,ipnmod, 1
kfiltmod	line	istfreq ,p3, ienfreq
abuzz1		buzz	kamp / 4, ifreq, 100, 1
abuzz2		buzz	kamp / 4, ifreq, 10, 1
abuzz3		buzz	kamp / 4 , ifreq / .99, 100, 1
abuzz4		buzz	kamp / 4, ifreq / .99, 10, 1
amix		=		abuzz1 + abuzz2 + abuzz3 +abuzz4
afilt		butterlp	amix, kfiltmod, ibw
			outs	afilt, afilt * 0
;garvb		=		garvb+(afilt*.20)
gadist		 = 		gadist  + (afilt *.25)		
			endin
			

;----------------------------------
;			bass right
;----------------------------------

			instr 	3

iamp		=			p4
ifreq		=			p5
ipndpth 	=			p6
ipnmod		=			p7
istfreq		=			p8
ienfreq		=			p9
ibw			=			p10
kamp		linen		iamp, p3*.035, p3, p3*.04	
kpn			oscil		ipndpth,ipnmod, 1
kfiltmod	line		istfreq ,p3, ienfreq
abuzz1		buzz		kamp / 4, ifreq, 100, 1
abuzz2		buzz		kamp / 4, ifreq, 10, 1
abuzz3		buzz		kamp / 4 , ifreq / .99, 100, 1
abuzz4		buzz		kamp / 4, ifreq / .99, 10, 1
amix		=			abuzz1 + abuzz2 + abuzz3 +abuzz4
afilt		butterlp	amix, kfiltmod, ibw
			outs		afilt * 0, afilt 
;garvb		=			garvb+(afilt*.20)			
			endin
			

;----------------------------------
;			noise instr 1
;----------------------------------			


			instr		4
iamp		=			p4
ifreq		=			p5
ileft 		=			p6
iright		=			p7
ibw			=			p8
kamp		linen		iamp, p3*.035, p3, p3*.04	
anoise		randh 		iamp, ifreq
kfmod		line		1000, p3, 100
afilt		butterlp	anoise, kfmod
			outs		afilt * ileft, afilt * iright
			endin
			
			
			
						
;----------------------------------
;			sweeper
;----------------------------------


			instr		5
iamp		=			p4
ifreq		=			p5
ifstart		=			p6
ifend		=			p7
ibw			=			p8
kpan		line		1, p3, 0		
kfmod		line		ifstart, p3, ifend
abuzz1		buzz		iamp, ifreq, 10, 2
abuzz2		buzz		iamp, ifreq / .99, 10, 2
amix		=			abuzz1 + abuzz2
afilt1		butterlp	amix, kfmod, ibw
afilt2		butterlp	afilt1, kfmod, ibw
afilt3		butterlp	afilt2, kfmod, ibw
			outs		afilt3 * (1-kpan) , afilt3 * kpan
garvb3		 = 			afilt3 
garvb4		=			afilt3			
			endin	


			
;----------------------------------
;			hi beep 2 
;----------------------------------


			
			instr 	6

iamp		=		p4
ifreq		=		p5
ipleft	 	=		p6
ipright		=		p7
istfreq		=		p8
ienfreq		=		p9
ibw			=		p10	
kfiltmod	line	istfreq ,p3, istfreq
kamp		linen	iamp, p3*.035, p3, p3*.04	
abuzz1		oscil	iamp / 4, ifreq, 1
abuzz2		oscil	iamp / 4, ifreq, 1
abuzz3		oscil	iamp / 4 , ifreq / .99, 1
abuzz4		oscil	iamp / 4, ifreq / .99, 1
amix		=		abuzz1 + abuzz2 + abuzz3 +abuzz4
afilt		butterlp	amix, kfiltmod, ibw
			outs	afilt * ipleft, afilt * ipright
			
			
;garvb		=		garvb+(afilt*.20)
			endin
			
			
			

;----------------------------------
;			mid synth
;----------------------------------
		

			
			instr 	7

iamp		=		p4
ifreq		=		p5
ipndpth 	=		p6
ipnmod		=		p7
istfreq		=		p8
ienfreq		=		p9
ibw			=		p10
kamp		linen	iamp, p3*.035, p3, p3*.04		
kpn			oscil	ipndpth,ipnmod, 1
kfiltmod	line	istfreq  ,p3, istfreq
abuzz1		buzz	iamp / 4, ifreq , 100, 1, 
abuzz2		buzz	iamp / 4, ifreq , 10, 1,
abuzz3		buzz	iamp / 4 , ifreq / .99, 100, 1
abuzz4		buzz	iamp / 4, ifreq  / .99, 10, 1
amix1		=		abuzz1 + abuzz2 + abuzz3 + abuzz4
		
afilt1		butterlp	amix1, kfiltmod, ibw

			outs	afilt1 * 0, afilt1
;garvb		=		garvb+(afilt*.20)
			endin
			
			
			
			
			
;----------------------------------
;			knocking noise
;----------------------------------			


			instr		8
iamp		=			p4
ifreq		=			p5
ileft 		=			p6
iright		=			p7
ibw			=			p8
ifstart		=			p9
ifend		=			p10
kamp		linen		iamp, p3*.035, p3, p3*.04	
kosc1		oscil		ifreq, 440, 1
kosc2		oscil		ifreq, 10, 1
kfmod		line		ifstart, p3, ifend
anoise1		randh 		iamp, kosc1
anoise2		randh		iamp, kosc2
afilt1		reson		anoise1, kfmod, ibw
afilt2		reson		anoise2, kfmod, ibw
amix		=			afilt1 + afilt2 * .2
			outs		amix * ileft, amix * iright
			endin
			
			


;----------------------------------
;			snare
;----------------------------------			
			
			instr 		9
kampenv4  	linseg  	0, .001, 1,  p3-.021, 1, .02, 0
kptchenv 	linseg 		50, .01, 400, .2, 100, .01, 100
kfmod		line		4000, p3, 4000
asig     	pluck   	p4, kptchenv, 50, 7, 4, .8, 5
anoise		randh 		p4, 10000
afilt		butterlp	anoise, kfmod
afilt2		butterlp	asig, 4000, 100
aout    	=       	(((kampenv4*afilt2) *3) + afilt)

			outs 		aout, aout
gadist		 = 		gadist + (aout *.25)
			endin


			

			
			
;----------------------------------
;			noise kick 
;----------------------------------			


			instr		10
iamp		=			p4
ifreq		=			p5
ileft 		=			p6
iright		=			p7
ibw			=			p8
kfmod		line		880, p3, 440
kmod1		expon		440, .05, 55
kmod2		line		iamp, p3, 10
kmod3		line		iamp, p3, 100
abuzz		oscil		kmod3, 55, 1
anoise		randh 		kmod2, ifreq
aosc		oscil		kmod2, kmod1, 1
afilt		butterlp	anoise + (aosc * 2) + (abuzz * 7), kfmod
			outs		afilt * ileft, afilt * iright
gadist		 = 		gadist + (afilt *.25)			
			endin
			
			


;----------------------------------
;			wow bass
;----------------------------------			
			
			instr		11
iamp		=			p4
ifreq		=			p5
ifstart		=			p6
ifend		=			p7
ibw			=			p8
kamp		linen		iamp, p3*.035, p3, p3*.04	
kfiltmod	linseg		ifstart * .6, p3*.1, ifstart, p3*.9, ifend + (ifend *.2), p3*.1, ifend
asaw1		oscil		kamp, ifreq	, 6, 
asaw2		oscil		kamp, ifreq/.99, 6
afilt1		reson		asaw1, kfiltmod, ibw
afilt2		reson		asaw2, kfiltmod, ibw
amix		=			afilt1 + afilt2


			outs		amix, amix * 0
gadist		 = 		gadist + (amix *.25)			
			endin

			
			
			
;----------------------------------
;			noise snare 2
;----------------------------------		



	


			instr		12
iamp		=			p4
ifreq		=			p5
ileft 		=			p6
iright		=			p7
ibw			=			p8
anoise		randh 		iamp, ifreq
kfmod		line		4000, p3, 2000
afilt		butterlp	anoise, kfmod
			outs		afilt * ileft, afilt * iright
			endin
			
			
			




;----------------------------------
;			grainy-type instrument
;----------------------------------



			instr 		13
iamp		=			p4
ifreq		=			p5
kamp		linen		iamp, p3*.005, p3, p3*.005
ktrem1		oscil		880, 8, 1
ktrem2		oscil		880, 5, 1
aflut1		buzz		kamp, ifreq , 15, 1
aflut2		buzz		kamp, ifreq / .99 , 1, 1
afilt1		butterlp	aflut1, ktrem1, 100
afilt2		butterlp	aflut1, ktrem2, 100
afilt1b		butterlp	aflut2, ktrem1, 100
afilt2b		butterlp	aflut2, ktrem2, 100
amix1		=			afilt1 + afilt1b
amix2		=			afilt2 + afilt2b
afilt3		butterhp	amix1, 300, 100
afilt4		butterhp	amix2,	300, 100
afilt5		butterhp	afilt3, 300, 100
afilt6		butterhp	afilt4, 300, 100
afilt7		butterlp	afilt5, 1000, 100
afilt8		butterlp	afilt6,	1000, 100
			outs		afilt7 *.4 , afilt8 *.4 
garvb1		 = 			afilt7 *.25 
garvb2		=			afilt8 *.25 		
gadist		 = 		gadist + (afilt7 *.25)				
			endin

;----------------------------------
;			hi hat
;----------------------------------

		instr 		14
ibal	=			p4
k1		expon		20000, .25, 2500
a0		expon		150, .25, 10
a1		rand		a0
a3		butterlp	a1,k1
a4		butterlp	a3,k1
a5		butterhp	a4,3500
a6		butterhp	a5,3500
a8		linen		(a6+a1),0,p3, .05  

		outs 		a8, a8
gadist		 = 		gadist + (a8 *.25)		
		endin
			
			
;----------------------------------
;			sweeper
;----------------------------------


			instr		15
iamp		=			p4
ifreq		=			p5
ifstart		=			p6
ifend		=			p7
ibw			=			p8
kpan		line		1, p3, 0		
kfmod		line		ifstart, p3, ifend
abuzz1		buzz		iamp, ifreq, 10, 2
abuzz2		buzz		iamp, ifreq / .99, 10, 2
amix		=			abuzz1 + abuzz2
afilt1		butterlp	amix, kfmod, ibw
afilt2		butterlp	afilt1, kfmod, ibw
afilt3		butterlp	afilt2, kfmod, ibw
			outs		afilt3 , afilt3
			
			endin				
			
			

;----------------------------------
;			rising noise
;----------------------------------
			instr		16
iamp		=			p4
iopen		=			p5  			;.1 closed /1 open
iffreq		=			p6
ileft		=			p7
iright		=			p8
kramp		expon		iamp, p5, 10
ahihat		rand		kramp
afilt1		reson		ahihat,	iffreq, 100
afilt2		butterlp	afilt1,	iffreq, 100
afilt3		butterlp	afilt2,	iffreq, 100
			outs 		afilt3 * ileft, afilt3 *iright
gadist		 = 		gadist + (afilt3 *.25)			
			endin



;----------------------------------
;			end hiss
;----------------------------------

			instr		17
iamp		=			p4
iopen		=			p5  			;.1 closed /1 open
iffreq		=			p6
ileft		=			p7
iright		=			p8
kramp		expon		iamp, p5, 10
ahihat		rand		kramp
afilt1		butterlp	ahihat,	iffreq, 100
			outs 		afilt1 * ileft, afilt1 *iright
gadist		 = 		gadist + (afilt1 *.25)				
			endin
			
;----------------------------------
;			
;----------------------------------

			instr 		18
iamp 		= 			p4
ifreq 		= 			p5
kamp		linseg		iamp *. 01, p3 *.005, iamp, p3*.85, 0

kfiltmod	line		880, p3, 1000
apluck1		pluck 		kamp, ifreq, ifreq, 0, 1
apluck2		pluck 		kamp, ifreq /.99, ifreq / .99, 0, 1
afilt1		reson		apluck1, kfiltmod, 100
afilt2		reson		apluck2, kfiltmod, 100
			outs		afilt1, afilt2

			endin

;----------------------------------
;			end noise1
;----------------------------------


			instr	19
kamp		expon	10, p3, 3000
anoise1		randh	kamp, 5000
anoise2		randh	kamp, 5000 /.99
			outs	anoise1, anoise2
gadist		 = 		gadist + (anoise1 *.25)				
			endin


;----------------------------------
;			end noise2
;----------------------------------


			instr	23
kamp		expon	10, p3, 1000
anoise1		randh	kamp, 5000
anoise2		randh	kamp, 5000 /.99
			outs	anoise1, anoise2
gadist		 = 		gadist + (anoise1 *.25)				
			endin
;----------------------------------
;			end noise3
;----------------------------------


			instr	24
kamp		expon	1000, p3, 8000
anoise1		randh	kamp, 5000
anoise2		randh	kamp, 5000 /.99
			outs	anoise1, anoise2
gadist		 = 		gadist + (anoise1 *.25)				
			endin



;----------------------------------
;			hi beep 2 
;----------------------------------


			
			instr 	21

iamp		=		p4
ifreq		=		cpspch(p5)
ifreqmod 	=		p6
ibw			=		p7	
iharm		=		p8
abuzz1		buzz		iamp,ifreq, iharm, 1
abuzz2		buzz		iamp, ifreq / .99,iharm, 1
afilt1		butterbp	abuzz1, ifreqmod, ibw
afilt2		butterbp	abuzz2, ifreqmod, ibw
			outs		afilt1 *7 , afilt1 *0
gadist		= 			gadist + (afilt1 *.25)			
garvb3		=	afilt1
garvb4		=	afilt1
			endin


;kamp		linen		iamp, p3*.035, p3, p3*.6	
;garvb3		=	(afilt*.1)
;garvb4		=	(afilt*.1)
;abuzz3		buzz	iamp / 4 , ifreq / .99,iharm, 1			


;----------------------------------
;			hi beep 2 
;----------------------------------


			
			instr 	22

iamp		=		p4
ifreq		=		cpspch(p5)
ifreqmod 	=		p6
ibw			=		p7	
iharm		=		p8
abuzz1		buzz		iamp,ifreq, iharm, 1
abuzz2		buzz		iamp, ifreq / .99,iharm, 1
afilt1		butterbp	abuzz1, ifreqmod, ibw
afilt2		butterbp	abuzz2, ifreqmod, ibw
			outs		afilt1 *0 , afilt1 *4
gadist		= 			gadist + (afilt1 *.25)			
;garvb3		=	(afilt*.1)
;garvb4		=	(afilt*.1
			endin


;kamp		linen		iamp, p3*.035, p3, p3*.6	
;garvb3		=	(afilt*.1)
;garvb4		=	(afilt*.1)
;abuzz3		buzz	iamp / 4 , ifreq / .99,iharm, 1			
;----------------------------------
;			reverb
;----------------------------------


			instr	98
irvbtim		=		p4
arvb1		reverb2	garvb1, irvbtim, 1
arvb2		reverb2	garvb2, irvbtim, .9
			outs	arvb1, arvb2
garvb		=		0
			endin


			
;----------------------------------
;			distortion
;----------------------------------



			instr 	99
iprest 		=		p4
iprend 		=		p5
iposta 		=	 	p6
ipoend 		=	 	p7
ishap1 		=	 	p8
ishap2 		=	 	p9
kpre		line	iprest, p3, iprend
kpost		line	iposta, p3, ipoend
aout1		distort1 	gadist, kpre, kpost, ishap1, ishap2
			outs 	aout1, aout1
gadist 		= 		0
gadistb 	= 		0
			endin
			
			
			
;----------------------------------
;			reverb
;----------------------------------


			instr	100
irvbtim		=		p4
arvb1		reverb2	garvb3, irvbtim, 1
arvb2		reverb2	garvb4, irvbtim, .9
			outs	arvb1, arvb2
garvb3		=		0
garvb4		=		0

			endin
			



;----------------------------------
;			distortion 2
;----------------------------------



			instr 	101
ipre 		=		p4
ipost 		=	 	p5
ishap1 		=	 	p6
ishap2 		=	 	p7
aout 		distort1 	gadist2, ipre, ipost, ishap1, ishap2
			outs 	aout, aout
gadist2 		= 		0
			endin
			




