; in Valencia    
              
                                      

sr		=		44100
kr		=		4410
ksmps	=		10
nchnls	=		2

garvb1	init	0

instr	1

iamp	=		ampdb(p4)
iatt	=		p5
idec	=		p6
irel	=		p7
isus	=		p3-(iatt+idec+irel)
iclmx	=		p8                  ; MAKING THE PEAK OF THE NOTE INTO A VARIABLE.
ifn		=		p9
ibff	=		p10
ibwth	=		p11
ihff	=		p12
irsend	=		p13                 ; REVERB SEND
ipanl	=		p14					; TO SET LOCATION OF THE NOTES.
ipanr	=		p15					; TO SET LOCATION OF THE NOTES.

				
kaenv	expseg	.01,	iatt,	iclmx,	idec,	.3,	isus,	.4,	irel,	.01		; AMP ENV TO NOISE
anois	randi	iamp*kaenv,	6000													
                                           			 								 
kbwenv	expseg	.005,	iatt,	iclmx,	idec,	.3,	isus,	.4,	irel,	.001	; BANDWIDTH ENV TO butterbp1&2
afilt1	butterbp anois,	ibff*.66,	ibwth*kbwenv		
afilt2	butterbp afilt1,	ibff,	ibwth*kbwenv			
afilt3	butterhp afilt2,	ihff							
abal	balance	afilt3,	anois							
		outs	abal*ipanl,	abal*ipanr
garvb1	=		garvb1+abal*irsend							    
endin
;KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK
		instr	2

iamp	=		ampdb(p4)
iatt	=		p5
idec	=		p6
irel	=		p7
isus	=		p3-(iatt+idec+irel)	
iclmx	=		p8
ifn		=		p9
ibff	=		p10
ibwth	=		p11
ilff	=		p12
irsend	=		p13
ipanl	=		p14					; SAME AS INSTR1
ipanr	=		p15					; SAME AS INSTR1
inote	=		cpspch(p16)
				
kaenv	expseg	.005,	iatt,	iclmx,	idec,	.3,	isus,	.4,	irel,	.001	
asig1	oscil	iamp*kaenv,	inote,	ifn											
asig2	oscil	iamp*kaenv,	inote*1.05,	ifn										
amix	=		asig1+asig2																

kfenv	expseg	.1,	iatt,	iclmx,	idec,	.4,	isus,	.5,	irel,	.1			
afilt1	butterbp amix,	ibff,	ibwth*kfenv										
afilt2	butterlp amix,	ilff;*kfenv												
afmix	=		afilt1 +afilt2															
abal	balance	afmix,	asig1													
		outs	abal*ipanl,	abal*ipanr												
garvb1	=		garvb1+abal*irsend														
		endin
;KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK
		instr	3			; SAME instr AS instr1. W/ DIFFER AMP & FILT ENV., ALSO IT HAS DYNAMIC LOCATION.

iamp	=		ampdb(p4)
iatt	=		p5
idec	=		p6
isus	=		p7
idec2	=		p8
iris	=		p9
irel	=		p3-(iatt+idec+isus+idec2+iris)
iclmx	=		p10
ifn		=		p11
ibff	=		p12
ibwth	=		p13
ihff	=		p14
irsend	=		p15

kaenv	expseg	.01,	iatt,	.2,	idec,	.02,	isus,	iclmx,	idec2,	.01,	iris,	.4,	irel,	.001
anois	randi	iamp*kaenv,	6000

kbwenv	expseg	.005,	iatt,	.02,	idec,	.008,	isus,	iclmx,	idec2,	.005,	iris,	.4,	irel,	.001		
afilt1	butterbp anois,	ibff*.66,	ibwth*kbwenv
afilt2	butterbp afilt1,	ibff,	ibwth*kbwenv
afilt3	butterhp afilt2,	ihff
abal	balance	 afilt3,	anois
kpanl	expseg	 .0001,	iatt,	.005,	idec,	.0001,	isus,	iclmx,	idec2,	.005,	iris,	.3,	irel,	1
kpanr	=		1 - kpanl
		outs	abal*kpanl,	abal*kpanr
garvb1	=		garvb1+abal*irsend

endin
;KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK
		instr	4		;SAME instr AS instr2, W/ DIFFER AMP & FILT ENV. THE DYNAMIC CURVE OF ITS LOCATION
              			; HAS THE OPPOSIT MOVEMENTS OF instr1&3, SO THE THEY CROSS EACH OTHER IN THE STEREO FIELD.
