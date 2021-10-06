<CsoundSynthesizer>
<CsOptions>
</CsOptions>
<CsInstruments>

;matthew j thies 5/4/00

sr      =  	44100
kr    	=  	4410
ksmps  	=  	10
nchnls	=	2

gacmb	init	0
garvb	init	0


        	instr   1					;FOF W/ENVELOPES, FEEDBACK INSTR 		
;--------------------------------------------------------------------------------------------------------------------------------------------------
kamp		=		ampdb (p4)
ifund1		=		p5  
ifund2		=		p6
iform1		=		p7  
iform2		=		p8
ioct1		=		p9  
ioct2		=		p10
iband1		=		p11  
iband2		=		p12  
iris		=		p13  
idur1		=		p14 
idur2		=		p15 
idec		=		p16 
iolaps		=		p17 				;roughly --> kfund * kdur
ifna		=		1 
ifnb		=		2 
iphs		=		p18 
ifmode		=		p19 
kpan		=		p20 
irvbsnd		=		p21     			;reverb send range 0-1
icmbsnd		=		p22
kviblvl		=		p23
itotdur		=		p24

;--------------------------------------------------------------------------------------------------------------------------------------------------
kvibfrq		linseg	4.5, p3*.2, 5, p3*.6, 5, p3*.2, 4							;VIBRATO FREQUENCY ENVELOPE
kvibdel		linseg  0, p3*.2, .1, p3*.3, 1, p3*.4, .25							;VIBRATO DELAY
avib        oscil   kviblvl, kvibfrq, 1											;VIBRATO
kampenv     expseg  .01, p3*.08, .75, p3*.62, 1, p3*.3, .01	        			;AMPLITUDE ENVELOPE
kfundenv    linseg	ifund1, p3, ifund2											;FUNDAMENTAL ENVELOPE
kformenv	linseg	iform1, p3, iform2											;FORMANT ENVELOPE
koctenv     linseg  ioct1, p3*.5, ioct1, p3*.3, ioct2							;OCTAVIATION ENVELOPE
kbandenv	linseg  iband1, p3, iband2											;BANDWIDTH ENVELOPE
kdurenv		expseg	idur1, p3*.7, idur2    		 								;GRAIN DURATION ENVELOPE
;--------------------------------------------------------------------------------------------------------------------------------------------------
;ar      	fof     xamp, xfund, xform, koct, kband, kris, kdur, kdec,iolaps, ifna, ifnb, itotdur[, iphs][, ifmode]
asig      	fof     kamp, kfundenv + (avib * kvibdel), kformenv, koctenv, kbandenv, iris, kdurenv, idec, iolaps, ifna, ifnb, itotdur, iphs, ifmode
a1      	=		asig * kampenv                
        	outs    a1 * kpan, a1 * (1 - kpan)

garvb	    =	    garvb+(a1*irvbsnd)
gacmb		=		gacmb+(asig*icmbsnd)
        	endin


;--------------------------------------------------------------------------------------------------------------------------------------------------


        	instr   3					;FOF W/EVOLVING VOWELS		
;--------------------------------------------------------------------------------------------------------------------------------------------------
kamp		=		ampdb (p4)
ifund		=		cpspch (p5)  

iform		=		p6  
ioct1		=		p7  
ioct2		=		p8

iband		=		p9  
iris		=		p10  
idur		=		p11 
idec		=		p12 
iolaps		=		p13 				;roughly --> kfund * kdur
ifna		=		1 
ifnb		=		2 
iphs		=		p14 
ifmode		=		p15 
kpan		=		p16 
irvbsnd		=		p17     			;reverb send range 0-1
kvibdpth	=		p18
itotdur		=		p3
ipanfn		=		p19
;--------------------------------------------------------------------------------------------------------------------------------------------------
kvibdel		linseg  0, p3*.3, .1, p3*.4, 1, p3*.3, .5							;VIBRATO DELAY
avib        oscil   kvibdpth, 5, 1												;VIBRATO
;--------------------------------------------------------------------------------------------------------------------------------------------------
kampenv     linseg  0, p3*.3, 1, p3*.5, .75, p3*.2, 0		        			;AMPLITUDE ENVELOPE
koctenv     linseg  ioct1, p3*.5, ioct2											;OCTAVIATION ENVELOPE
kpanenv		oscil	1, 1/p3, ipanfn	            								;PANNING OSCIL
;--------------------------------------------------------------------------------------------------------------------------------------------------
;ar      	fof     xamp, xfund, xform, koct, kband, kris, kdur, kdec,iolaps, ifna, ifnb, itotdur[, iphs][, ifmode]

asig      	fof     kamp, ifund + (avib * kvibdel), iform, koctenv, iband, iris, idur, idec, iolaps, ifna, ifnb, itotdur, iphs, ifmode  

