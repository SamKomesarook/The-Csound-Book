<CsoundSynthesizer>
<CsOptions>
</CsOptions>
<CsInstruments>

;No Future
;matthew j thies - December 2000

sr      =       44100
kr      =       4410
ksmps   =       10
nchnls  =       2

gacmb1	init	0
gacmb2	init	0
garvb	init	0

strset  1, "coming"					; .905 sec
strset  2, "exist1"					;1.183 sec
strset  3, "exist2"					;1.048 sec
strset  7, "future"					; .603 sec
strset 13, "nofuture"				;1.366 sec
strset 14, "nofuture1"				;1.064 sec
strset 15, "nosuch"					;1.135 sec

strset 53, "nofuture.con"			;1.366 sec
strset 54, "nofuture1.con"			;1.064 sec
strset 55, "nosuch.con"				;1.135 sec
strset 66, "Stomping.con"			;1.447 sec	
strset 67, "fiveEchos.con"			;1.485 sec
;--------------------------------------------------------------------------------------------------------------------------------------------------
        instr   1		;GRANULAR SAMPLE PROCESSING INSTRUMENT
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
igapos  =   p14
kgsize  =   p15
igsizeos=   p16
iatt    =   p17
idec    =   p18
iseed   =   p19
ipch1   =   p20
ipch2   =   p21
ipch3   =   p22
ipch4   =   p23
ifnenv  =   p24
icmbsnd =   p25
igap1 	=	p26
igap2	=	p27
ifcost	=	p28
ifcoend	=	p29
iscale	=	p30
ilfoamp	=	iscale*ifcoend
ilfofrq	=	p31

kgpenv	linseg	igap1, p3, igap2
k1		linseg  0, 0.15*p3, 1, 0.65*p3, 1, 0.2*p3, 0
kfco1	expseg	ifcost, p3, ifcoend 
kfco2	expseg	ifcoend, p3, ifcost 
kres	linseg	3, p3, 1

;ar 	granule xamp, ivoice, iratio, imode, ithd, ifn, ipshift, igskip, igskip_os, ilength, 
;       kgap, igap_os, kgsize, igsize_os, iatt, idec [,iseed] [,ipitch1] [,ipitch2] [,ipitch3] [,ipitch4] [,ifnenv]
 
a1      granule kamp*k1, ivoice, iratio, imode, ithd, ifn, ipshift, igskip, igskipos, ilength, kgpenv, igapos, kgsize, igsizeos, iatt, idec, iseed, ipch1, ipch2, ipch3, ipch4, ifnenv
a2      granule kamp*k1, ivoice, iratio, imode, ithd, ifn, ipshift, igskip, igskipos, ilength, kgpenv, igapos, kgsize, igsizeos, iatt, idec, iseed+.11, ipch1, ipch2, ipch3, ipch4, ifnenv

klfo	oscili	ilfoamp, ilfofrq, 5
;ar     rezzy   asig, xfco, xres[, imode]
a3		rezzy	a1, kfco1+klfo, kres, 0        
a4		rezzy	a2, kfco2+(klfo-50), kres, 0     
        
        outs    a3, a4

gacmb1	=		gacmb1+(a3*icmbsnd)
gacmb2	=		gacmb2+(a4*icmbsnd)

     	endin
;--------------------------------------------------------------------------------------------------------------------------------------------------
									;IRdur = impulse response duration
									;duration = (sample frames)/(sample rate of soundfile)
									;1/kr=.000227
									
									;Delay Calculation for 1/kr<= IRdur 
									;Delay = ceil(IRdur * kr) / kr
									
									;Delay Calculation for 1/kr > IRdur 
									;Delay = IRdur * ceil(1/(kr*IRdur))
									
																		
			instr 10	; CONVOLUTION INSTR WITH VARIABLE WET/DRY MIX
ivol		=			p4
iexcite		=			p5
irespond	table 		0, p6
idel		table  		1, p6												
imix1		=			p7
imix2		=          	p8			
iatk		=			p9
idec		=			p10
isus		=			1-(iatk+idec+.01)
irvbsnd		=			p11
kmix		expseg		imix1, p3, imix2									;VARIABLE MIX LEVEL
kenv		expseg		.001, p3*iatk,.001, .05, 1, p3*isus, 1, p3*idec, .001		;DECLICK		
adry		soundin		iexcite												;DRY
awet        convolve	adry, irespond, 1									;WET
awet		diff		awet												;EMPHASIZE HIGHS	
adrydel     delay	    (1-kmix)*adry,idel									;LINE UP WET AND DRY SIGNALS
amix		= 		    ivol*(adrydel+kmix*awet)       						;MIX WET AND DRY	
aout		=			amix*kenv
			outs		aout, aout		 
