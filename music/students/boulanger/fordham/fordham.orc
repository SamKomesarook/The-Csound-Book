sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =          2


;=====================================
; reverb initialization
;=====================================

garvbsig  init      0


;=====================================
; delay initialization
;=====================================

gasig     init      0



		instr	12
idur	=		p3
iamp	=		p4
ifrq	=		cpspch(p5)
ibeans	=		p6
idamp   =       p7
itimes  =       p8
icut1    =      p9
icut2    =      p10
iresgn   =      p11
ipanfrq  =      p12


kcut    expon   icut1, idur, icut2 
kpan    oscil    .5, ipanfrq, 1

ashake  shaker   iamp, ifrq, ibeans, idamp, itimes, 0

     	       	       	
abpf    butterbp   ashake, kcut, kcut*.2
alpf    butterlp   ashake, kcut
amix    =         alpf+(abpf*iresgn)
         
kpanlfo   =     kpan+.5
    
      outs   amix*kpanlfo, amix*(1-kpanlfo)  
   
        endin



;==================================
; INSTUMENT 1 - three branch instr
;==================================

          instr 1

i1        =         p5*.3
i2        =         p4*.98
i3        =         1/p3
i4        =         p5*.6
i5        =         p4
kfreq1    =         p6
kfreq2    =         p7
kamp2     =         p8
ipanfrq   =         p10


;=============================================
; 1 - noise branch
;=============================================
a1        randi     i4, p9                   ;i4 WAS p5
a1        oscil     a1, i3, 10
a1        oscil     a1, 3000, 11             ;a1 IS THE NOISE OUTPUT
                                        

;===========================================
; 2 - RM branch
;===========================================
kamp1     linen     kamp2, p3*.2, p3, p3*.2
asig1     oscil     kamp1/6, kfreq1, 11        ; AMP IS CONTROLLED BY LINEN, FREQ IS CONTROLLED BY p6
asig2     oscil     kamp2/6, kfreq2, 3         ; AMP IS CONTROLLED BY p8, FREQ IS CONTROLLED BY p7
aosc2     =         asig1*asig2

a2        =         aosc2*.085               ; THE OUTPUT a2 IS SCALED


;================================
; 3 - low sine branch
;================================
k3        oscil     i4, i3, 8                ; f8 = EXP ENV
a3        oscil     k3, i5, 4                ; f4 = SINE WAVE (LO RES)

a3        =         a3*.5                    ; a3 PROVIDES THE LOW SINE TONE


;output to filter, reverb and panning
;=====================================
iamp      =         p8*.4
aout      =         a1+a2+a3
kcf       linseg    0,p3/2,850,p3/2,0        ; THIS CONTROLS THE FILTER FRQ
;kpan      oscil     1,0.1,17                 ; TRIANGLE WITH OFFSET (0-1) CONTROLS PANNING
kpan    oscil    .5, ipanfrq, 1
alp       butterlp  aout, kcf                ; THREE BRANCHES ARE MIXED & FED THROUGH BUTTERLP
kenv      linen     iamp,p3*.8,p3,p3*.2      ; THIS IS THE MAIN ENV ON THE OUTPUT

alpout    =         kenv*alp
kpanlfo   =     kpan+.5
     
          ;outs      alpout*kpan,alpout*(1-kpan) ; STEREO OUTS  

outs   alpout*kpanlfo, alpout*(1-kpanlfo)  


garvbsig  =         garvbsig+(alpout*.5)     ; SEND .2 OF THE SIG TO RVB



       
       
       
          endin


          instr 2

i1        =         p5*.3
i2        =         p4*.98
i3        =         1/p3
i4        =         p5*.6
i5        =         p4
kfreq1    =         p6
kfreq2    =         p7
kamp2     =         p8
iretrig   =         p9
ipanfrq   =         p10


;=============================================
; 1 - noise branch
;=============================================
;a1        randi     i4, p9                   ;i4 WAS p5
;a1        oscil     a1, i3, 10
;a1        oscil     a1, 3000, 11             ;a1 IS THE NOISE OUTPUT
                                        

