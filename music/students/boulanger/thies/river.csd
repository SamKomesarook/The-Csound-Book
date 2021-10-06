<CsoundSynthesizer>
<CsOptions>
</CsOptions>
<CsInstruments>

;Now he sits by the river...
;matthew j thies - November 2000

sr      =  	44100
kr    	=  	4410
ksmps  	=  	10
nchnls	=	2

gacmb1	init	0
gacmb2	init	0
garvb1	init	0
garvb2	init	0


        instr   1								;STEREO GRANULAR SAMPLE PROCESSOR
kamp    =   ampdb(p4)
ivoice  =   p5
iratio  =   p6
imode   =   p7
ithd    =   p8
ifn 	=   p9
ipshift =   p10
igskip  =   p11
igskipos=   p12
ilength =   p13
kgap    =   p14
igapos  =   p15
kgsize  =   p16
igsizeos=   p17
iatt    =   p18
idec    =   p19
iseed   =   p20
ipch1   =   p21
ipch2   =   p22
ipch3   =   p23
ipch4   =   p24
ifnenv  =   p25
icmbsnd =   p26
igpstrt =	p27
igpend	=	p28
ifcost	=	p29
ifcoend	=	p30
irvbsnd =	p31
isddif	=	p32
kgpenv	linseg	igpstrt, p3, igpend								;GAP ENVELOPE
k1		linseg  0, .5*p3, 1, .3*p3, 1, .2*p3, 0					;AMPLITUDE ENVELOPE
kfco	expseg	ifcost, p3, ifcoend 							;LOWPASS Fc ENVELOPE
kres	linseg	3, p3, 1										;RESONANCE ENVELOPE

;ar 	granule xamp, ivoice, iratio, imode, ithd, ifn, ipshift, igskip, igskip_os, ilength, 
;       kgap, igap_os, kgsize, igsize_os, iatt, idec [,iseed] [,ipitch1] [,ipitch2] [,ipitch3] [,ipitch4] [,ifnenv]
 
a1      granule kamp*k1, ivoice, iratio, imode, ithd, ifn, ipshift, igskip, igskipos, ilength, kgpenv, igapos, kgsize, igsizeos, iatt, idec, iseed, ipch1, ipch2, ipch3, ipch4, ifnenv
a2      granule kamp*k1, ivoice, iratio, imode, ithd, ifn, ipshift, igskip, igskipos, ilength, kgpenv, igapos, kgsize, igsizeos, iatt, idec, iseed+isddif, ipch1, ipch2, ipch3, ipch4, ifnenv

a3		rezzy	a1, kfco, kres, 0        
a4		rezzy	a2, kfco, kres, 0     
        
        outs    a3, a4

garvb1	=	    garvb1+(a1*irvbsnd)
garvb2	=	    garvb2+(a2*irvbsnd)
gacmb1	=		gacmb1+(a3*icmbsnd)
gacmb2	=		gacmb2+(a4*icmbsnd)

     	endin

;--------------------------------------------------------------------------------------------------------------------------------------------------
			instr 2									;STEREO SOUNDWARP
iamp		=			ampdb(p4)
iwindfun	=			11
isampfun	=			10
ibeg		=			0
iwindsize	=			4410
iwindrand	=			iwindsize*.2
ioverlap	=			15
itimemode	=			1							;if zero, then xtimewarp=scaling factor|if nonzero,then xtimewarp=time pointer
awarp   	linseg  	.88, p3, 0
aresamp 	linseg  	.5, p3, .5
kenv    	linseg		0, p3*.1, 1, p3*.8, 1, p3*.1, 0
icmbsnd		=			0
kcmbsnd		expseg		.01, p3, .1
;ar      	sndwarp     xamp, xtimewarp, xresample, ifn1, ibeg, iwsize, irandw, ioverlap, ifn2, itimemode
;  [, ac]
asig,acmp   sndwarp  	iamp, awarp, aresamp, isampfun, ibeg, iwindsize, iwindrand, ioverlap, iwindfun, itimemode
abal		balance		asig, acmp            
aout		=			abal*kenv
            outs		aout, aout
gacmb1      =           gacmb1+(aout*kcmbsnd)
gacmb2      =           gacmb2+(aout*kcmbsnd)
			endin

;--------------------------------------------------------------------------------------------------------------------------------------------------
			instr	198								;GLOBAL COMB
idur         =           p3
itime        =           p4
iloop        =           p5
kenv         linen       1, .01, idur, .1
acomb1       comb        gacmb1, itime, iloop, 0
acomb2       comb        gacmb2, itime, iloop, 0
             outs        acomb2*kenv, acomb1*kenv
gacmb1       =           0
gacmb2       =           0
  
             endin

;--------------------------------------------------------------------------------------------------------------------------------------------------
		   instr 199                     			;GLOBAL REVERB
irvbtim		=		p4
ihiatn	    =		p5

