;==============================================================;
;HOW CAN IT BE?                                                ;
;==============================================================;
;"And Can it Be?" by Charles Wesley and Thomas Cambell,        ;
;Arranged for Csound by Jeremy Bridge for Dr. B's Csound class,;                
;Berklee College of Music, 4.26.02, edgeoworld@aol.com         ;
;==============================================================;

;==============================================================;
;PROGRAM NOTE                                                  ;
;==============================================================;
;When i became interested in the microtonal possibilities of   ;
;Csound, i decided that before i tried to implement it in a    ;
;harmonic manner, i wanted to try it in a random, possibly even;
;dissonant capacity.  I decided to use a simple classical      ;
;structure (i went with the four part sacred hymn of Wesley and; 
;Cambell) and detune each of the four parts, microtonally, and ;
;see what kind of textures and harmonies i could get.  This    ;
;piece is what resulted.    -jeremy bridge                     ;
;==============================================================;

sr		=	44100
kr		=	4410
ksmps	=	10
nchnls	=	2

;soprano part
		instr   133
idur	=		p3
iamp	=		p4
ifrq	=		cpspch(p5*p9)
icut1	=		p6				
icut2	=		p7
iresgn	=		p8
idet	=		p9
ipan	=		p10
kcut	expon	icut1, idur, icut2
aplk 	pluck 	iamp, ifrq, ifrq, 0, 1
abpf	butterbp	aplk, kcut, kcut*.2
alpf	butterlp	aplk, kcut				
amix	=     	alpf+(abpf*iresgn)
		outs	amix*ipan, amix*(1-ipan)
		endin

;alto part
		instr   134
idur	=		p3
iamp	=		p4
ifrq	=		cpspch(p5*p9)
icut1	=		p6				
icut2	=		p7
iresgn	=		p8
idet	=		p9
ipan	=		p10
kcut	expon	icut1, idur, icut2
aplk 	pluck 	iamp, ifrq, ifrq, 0, 1
abpf	butterbp	aplk, kcut, kcut*.2
alpf	butterlp	aplk, kcut				
amix	=     	alpf+(abpf*iresgn)
		outs	amix*ipan, amix*(1-ipan)
		endin

;tenor part
		instr   135
idur	=		p3
iamp	=		p4
ifrq	=		cpspch(p5*p9)
icut1	=		p6				
icut2	=		p7
iresgn	=		p8
idet	=		p9
ipan	=		p10
kcut	expon	icut1, idur, icut2
aplk 	pluck 	iamp, ifrq, ifrq, 0, 1
abpf	butterbp	aplk, kcut, kcut*.2
alpf	butterlp	aplk, kcut				
amix	=     	alpf+(abpf*iresgn)
		outs	amix*ipan, amix*(1-ipan)
		endin

;bass part
		instr   136
idur	=		p3
iamp	=		p4
ifrq	=		cpspch(p5*p9)
icut1	=		p6				
icut2	=		p7
iresgn	=		p8
idet	=		p9
ipan	=		p10
kcut	expon	icut1, idur, icut2
aplk 	pluck 	iamp, ifrq, ifrq, 0, 1
abpf	butterbp	aplk, kcut, kcut*.2
alpf	butterlp	aplk, kcut				
amix	=     	alpf+(abpf*iresgn)
		outs	amix*ipan, amix*(1-ipan)
		endin
