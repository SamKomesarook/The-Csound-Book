;	SONATA FOR PIANO, VIOLIN AND WHISPER
;	JAHWAN KOO

sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         2


garvb1	  init		0
garvb2	  init		0


;	RESONANT, FEEDBACK SOUND		  
		instr	2
iamp	=		p4*32000
ifq		=		p5
ifun	=		p7		
icar	=		p8
imod	=		p9
indx1	=		p10
indx2	=		p11
imaxdel	=		p12
kenv	linseg	0, 2, 1, p3-(p3/5+2.1), 1, p3/5, 0, .1, 0
kindx	expseg	indx1, p3/3, indx2, p3/3, indx2, p3/3, indx1
kpan	oscil	.5,	.2, 1
kfq2	expseg	.1, p3/3*2, 2, p3/3, .01
klfo2	oscil	1, kfq2, ifun
kenv2	linseg	0, p3/2, 1, p3/2, 0
klfo3	oscil	kenv2, 2.1-klfo2, 1
kfqenv	oscil	.2, 2/p3, 1
asig1	foscil	(iamp*(1+kfqenv))*kenv, ifq*(1+kfqenv), icar, imod, kindx, ifun
aswpt	reson	asig1, ifq*(2-klfo2)*2, ifq/10
adel1	vdelay	asig1, klfo3, imaxdel
adel2	vdelay	adel1, klfo3, imaxdel
adel3	vdelay	adel2, klfo3, imaxdel
adel4	vdelay	adel3, klfo3, imaxdel
amix	=		(asig1+(aswpt/3)+adel1+adel2+adel3+adel4)*2
		outs	amix*(.5+kpan), amix*(.5-kpan)
garvb1	  =			garvb1+amix*.7		  
garvb2	  =			garvb2+amix*.7
		endin



;	"LINE" INSTRUMENT FOR PIANO
			instr		3 						

ifn			=			p6                          				                               
imethod		=			p9
ilength		=			ftlen(ifn)
isampfreq	=			p4 * (sr/ilength)	
iamp		=			p5 * 32000
klfo		oscil		p7, p8, p9
kenv		linseg		0, .1, 1, p3/3, .8, p3/3*2-5.1, .8, 5, 0
asig		oscili		kenv*iamp, isampfreq+klfo, ifn
kq1     	expseg		.01, 40, 1, p3, .01     
kq			=			kq1 * 500
kfreq   	linseg		0, 40, 2000 * p4, p3 - 2, 300, p3, 0
afilt   	reson   	asig, kfreq, kq, 1
adelay1 	delay   	afilt, .6
kfreq2  	linseg  	3000 * p4, 40, 0, p3 - 2, 2500 * p4, p3, 0
afilt2  	reson   	asig, kfreq2, kq, 1
adelay2 	delay   	afilt2, .6
aleft		=			(afilt + adelay2) * 2
aright		=			(afilt2 + adelay1) * 2
			outs    	aleft, aright
garvb1		=			garvb1+aleft*.7	
garvb2		=			garvb2+aright*.7			
			endin


;	"LINE" INSTRUMENT FOR VIOLIN
			instr		4

ifn			=			p6                              				                               
imethod		=			p9
ilength		=			ftlen(ifn)
isampfreq	=			p4 * (sr/ilength)	
iamp		=			p5 * 32000
klfo		oscil		p7, p8, p9
kenv		linseg		0, 2, 1, p3-7, 1, 4.9, 0, .1, 0
asig		oscili		kenv*iamp, isampfreq+klfo, ifn
kq1     	expseg		.01, 40, 1, p3, .01     
kq			=			kq1 * 500
kfreq   	linseg		0, 40, 2000 * p4, p3 - 2, 300, p3, 0
afilt   	reson   	asig, kfreq, kq, 1
adelay1 	delay   	afilt, .6
kfreq2  	linseg  	3000 * p4, 40, 0, p3 - 2, 2500 * p4, p3, 0
afilt2  	reson   	asig, kfreq2, kq, 1
adelay2 	delay   	afilt2, .6
aleft		=			(afilt + adelay2) * 2
aright		=			(afilt2 + adelay1) * 2
			outs    	aleft, aright
garvb1		=			garvb1+aleft*.7	
garvb2		=			garvb2+aright*.7			
			endin


;	"LINE" INSTRUMENT FOR WHISPER
			instr		5
ifn			=			p6
imethod		=			p9
ilength		=			ftlen(ifn)
isampfreq	=			p4 * (sr/ilength)	
iamp		=			p5 * 32000
klfo		oscil		p7, p8, p9
kenv		linseg		0, 3, 1, p3-8, 1, 5, 0
asig		oscili		kenv*iamp, isampfreq/3+klfo, ifn
kq1     	expseg		.01, 40, 1, p3, .01     
kq			=			kq1 * 500
kfreq   	linseg		100, 40, 1500 * p4, p3 - 2, 200, p3, 1000
afilt   	reson   	asig, kfreq, kq, 1
adelay1 	delay   	afilt, .6
kfreq2  	linseg  	1500 * p4, 40, 100, p3 - 2, 1000 * p4, p3, 0
afilt2  	reson   	asig, kfreq2, kq, 1
adelay2 	delay   	afilt2, .6
aleft		=			(afilt + adelay2) * 2
aright		=			(afilt2 + adelay1) * 2
			outs    	aleft, aright
garvb1		=			garvb1+aleft*.7	
garvb2		=			garvb2+aright*.7			
			endin
			
						
			instr		100
arvb1		reverb2		garvb1, 5, .7
arvb2		reverb2		garvb2, 5, .7
			outs		(arvb1+arvb2)/2, (arvb1+arvb2)/2
garvb1		=			0
garvb2		=			0
			endin			
			