arvb1	    nreverb	garvb1, irvbtim, ihiatn
arvb2	    nreverb	garvb2, irvbtim, ihiatn
		    outs	arvb1, arvb2
garvb1	    =		0
garvb2	    =		0
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
f 6 0   4096 8  0.000000 507 1.000000 2340 0.110000 1249 0.000000		;LEFT TO CENTER
f 7 0   4096 8  0.000000 273 -1.000000 2600 -0.140000 1223 0.000000		;RIGHT TO CENTER
f 8 0   4096 8  0.000000 1378 0.570000 2561 -0.990000 157 0.000000		;FAKE OUT LEFT
f 9 0   4096 8  0.000000 2743 1.000000 1353 0.000000					;ENVELOPE FOR PANNING OSCIL

f 10 0 131072 1 "destroyed.aif" 0 4 0									;0.881 sec

f 11 0  16384  9  .5 1 0												;HALF SINE WINDOW
f 12 0   1025 20  2 1   												;HANNING WINDOW
f 13 0   1024 19  .5 .5 270 .5											;FOG GRAIN ENVELOPE


;GRANULE SAMPLE PROCESSING INSTRUMENT
;in st     dur  amp V  R       M  TH FN PS  GS  GSO L     GP  GPO SZ  SZO AT  DC  SD   PS1  PS2  PS3  PS4  FNENV CMB  GP1  GP2  FC1  FC2   RVB  SDF 
;p1 p2     p3   p4  p5 p6      p7 p8 p9 p10 p11 p12 p13   p14 p15 p16 p17 p18 p19 p20  p21  p22  p23  p24  p25   p26  p27  p28  p29  p30   p31  p32
;---------------------------------------------------------------------------------------------------------------------------------------------------
i1  40    56.4  86  12 .03125  1  0  10 2   0   10 .881   0   0  .5   50  40  40  0    1    .5   0    0    2     .5   0    0    100  5000  .05  .13
i1  50    .     .   .  .       .  .  .  1   .   .  .      .   <  .05  <   .   .   <    .    .    .    .    .     .    .01  .01  1000 5000  <    .
i1  70    .     .   .  .       .  .  .  2   .   .  .      .   .  .05  .   .   .   .    .    .    .    .    .     .    .01  .01  1000 5000  .    .
i1  90    .     .   .  .       .  .  .  2   .   .  .      .   .  <    .   .   .   .    .    .    .25  .    .     .    .01  .01  1000 5000  .    .
i1  90    .     80  .  .       .  .  .  1   .   .  .      .   .  .    .   .   .   .    2    .    .    .    .     .    .01  .01  5000 10000 .075 <   
i1 100    .     <   .  .       .  .  .  1   .   .  .      .   .  .    .   .   .   .    .125 .    .    .    .     .    .01  .05  5000 1000  <    .
i1 105    .     .   .  .       .  .  .  1   .   .  .      .   .  .    .   .   .   .    .5   .    .    .    .     .6   .05  .1   5000 1000  .    .24
i1 110    .     .   .  .       .  .  .  4   .   .  .      .   .  .    .   .   .   .69  1    .    .    .125 .     .7   .1   .5   5000 1000  .    <   
i1 120    .     .   .  .       .  .  .  3   .   .  .      .   .  .    .   .   .   <    1    .    .    2    .     .7   .5   1    1000 1000  .    .    
i1 125    .     .   .  .0625   .  .  .  3   .   .  .      .   .  .    .   .   .   .    1    .    .    .125 .     .7   .5   1    1000 1000  .    .    
i1 130    .     .   .  .125    .  .  .  3   .   .  .      .   .  .    .   .   .   .    1    .    .    .125 .     .7   .5   1    1000 1000  .    .    
i1 132    28.2  .   .  .5      .  .  .  2   .   .  .      .   .  .    .   .   .   .    1    .    .    .125 .     .4   .5   0    1000 1000  .    .    
i1 135    56.4  75  .  .       .  .  .  3   .   .  .      .   10 .5   .   .   .   .44  1    .    .    .125 .     .8   1    2    1000 500   .05  .04  
i1 140    14.1  .   .  1       .  .  .  1   .   .  .      .   0  .    25  .   .   .04  1    .    .    .125 .     .3   0    0    1000 1000  .    .    


;SOUNDWARP
;p1  p2  p3      p4   
;in  st  dur     amp  
;--------------------------------------------------------------------------------------------------------------------------------------------------
i2   0   56.32    80   


;GLOBAL COMB
;p1     p2      p3    p4     p5       
;ins	strt	dur   time	 loop	
;--------------------------------------------------------------------------------------------------------------------------------------------------
i198	 0		195   20	 .5


;GLOBAL REVERB
;p1        p2   p3    p4      p5  
;instr     St   Dur   rvbtim  hiatn    
;--------------------------------------------------------------------------------------------------------------------------------------------------
i199       0    195   1      .5
e


</CsScore>
</CsoundSynthesizer>
