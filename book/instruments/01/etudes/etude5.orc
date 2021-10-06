sr 		= 		44100
kr 		= 		4410
ksmps 	= 		10
nchnls 	= 		1

gacmb	init	0
garvb	init	0


		instr	128
idur	=		p3
iamp	=		p4
ifrq	=		p5
iatk	=		p6
irel	=		p7
icf1	=		p8
icf2	=		p9
ibw1	=		p10
ibw2	=		p11
kenv	expseg	.001, iatk, iamp, idur/6, iamp*.4, idur-(iatk+irel+idur/6), iamp*.6, irel,.01
anoise	rand	ifrq
kcf		expon	icf1, idur, icf2
kbw		line	ibw1, idur, ibw2
afilt	reson	anoise, kcf, kbw, 2
       	out  	afilt*kenv
       	display	kenv, idur
		endin

		instr	129
idur	=		p3
iamp	=		p4
ifrq	=		p5
iatk	=		p6
irel	=		p7
icut1	=		p8
icut2	=		p9
kenv	linen	iamp, iatk, idur, irel
kcut	expon	icut1, idur, icut2
anoise	rand	ifrq	
afilt	tone	anoise, kcut
       	out  	afilt*kenv
		dispfft	afilt, idur, 4096
		endin
		
		instr	130
idur	=		p3
iamp	=		p4
ifrq	=		p5
iatk	=		p6
irel	=		p7
icut1	=		p8
icut2	=		p9
kenv	linen	iamp, iatk, idur, irel
kcut	expon	icut1, idur, icut2
anoise	rand	ifrq	
afilt2	tone	anoise, kcut
afilt1	tone	afilt2, kcut
       	out  	afilt1*kenv
		dispfft	afilt1, idur, 4096
		endin
		
		instr	131
idur	=		p3
iamp	=		p4
ifrq	=		p5
iatk	=		p6
irel	=		p7
icut1	=		p8
icut2	=		p9
kenv	linen	iamp, iatk, idur, irel
kcut	expon	icut1, idur, icut2
anoise	rand	ifrq	
afilt3	tone	anoise, kcut
afilt2	tone	afilt3, kcut
afilt1	tone	afilt2, kcut
       	out  	afilt1*kenv
		dispfft	afilt1, idur, 4096
		endin
		
		instr	132
idur	=		p3
iamp	=		p4
ifrq	=		p5
iatk	=		p6
irel	=		p7
icut1	=		p8
icut2	=		p9
kenv	linen	iamp, iatk, idur, irel
kcut	expon	icut1, idur, icut2
anoise	rand	ifrq	
afilt4	tone	anoise, kcut
afilt3	tone	afilt4, kcut
afilt2	tone	afilt3, kcut
afilt1	tone	afilt2, kcut
       	out  	afilt1*kenv
		dispfft	afilt1, idur, 4096
		endin
		
		instr   133
idur	=		p3
iamp	=		ampdb(p4)
ifrq	=		p5
icut1	=		p6				
icut2	=		p7
iresgn	=		p8
kcut	expon	icut1, idur, icut2
aplk 	pluck 	iamp, ifrq, ifrq, 0, 1
abpf	butterbp	aplk, kcut, kcut*.2
alpf	butterlp	aplk, kcut				
amix	=     alpf+(abpf*iresgn)
		out		amix
		dispfft	amix, idur, 1024
		endin
		
		instr   134
idur	=		p3
iamp	=		ampdb(p4)
ifrq	=		cpspch(p5)
icut1	=		p6				
icut2	=		p7
iresgn	=		p8
kcut	expon	icut1, idur, icut2
aplk 	pluck 	iamp, ifrq, ifrq, 0, 1
abpf	butterbp	aplk, kcut, kcut*.2
alpf	butterlp	aplk, kcut				
amix	=     alpf+(abpf*iresgn)
		out		amix
		dispfft	amix, idur, 1024
		endin
		
		instr 	135
idur	=		p3
iamp	=		p4
ifrq	=		p5
iatk	=		p6
irel	=		p7
irat1	=		p8
irat2	=		p9
imsdel	=		p10
kenv	expseg	.001, iatk, iamp, idur/8, iamp*.3, idur-(iatk+irel+idur/8), iamp*.7, irel,.01
krate	line	irat1, idur, irat2
alfo	oscil	imsdel, krate/idur, 19
anoise	rand	ifrq
adel4	vdelay	anoise, alfo, imsdel
adel3	vdelay	adel4, alfo, imsdel
adel2	vdelay	adel3, alfo, imsdel
adel1	vdelay	adel2, alfo, imsdel
adel0	vdelay	adel1, alfo, imsdel
amix	=		adel0+adel1+adel2+adel3+adel4		
		out		kenv*amix
		dispfft	amix, idur, 1024
		endin
		
		instr 	136
idur	=		p3
iamp	=		ampdb(p4)
ifrq	=		cpspch(p5)
ilfodep	=		p6
ilfofrq	=		p7
ilfofun	=		p8
irat1	=		p9
irat2	=		p10
imsdel	=		p11
kgate	linen	1, .01, idur, .1
klfo	oscil	ilfodep, ilfofrq, ilfofun
krate	line	irat1, idur, irat2
alfo	oscil	imsdel, krate/idur, 19
aplk 	pluck 	iamp, ifrq+klfo, ifrq, 0, 1
adel4	vdelay	aplk, alfo, imsdel
adel3	vdelay	adel4, alfo, imsdel
adel2	vdelay	adel3, alfo, imsdel
adel1	vdelay	adel2, alfo, imsdel
adel0	vdelay	adel1, alfo, imsdel
amix	=		adel0+adel1+adel2+adel3+adel4		
		out		amix*kgate
		dispfft	amix, idur, 1024
		endin
		

