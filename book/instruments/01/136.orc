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
