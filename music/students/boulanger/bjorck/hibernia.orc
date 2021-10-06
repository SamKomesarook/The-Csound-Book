;=====================================
;	"Hibernia"
;	Csound project by Andreas Bjorck
;	for Dr. B's Csound class, MS337, Fall 2000
;	
;	<iveview@hotmail.com>
;======================================

 
sr     =        44100
kr     =        44100
ksmps  =        1
nchnls =        2



;initialization of global variables
;===================================
garvbsig  init      0


gasig     init      0


gacomb	  init		0




;=================================================
; INSTRUMENT 5 --- noise instrument
;	modified kim cascone instr
;=================================================

          instr 5

kfreq     =         p5
                                        
kramp     linseg    0,p3*.7,p4,p3*.3,0       ; THIS CONTROLS THE AMP OF RANDI
kenv1     linen     p4,1, p3,1              ; THIS CONTROLS THE FRQ OF RANDI
anoise    randi     kramp,kenv1
aosc      oscil     anoise,kfreq,1          ; ANOISE IS FED TO THE A INPUT OF AOSC
kpan      oscil     1,.5,1
aosc2     reson     aosc,p5,96,2      
          
aosc	  =			aosc2*2.4        

krtl=sqrt(2)/2*cos(kpan)+sin(kpan)	    ;constant power panning
krtr=sqrt(2)/2*cos(kpan)-sin(kpan)	   

al=aosc*krtl
ar=aosc*krtr

			outs al, ar	
			
garvbsig  =         garvbsig+(aosc*.033)


          endin

;===================================================
;  instrument 6 --- blip instrument
;===================================================
			instr 6
			
iamp	=	ampdb(p4)
ipan	=	p6

kenv	linen	1, .02, p3, .02
kgliss  linseg	1, p3*.2, 1, p3*.8, p7
klfo	oscil	.03, 1, 1
			
asig	oscil	iamp, p5*kgliss, 1
asig2	oscil	iamp, p5*kgliss*(1+klfo), 1
asig3	oscil	iamp, p5*kgliss*(1-klfo), 1 			

al		=	(asig + asig2 + asig3)*kenv
ar		=	(asig + asig2 + asig3)*kenv	

al		=	al*ipan
ar		=	ar*(1-ipan)	
		
		outs	al, ar		

garvbsig 	=        garvbsig+(asig*.01)
gacomb      =        gacomb+(asig*.3)
		


			endin
			
;===================================================
;  instrument 7 --- fm tone instrument
;===================================================
			instr 7

kgliss  linseg	1, p3*.2, 1, p3*.8, p7			

iamp	=	ampdb(p4)
ipan	=	p6
ifn		=	1

kcps	=	p5*kgliss

kcar	=	1
kmod	=	1
kndx	=	p8
kenv	linen	1, .02, p3, .5

;klfo	oscil	.03, 1, 1
			
afm1	foscili 	iamp, kcps, 	 kcar, kmod, kndx, ifn
afm2   	foscili 	iamp, kcps*1.01, kcar, kmod, kndx, ifn
afm3   	foscili 	iamp, kcps*.99,  kcar, kmod, kndx, ifn

afm		=	afm1+afm2+afm3

al		=	afm*kenv
ar		=	afm*kenv	

al		=	al*ipan
ar		=	ar*(1-ipan)	
		
		outs	al, ar		

garvbsig 	=        garvbsig+(afm*.2)
;gacomb      =        gacomb+(afm*.4)
		


			endin
			


;============
; BASS 
;
;============
          instr 8
                                             
iamp      =        	ampdb(p4)             
inote     =         cpspch(p5)              
ionecycl  =         1/p3

k1        oscil     iamp, ionecycl, 27
a1        oscil     k1, inote*1.3, 1

aleft     =         a1*1.8
aright    =         a1*1.8

          outs      aleft, aright
          endin



;============================================================================
;buzz instrument with envelopes controlling amplitude and number of harmonics
;=============================================================================
        instr   9    
idur	=		p3
iamp    =		ampdb(p4)
icps	=		(cpspch(p5)*1.3)*2

k1    	linen    1, p7/2, p3, p8					;p4=max amp, p7=attack, p8=release

k2      linseg   p9, p3/2, p10, p3/2, p9		;harmonic envelope, p9=min # of harmonics, p10=max # of harmonics