;===========================================
; 2 - RM branch
;===========================================
kamp1     linen     kamp2, p3*.2, p3, p3*.2
asig1     oscil     kamp1/6, kfreq1, 11        ; AMP IS CONTROLLED BY LINEN, FREQ IS CONTROLLED BY p6
asig2     oscil     kamp2/6, kfreq2, 3         ; AMP IS CONTROLLED BY p8, FREQ IS CONTROLLED BY p7
aosc2     =         asig1*asig2

a2        =         aosc2*.085               ; THE OUTPUT a2 IS SCALED


;================================
; 3 - low sine branch
;================================
k3        oscil     i4, i3, 8                ; f8 = EXP ENV
a3        oscil     k3, i5, 4                ; f4 = SINE WAVE (LO RES)

a3        =         a3*.5                    ; a3 PROVIDES THE LOW SINE TONE





;output to filter, reverb and panning
;=====================================
iamp      =         p8*.4
aout      =         a2+a3
kcf       linseg    0,p3/2,850,p3/2,0        ; THIS CONTROLS THE FILTER FRQ
;kpan      oscil     1,0.1,17                 ; TRIANGLE WITH OFFSET (0-1) CONTROLS PANNING
kpan    oscil    .5, ipanfrq, 1
alp       butterlp  aout, kcf                ; THREE BRANCHES ARE MIXED & FED THROUGH BUTTERLP
kenv      linen     iamp,p3*.8,p3,p3*.2      ; THIS IS THE MAIN ENV ON THE OUTPUT

alpout    =         kenv*alp
kpanlfo   =     kpan+.5
     
          ;outs      alpout*kpan,alpout*(1-kpan) ; STEREO OUTS  

outs   alpout*kpanlfo, alpout*(1-kpanlfo)  


garvbsig  =         garvbsig+(alpout*.5)     ; SEND .2 OF THE SIG TO RVB


endin

;output to filter, reverb and panning
;=====================================
;iamp      =         p8*.4
;aout      =         a2+a3
;kcf       linseg    0,p3/2,850,p3/2,0        ; THIS CONTROLS THE FILTER FRQ
;kpan      oscil     1,0.1,17                 ; TRIANGLE WITH OFFSET (0-1) CONTROLS PANNING
;alp       butterlp  aout, kcf                ; THREE BRANCHES ARE MIXED & FED THROUGH BUTTERLP
;kenv      linen     iamp,p3*.8,p3,p3*.2      ; THIS IS THE MAIN ENV ON THE OUTPUT
  

;kenv1   oscil   iamp, p3 * iretrig, 1    
;  
 ; 
;alpout    =         kenv*alp*kenv1
     
 ;         outs      alpout*kpan,alpout*(1-kpan) ; STEREO OUTS  

;garvbsig  =         garvbsig+(alpout*.2)     ; SEND .2 OF THE SIG TO RVB

 ;         endin

;===================
; GLOBAL REVERB
;===================

          instr 99

a1        reverb2   garvbsig, p4, p5
          outs      a1,a1

garvbsig  =         0

          endin




;====================
;
; GLOBAL DELAY
;
;====================

          instr 98            ; THIS DELAY IS IN PARALLEL CONFIG
                                             
a1        delay     gasig,p4                 ; DELAY=1.25
a2        delay     gasig,p4*2               ; DELAY=2.50
          outs      a1,a2

gasig     =         0

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
		outs		amix*kgate, amix*kgate
		endin



		instr	141  
idur	=		p3
iamp	=		ampdb(p4)
ifrq	=		cpspch(p5)
ifun	=		p6
iatk	=		p7
irel	=		p8
iatkfun	=		p9
imodpth	=		p10
imodfrq	=		p11
imodfun	=		p12
ipanfrq	=		p13	
irvbsnd	=		p14			
kenv	envlpx	iamp, iatk, idur, irel, iatkfun, .7, .01
kpan	oscil	.5, ipanfrq, 111
klfo	oscil	imodpth, imodfrq, imodfun	
asig    oscil	klfo*kenv, ifrq, ifun
kpanlfo	=		kpan+.5
       	outs  	asig*kpanlfo, asig*(1-kpanlfo)
garvbsig	=		garvbsig+(asig*irvbsnd)
		endin