a1      	=		asig * (kampenv)                
        	outs    a1 * kpanenv, a1 * (1 - kpanenv)

garvb	    =	     garvb+(a1*irvbsnd)
        	endin


;--------------------------------------------------------------------------------------------------------------------------------------------------

			instr	198					;global comb
;--------------------------------------------------------------------------------------------------------------------------------------------------
idur		=		p3
itime 		= 		p4
iloop 		= 		p5
kenv		linen	1, .01, idur, .01

acomb 		comb	gacmb, itime, iloop, 0
			outs	acomb*kenv, acomb*kenv

gacmb		=		0
			endin


;--------------------------------------------------------------------------------------------------------------------------------------------------


		   instr 199                     ;global reverb
;--------------------------------------------------------------------------------------------------------------------------------------------------
irvbtim		=		p4
ihiatn	    =		p5

arvb	    nreverb	garvb, irvbtim, ihiatn
		    outs		arvb, arvb
garvb	    =		0
		    endin




</CsInstruments>
;--------------------------------------------------------------------------------------------------------------------------------------------------
;--------------------------------------------------------------------------------------------------------------------------------------------------
<CsScore>

f 1 0   4096    10  1					;SINE 
f 2 0   1024    19  .5 .5 270 .5		;SIGMOID
;PAN FUNCTIONS
f 3 0   4096 8  0.000000 1274 0.190000 1456 -0.100000 1366 0.000000		;2 POINT LOW SINUSOID
f 4 0   4096 8  0.000000 507 0.300000 1092 -0.080000 2497 0.000000 		;2 POINT LEFT
f 5 0   4096 8  0.000000 2769 -0.130000 806 0.270000 521 0.000000		;2 POINT RIGHT

;Adv statement
;           time
;a   0   0   90


;Tempo statements
;   t1  tempo1  t2  tempo2  t3  tempo3  t4  tempo4  t5  tempo5  t6  tempo6  t7  tempo7
t   0   50      48  60      62  69      75  65      78  73      79  72      80  60

;FOF PAD
;p1      p2    p3    p4    p5	  p6     p7     p8      p9    p10   p11    p12    p13   p14    p15    p16   p17    p18   p19    p20   p21     p22       p23      p24     
;instr   st    dur   amp   fund1  fund2  form1  form2   oct1  oct2  band1  band2  ris   dur1   dur2   dec   olaps  phs   fmode  pan   rvbsnd  cmbsnd	viblvl   totdur   
;------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
i1       0     100   75    200    200	 250    650     0     1     0      20     .001   .02   .2    .007   200    0     1     .5    .1       0		    .8       100     
i1       28    60    75    300    300	 350    475     0     0     0      20     .001   .02   .05   .007   40     0     .     .5    .1       0		    .5       60      
;------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
i1       48    20    80    1.5    1.5  	 250    250     0     0     0      20     .01    .2    .3    .07    40     0     1     .5    .1       .3	    .5       20      
i1       62    60    72    .      .  	 250    250     0     0     0      20     .1     .4    .2    .7     .      0     .     1     .1       .2	    .5       50      
i1       62    60    72    .      1.501	 300    300     0     0     0      20     .1     .4    .2    .7     .      0     .     0     .1       .		    .5       52      
;------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
i1       80    50    77    200    200	 450    250     1     0     0      20     .001   .02   .2    .007   200    0     1     .5    .2       0		    .8       50		 

;FOF EVOLVE
;p1      p2    p3    p4    p5	  p6     p7     p8   p9    p10   p11   p12   p13    p14   p15    p16   p17    p18      p19
;instr   st    dur   amp   fund   form   oct1  oct2  band  ris   dur   dec   olaps  phs   fmode  pan   rvbsnd vibdpth  panfn
;---------------------------------------------------------------------------------------------------------------------------
i3       10    16    64    2      1080    1     0      90  .01   .018  .07   40     0     1     .5    .5      .3       4     
i3       18    .     63    3      2650    0     .     120  .     .     .     .      .     .     .     .       .        5     
i3       30    21    60    3      2900    1     .     130  .     .     .     .      .     .     .     .       .        3     
  
  
  
;GLOBAL COMB
;p1     p2      p3      p4      p5       
;ins	strt	dur 	time	loop	
;--------------------------------------------------------------------------------------------------------------------------------------------------
i198	 0		125		10		.5		


;GLOBAL REVERB
;p1        p2       p3    p4      p5       
;instr     St       Dur   rvbtim  hiatn    
;--------------------------------------------------------------------------------------------------------------------------------------------------
i199       0        132    1      .5
e



</CsScore>
</CsoundSynthesizer>