kfreq		expon		p11,idur,p12		
kexp		expseg		.01, p3*.45, 1, p3*.35,.6,p3*.2,.01
kband1		=			kexp*4098
kband2		=			kexp*2056
kcf			linseg		p13,idur,p14
kcf2		linseg		p13*1.2,idur,p14*1.2
kdelenv		linen		.05,p3/4,p3,p3/2



a1      buzz    iamp, icps, 	   k2+1, p6			;p5=freq, p6=function table #
a2      buzz    iamp, icps*1.005, k2+1, p6
a3      buzz    iamp, icps*1.01,  k2+1, p6        
a4      buzz    iamp, icps*0.99,  k2+1, p6
a5      buzz    iamp, icps*0.995, k2+1, p6
a6      buzz    iamp/2, icps*0.5,   k2+1, p6
a7      buzz    iamp/2, icps*2,     k2+1, p6

aout	=		a1+a2+a3+a4+a5+a6+a7	

afilt1		butterbp	aout,kfreq,kband1
afilt2		butterbp	aout,kfreq,kband2
afilt3		reson		afilt1*kdelenv,kcf,kband1
afilt4		reson		afilt2*kdelenv,kcf,kband2

al		=	afilt3*k1
ar		=	afilt4*k1
		
		outs     al, ar
        
garvbsig 	=        garvbsig+((al+ar)*.1)
        
        endin



;====================================================================
; RING MOD HI HAT
; based on instrument from "deserted" by jen scaturro
;====================================================================
          instr 20
                                             
iamp      =         ampdb(p4)                ; p4=AMPDB
inote     =         cpspch(p5)               ; p5=OCT.PITCH
ifunc1    =         p6                       ; p6=f TABLE (1, 4, 5)

k1        linen     iamp, 0, p3, 0           ; AMP ENV
k2        randi     k1, 1000                 ; RANDOM NUMBER GENERATOR
a1        oscil     k2, inote, ifunc1

aleft     =         a1*.2
aright    =         a1*.2

          outs      aleft, aright


garvbsig 	=        garvbsig+(a1*.002)
gacomb		=        gacomb+(a1*.01)
          endin

;=================================================================
; KICK DRUM 
; based on instrument from electric priest by tobias enhus
;=================================================================

          instr 25
          
irvbgain  =         p4

k1        expon     120,.2,50      
k2        expon     500,.4,200
a1        oscil     p5,k1,1                           ; SINE WAVE
a2        reson     a1,k2,50
a3        butterlp  a2+a1,k1,20
a4        butterlp  a3,k1,20
a5        butterlp  a4,2500,50
a6        butterhp  a5,50
a7        butterhp  a6,50
a8        linen     a7,0.01,p3,.2  

al		  =			a8*2
ar		  =			a8*2
          
          outs      al,ar
          
garvbsig  =         garvbsig+(a1*irvbgain)

          endin




;========================================================
; PLUCK SNARE
; borrowed from "deserted" by jen scaturro
;========================================================

          instr 100

iamp      =         ampdb(p4)
inote     =         cpspch(p5)
inote2    =         cpspch(p6)
idur      =         1/p3

k1        oscil     iamp, idur, 22 
a1        pluck     k1, inote2, inote, 0, 3
aleft     =         a1*1
aright    =         a1*1

          outs      aleft, aright

garvbsig 	=        garvbsig+(a1*.03)
gacomb 		=        gacomb+(a1*.05)

          endin


;=================
; GLOBAL REVERB
;=================

          instr 99

a1        reverb2   garvbsig, p4, p5
          outs      a1,a1

garvbsig  =         0

          endin


;================
; GLOBAL DELAY
;================

          instr 98            ; THIS DELAY IS IN PARALLEL CONFIG
                                             
a1        delay     gasig,p4                 ; DELAY=1.25
a2        delay     gasig,p4*2               ; DELAY=2.50
          outs      a1,a2

gasig     =         0

          endin

;=================
; GLOBAL COMBDELAY
;=================

          instr 97

ar1        comb  gacomb, p4, p5
ar2		   comb	 gacomb, p4, p5/4
al1        comb  gacomb, p4, p5*.66
al2		   comb	 gacomb, p4, p5/2

a1        = ar1+(ar2*.5)
a2        = (al1*.2)+(al2*.8)
          outs      a1,a2

gacomb  =         0

          endin
          