garvb	    =	    	garvb+(aout*irvbsnd)
			 
			endin

;--------------------------------------------------------------------------------------------------------------------------------------------------
            instr      198                ;GLOBAL ECHO
idur        =          p3
itime       =          p4
iloop       =          p5
kenv        linen      1, .01, idur, .01
acomb1      comb       gacmb1, itime, iloop, 0
acomb2      comb       gacmb2, itime, iloop, 0
            outs       acomb2*kenv, acomb1*kenv
gacmb1      =          0
gacmb2      =          0
 
            endin
;--------------------------------------------------------------------------------------------------------------------------------------------------
		    instr 199                     ;GLOBAL REVERB
irvbtim		=		p4
ihiatn	    =		p5
arvb	    nreverb	garvb, irvbtim, ihiatn
		    outs	arvb, arvb
garvb	    =		0
		    endin

</CsInstruments>
;--------------------------------------------------------------------------------------------------------------------------------------------------
;--------------------------------------------------------------------------------------------------------------------------------------------------
<CsScore>
f 1 0   65536 1 "future" 0 4 0				; .603 sec
f 2 0   16384 1 "fu"     0 4 0				; .163 sec
f 3 0    8192 1 "shiu"   0 4 0				; .076 sec
f 4 0 1048576 1 "hickspvoc.aif"   0 4 0		;5.216 sec
f 5 0 8192 10 1     						;SINE FUNCTION

;         st   del
f23 0 2 -2 53  1.366		;nofuture
f24 0 2 -2 54  1.064 		;nofuture1
f25 0 2 -2 55  1.135		;nosuch
f36 0 2 -2 66  1.447		;Stomping
f37 0 2 -2 67  1.485		;fiveEchos


;GRANULE SAMPLE PROCESSING INSTRUMENT
;p1 p2  p3   p4   p5 p6       p7 p8 p9 p10 p11 p12  p13  p14 p15 p17 p18 p18 p19  p20  p21  p22  p23 p24   p25  p26  p27  p28  p29    p30   p31
;in st  dur  amp  V  R        M  TH FN PS  GS  GSO  L    GPO SZ  SZO AT  DC  SD   PS1  PS2  PS3  PS4 FNENV CMB  GP1  GP2  FC1  FC2    SCALE LFOFRQ
;------------------------------------------------------------------------------------------------------------------------------------------------------------
i1   0 	83   75   6  .0625    1  0  4  2   0   0  5.216  0  .10  10  30  30  .03  .5  .25   0    0   0     .8   0    0    500  1000   .2    .5
i1  20	60   77  12  .        .  .  .  .   .   .  .      25 .50  >   .   .   .04  1   .5    .    .   .     >    .5   .5   >    >      >     >
i1  60 	83   .    .  .        .  .  .  .   .   .  .      0  .01  .   .   .   .05  .5  .25   .    .   .     .    0    0    .    .      .     .
i1 100	.    .    .  .        .  .  .  3   .   .  .      .  .25  15  .   .   .24  1   .125 1.42  .   .     .    .    .    1000 5000   .     .
i1 150	.    .    6  .        .  .  .  4   .   .  .      .  .    10  .   .   .13  .   .     .29  .9  .     .5   .    .    .    10000  .     .
i1 180  20   72  12  .0078125 0  .  1  2   .   .  .603   .  .01  .   .   .   .03  .   .25   0    0   .     .8   .    .    .    500    0     0


;CONVOLUTION INSTRUMENT
;p1   p2  p3  p4    p5     p6  p7  p8  p9  p10  p11
;ins  st  dur vol   excite fn  mx1 mx2 atk dec  rvbsnd
;-----------------------------------------------------------------------------------------------------------------------------------------------------------
i10   11  4   .075  14     37  .9  .5  .2  .1   .1
i10   21  .   .085  15     .   .   .   .   .    . 
i10   96  .   .017  13     36  .4  .2  .25 .2   0
i10  150  .   .026  15     .   .   .   .37 .    .
i10  200  .   .025  14     .   .   .   .36 .    .
i10  210  .   .      3     .   .   .   .37 .    .


;GLOBAL COMB
;p1  p2   p3    p4   p5       
;ins strt dur   time loop	
;------------------------------------------------------------------------------------------------------------------------------------------------------------
i198 0    235   5   .7 	


;GLOBAL REVERB
;p1  p2  p3   p4      p5  
;ins St  Dur  rvbtim  hiatn    
;-------------------------------------------------------------------------------------------------------------------------------------------------
i199 0   235  1      .5
e

</CsScore>
</CsoundSynthesizer>
