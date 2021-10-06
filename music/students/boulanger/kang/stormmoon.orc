;Storm Moon by Juno Kang - Fall,1999
;Composed for The Csound Book, Edited by Dr. Richard Boulanger
;juno@csounds.com
;http://listen.to/theMoonsTory/

;This composition takes 54 mins to compute on Macintosh G3/300

;Stereo Header

sr			=			44100
kr			=			44100 			; kr = sr
ksmps		=			1
nchnls		=			2

garev1		init		0
garev2		init		0

;Instrument 1 : Using Voice Sample
			
			instr		1

;Define i Values					  
								    
ifn			=			p6
ilength		=			ftlen(ifn)
ivfreq		=			p4*(sr/ilength)	
iamp		=			p5*32000
idur		=			p3

;Reading Voice Sample

kenv		linseg		0, .01, 1, p3 - .11, 1, .1, 0
kenv2		expseg		.1,idur/4,1,idur/4,.1,idur/4,1,idur/4,.1
avoice		oscili		iamp*kenv, ivfreq, ifn

;Filtering 1

kexp		expseg		.01, p3*.35, 1, p3*.45,.7,p3*.2,.01
kband		=			kexp * 500
kfreq		linseg		0, p3*.35, 1700*p4, p3*.45, 410,p3*.2, 0
afilt1		reson		avoice, kfreq, kband, 1
adel1		delay		afilt1, .51434

;Filtering 2

kband2		=			kexp * 250
kfreq2		linseg		2000 * p4, p3*.35, 0, p3*.45, 3000 * p4, p3*.2, 0
afilt2		reson		avoice, kfreq2, kband2, 1
adel2		delay		afilt2, .51434

;Mixer & Out

aleft		=		 	(afilt1 + adel2)*kenv2
aright		=		 	(afilt2 + adel1)*kenv2

			outs		aleft, aright
		    
garev1		=			garev1+(aleft*.5)
garev2		=			garev1+(aright*.5)
		   
			endin
			
;Instrument 2 : Using Contrabass Sample

			instr		2

;Define i Values   

iamp		=			p5*32000
idur		=			p3
ifn			=			p6
ilength		=			ftlen(ifn)
ibfreq		=			p4*(sr/ilength)
icut1		=			p7
icut2		=			p8
irevtime1	=			p9
irevtime2	=			p10
iloop		=			p11
ibeg		=			p12
iend		=			p13
ibegfreq	=			p14
iendfreq	=			p15
isndfn1		=			p18
isndbeg		=			0		
isndfn2		=			3 
iwindsize	=			4410
iwindrand	=			iwindsize*.2
ioverlap	=			15
icutfreq1	=			p16
icutfreq2	=			p17
icf1		=			p19
icf2		=			p20

;Enveloping...

ktimpnt		linseg		ibeg,idur,iend
aresamp		linseg		ibegfreq,idur*.35,ibegfreq+(ibegfreq-iendfreq),idur*65,iendfreq
kenv		linseg		0, .01, 1, p3 - .11, 1, .1, 0
kenv2		line		.5,idur,.1
kcut		expon		icut1,idur,icut2
krevtime	line		irevtime1,idur,irevtime2
kfreq		expon		icutfreq1,idur,icutfreq2		
kexp		expseg		.01, p3*.45, 1, p3*.35,.6,p3*.2,.01
kband1		=			kexp*4098
kband2		=			kexp*2056
kcf			linseg		icf1,idur,icf2
kcf2		linseg		icf1*1.2,idur,icf2*1.2
kdelenv		linen		.05,p3/4,p3,p3/2

;Reading Contrabass Sample With "sndwarp" Opcode

abass		sndwarp		kenv*iamp, ktimpnt, aresamp, isndfn1 , isndbeg, iwindsize, iwindrand, ioverlap, isndfn2, 1

;Filtering

afilt1		butterbp	abass,kfreq,kband1
afilt2		butterbp	abass,kfreq,kband2
afilt3		delay		afilt1,.5
afilt4		delay		afilt2,.5
afilt5		reson		afilt3*kdelenv,kcf,kband1
afilt6		reson		afilt4*kdelenv,kcf,kband2

;Mix & Out

aleft		=			afilt5*kenv
aright		=			afilt6*kenv
			
			outs		aleft,aright
			
garev1		=			garev1+(aleft*.7)
garev2		=			garev1+(aright*.7)
			
			endin
			
;Instrument 4 : Using Voice & Piano Sample
			
			instr		4

;Define i Values					  
								    
ifn			=			p6
ilength		=			ftlen(ifn)
ivfreq		=			p4*(sr/ilength)	
iamp		=			p5*32000
idur		=			p3

;Reading Voice Sample

kenv		linseg		0, .01, 1, p3 - .11, 1, .1, 0
kenv2		expseg		1,idur/4,.1,idur/4,1,idur/4,.3,idur/4,.1
avoice		oscili		iamp*kenv, ivfreq, ifn

;Filtering 1

kexp		expseg		.01, p3*.35, 1, p3*.45,.7,p3*.2,.01
kband		=			kexp * 500
kfreq		linseg		0, p3*.35, 1700*p4, p3*.45, 410,p3*.2, 0
afilt1		reson		avoice, kfreq, kband, 1
adel1		delay		afilt1, .51434

;Filtering 2

kband2		=			kexp * 250
kfreq2		linseg		2000 * p4, p3*.35, 0, p3*.45, 3000 * p4, p3*.2, 0
afilt2		reson		avoice, kfreq2, kband2, 1
adel2		delay		afilt2, .51434

;Mixer & Out

aleft		=			(afilt1 + adel2)*kenv2
aright		=			(afilt2 + adel1)*kenv2

			outs		aleft, aright
		    
garev1		=			garev1+(aleft*.5)
garev2		=			garev1+(aright*.5)
		   
			endin
			
			
;Global Reverb Setting

			instr		10

arev1		reverb2		garev1,3,1
arev2		reverb2		garev2,3,1
			
			outs		(arev1+arev2)/2,(arev1+arev2)/1.6

garev1		=			0
garev2		=			0
			
			endin	