iamp	=		ampdb(p4)
iatt	=		p5
idec	=		p6
isus	=		p7
idec2	=		p8
iris	=		p9
irel	=		p3-(iatt+idec+isus+idec2+iris)
iclmx	=		p10
inote	=		cpspch(p11)
ifn		=		p12
ibff	=		p13
ibwth	=		p14
ilff	=		p15
irsend	=		p16                           


kaenv	expseg	.01,	iatt,	.2,	idec,	.02,	isus,	iclmx,	idec2,	.01,	iris,	1,	irel,	.001	
asig1	oscil	iamp*kaenv,	inote,	ifn
asig2	oscil	iamp*kaenv,	inote*.999,	ifn
amix	=		asig1+asig2

kfenv	expseg	.001,	iatt,	.02,	idec,	.002,	isus,	iclmx,	idec2,	.001,	iris,	.01,	irel,	.001
afilt1	butterbp amix,	ibff*kfenv,	ibwth
afilt2	butterlp amix,	ilff*kfenv
afmix	=		 afilt1 + afilt2
abal	balance	 afmix,	asig1
kpanr	expseg	 .0001,	iatt,	.002,	idec,	.0001,	isus,	iclmx,	idec2,	.0055,	iris,	.25,	irel,	1
kpanl	=		 1 - kpanr
		outs	 abal*kpanl,	abal*kpanr
garvb1	=		 garvb1+abal*irsend

		endin
;KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK
		instr	5
									
iamp	=		ampdb(p4)
inote	=		cpspch(p5)
ifn		=		p6
iatt	=		p7
idec	=		p8
irel	=		p9													
isus	=		p3-(iatt+idec+irel)
ibff	=		p10
ibwth	=		p11
icps	=		p12
irsend	=		p13
ipanl	=		p14
ipanr	=		p15
	
kpenv	oscil	2,	.5,	1                                                 
									; LFO, MODULATING THE PITCH OF PLUCK.
kaenv	linen	1,	iatt,	p3,	irel                              
									; AMP ENV.
asig1	pluck	iamp*kaenv,	inote+kpenv,	icps,	ifn,	4,	1,	3000				
asig2	pluck	iamp*kaenv,	inote*.95+kpenv,	icps,	ifn,	4,	1,	3000			
asig3	pluck	iamp*kaenv,	inote*.99+kpenv,	icps,	ifn,	4,	1,	3000			
asig4	pluck	iamp*kaenv,	inote*1.011+kpenv,	icps,	ifn,	4,	1,	3000			
amix	=		asig1+asig2+asig3+asig4													

kbfenv	expseg	 .1,	iatt,	1,	idec,	.9,	isus,	.8.,	irel,	.1				
abfilt	butterbp amix,	ibff*kbfenv,	ibwth													
abal	balance	 abfilt,	asig1																								
		outs	 abal*ipanl,	abal*ipanr																						
garvb1	=		 garvb1+abal*irsend
		endin
;KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK
		instr	6					

iamp	=		ampdb(p4)
ifrq	=		p5										
ifn		=		p6
iatt	=		p7
isus	=		p8
irel	=		p3-iatt+isus
ibff	=		p9
ibwth	=		p10
ihff	=		p11
iphs	=		p12
indpth	=		p13
irsend	=		p14
							
knois	randh	indpth,	12			; LOW FREQ NOISE
asig2	buzz	.8,	2,	12,	ifn,	iphs ; AUDIO SIGNAL, BUZZ WAVE, AMP SET TO .8 * AT DESTINATION.
kaenv	expseg	.01,	iatt,	1,	isus,	1,	irel,	.001 ; AMP ENV
asig1	buzz	iamp*kaenv,	ifrq*asig2,	64,	1 ; BUZZ WAVE
									
kbwenv	expon	 1,	p3,	.001		; BANDPASS BANDWIDTH ENV.
abfilt	butterbp asig1,	ibff*knois,	ibwth*kbwenv ; BANDPASS,CENTERFREQ CONTROLED BY randh(knois.)
ahfilt	butterhp abfilt,	ihff	; HIGHPASS CUTOFF AT 1500Hz
abal	balance	 ahfilt,	asig1																					
kpanl	oscil	 .5,	3/p3,	1	; STEREO PAN
kpanr	=		 1 - kpanl
		outs	 abal*kpanl,	abal*kpanr*.6
garvb1	=		 garvb1+abal*irsend
endin
;KKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKKK
		instr	99											

irvbtime =		p4
idfs	 =		p5

asig	reverb2	garvb1,	irvbtime,	idfs
		outs	asig,	asig
garvb1	=		0

		endin
;KKKKKKKKKKKKKKKKKKKKKKKKKKKK----END OF ORCESTRA----KKKKKKKKKKKKKKKKKKKKKKKKKK
