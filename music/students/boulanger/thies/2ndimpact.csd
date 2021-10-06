<CsoundSynthesizer>
<CsOptions>
</CsOptions>
<CsInstruments>

;Second Impact
;matthew j thies - December 2000


sr      =       44100
kr      =       4410
ksmps   =       10
nchnls  =       2

gacmb1	init	0
gacmb2	init	0
        

strset  1, "think"					;2.70 sec
strset  2, "Stomping.con"			;1.447 sec	


        instr   1			;STEREO GRANULAR SAMPLE PROCESSOR 
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
k1		linseg  0, 0.3*p3, 1, 0.5*p3, 1, 0.2*p3, 0
kfco1	expseg	ifcost, p3, ifcoend 
kfco2	expseg	ifcoend, p3, ifcost 
kres	linseg	2, p3, 1

;ar 	granule xamp, ivoice, iratio, imode, ithd, ifn, ipshift, igskip, igskip_os, ilength, 
;       kgap, igap_os, kgsize, igsize_os, iatt, idec [,iseed] [,ipitch1] [,ipitch2] [,ipitch3] [,ipitch4] [,ifnenv]
 
a1      granule kamp*k1, ivoice, iratio, imode, ithd, ifn, ipshift, igskip, igskipos, ilength, kgpenv, igapos, kgsize, igsizeos, iatt, idec, iseed, ipch1, ipch2, ipch3, ipch4, ifnenv
a2      granule kamp*k1, ivoice, iratio, imode, ithd, ifn, ipshift, igskip, igskipos, ilength, kgpenv, igapos, kgsize, igsizeos, iatt, idec, iseed+.11, ipch1, ipch2, ipch3, ipch4, ifnenv

klfo	oscili	ilfoamp, ilfofrq, 6
;ar     rezzy   asig, xfco, xres[, imode]
a3		rezzy	a1, kfco1+klfo, kres, 0        
a4		rezzy	a2, kfco2+klfo, kres, 0     
        
        outs    a3, a4

gacmb1	=		gacmb1+(a3*icmbsnd)
gacmb2	=		gacmb2+(a4*icmbsnd)

     	endin

;--------------------------------------------------------------------------------------------------------------------------------------------------
       instr 5					;CAUCHY NOISE

idur   	=     	p3             	;Duration
iamp   	=     	p4	         	;Amplitude
ialpha 	=     	p5
kfco	=		3500
kres	=		2
kenv	linseg	0, p3*.2, 1, p3*.6, 1, p3*.2, 0
klfo	oscili	100, .25, 6
asig   	cauchy  ialpha       	;Random number generator -iamp to iamp
aout	rezzy	asig, kfco+klfo, kres, 0        
ascl	=		aout*iamp
       	outs  	ascl*kenv, ascl*kenv 	    

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
icmbsnd		=			p11
kmix		expseg		imix1, p3, imix2									;VARIABLE MIX LEVEL
kenv		expseg		.001, p3*iatk, .001, .02, 1, p3*isus, 1, p3*idec, .001		;DECLICK		
adry		soundin		iexcite												;DRY
awet        convolve	adry, irespond, 1									;WET
awet		diff		awet												;EMPHASIZE HIGHS	
adrydel     delay	    (1-kmix)*adry,idel									;LINE UP WET AND DRY SIGNALS
amix		= 		    ivol*(adrydel+kmix*awet)       						;MIX WET AND DRY	
aout		=			amix*kenv
			outs		aout, aout		 

gacmb1		=			gacmb1+(aout*icmbsnd)
gacmb2		=			gacmb2+(aout*icmbsnd)
			 
			endin

;--------------------------------------------------------------------------------------------------------------------------------------------------
              instr       198                ; GLOBAL ECHO
 idur         =           p3
 itime        =           p4
 iloop        =           p5
 kenv         linen       1, .01, idur, .01
 acomb1       comb        gacmb1, itime, iloop, 0
 acomb2       comb        gacmb2, itime, iloop, 0
              outs        acomb2*kenv, acomb1*kenv
 gacmb1       =           0
 gacmb2       =           0
  
              endin

</CsInstruments>
;--------------------------------------------------------------------------------------------------------------------------------------------------
;--------------------------------------------------------------------------------------------------------------------------------------------------
<CsScore>


f 1 0  262144 1 "think"   0 4 0				;2.700 sec
f 2 0 1048576 1 "Gagakuflute.aif"   0 4 0	;9.828 sec
f 5 0  131072 1 "Violin.aif"   0 4 0		;1.210 sec
f 6 0 8192 10 1     						;SINE FUNCTION

f12 0 2 -2  2  1.447						;Stomping


;GRANULE SAMPLE PROCESSING INSTRUMENT
;p1 p2     p3    p4   p5 p6       p7 p8 p9 p10 p11 p12  p13  p14 p15 p16 p17 p18 p19  p20  p21  p22  p23 p24   p25  p26  p27  p28  p29    p30    p31
;in st     dur   amp  V  R        M  TH FN PS  GS  GSO  L    GPO SZ  SZO AT  DC  SD   PS1  PS2  PS3  PS4 FNENV CMB  GP1  GP2  FC1  FC2    LFOMOD LFOFRQ
;------------------------------------------------------------------------------------------------------------------------------------------------------------
;think
i1   0     43     70  12  .0625    1  0  1  2   0   0  2.70   25 .01  10  30  30  .43  1   .25   0    0   0     .2   0    0    500  5000   0      0
i1   0     .      .   .   .        .  .  .  .   .   .  .      .  .    .   .   .   .    .   .     .    .   .     .    .    .    5000 500    .      .
i1  68     10     68   6  .        .  .  .  .   .   .  .      .  .    .   .   .   .26  .   .     .    .   .     .    .    .    5000 500    .      .
i1  88      5     69  12  .125     .  .  .  .   .   .  .      .  .    .   .   .   .36  .   .     .    .   .     .    .    .    5000 500    .      .
i1  88     10     70  .   .        .  .  .  .   .   .  .      .  .    .   .   .   .49  .   .     .    .   .     .    .    .    5000 500    .      .
i1  98     20     68   6  .0625    .  .  .  3   .   .  .      .  .    .   .   .   .26  .   .     .9   .   .     .    .    .    5000 500    .      .
i1 129     15     69  12  .015625  .  .  .  2   .   .  .      .  .    .   .   .   .19  .   .5    .    .   .     .    .    .    500  5000   .      .
i1 169     20     69  12  .03125   .  .  .  2   .   .  .      .  .    .   .   .   .37  .   .5    .    .   .     .    .    .    500  5000   .      .
i1 180     10     68  .   .0625    .  .  .  3   .   .  .      .  .    .   .   .   .40  .   .     .    .   .     .    .    .    1000 100    .      .
i1 198     .      68  .   .        .  .  .  .   .   .  .      .  .    .   .   .   .25  .   .     .    .   .     .    .    .    1000 100    .      .

;violin 
i1  18     122    65  12  .0078125 0  0  5  2   0   0  1.210  10 .1   10  30  30  .13  .5  .125  1    0   0     .8   0    0    500  1000   .3     .5
i1 143.28  70     63  .   .        .  .  .  4   .   .  .      15 .    .   .   .   .34  .   .     .9   .25 .     .    .    .    .    .      .      . 

;flute
i1  50     96.28  75  12  1        0  0  2  2   0   0  9.828  10 .01  10  30  30  .43  .5  .125  0    0   0     .2   0    0    500  1000   .1     .5
i1 143.28   9.2   75  .   2        .  .  .  .   .   .  2.300  .  .    .   .   .   .22  .   .0625 .    .   .     .8   .    .    5000 .      .      . 
i1 153.28  19.656 72  .   1        .  .  .  .   .   .  9.828  .  .    .   .   .   .    .   .125  .    .   .     .2   .    .    500  100    .      . 
i1 153.28  .      75  .   4        .  .  .  .   .   .  .      .  .    .   .   .   .    .   .0625 .    .   .     .8   .    .    5000 1000   .      . 
i1 172.936 .      73  .   1        .  .  .  .   .   .  .      .  .    .   .   .   .    .   .125  .    .   .     .5   .    .    500  .      .2     . 


;CAUCHY NOISE
;p1 p2   p3   p4    p5
;   Sta  Dur  Amp   Alpha
;-----------------------------------------------------------------------------------------------------------------------------------------------------------
i5   30  60   2000 .01     


;CONVOLUTION INSTRUMENT
;p1   p2  p3    p4  p5     p6  p7  p8  p9  p10  p11 
;ins  st  dur   vol excite fn  mx1 mx2 atk dec  cmb
;-----------------------------------------------------------------------------------------------------------------------------------------------------------
i10   51  3.53 .06  1      12  .6  .4  .10 .11  .3
i10  195  5    .08  .      .   .5  .3  .30 .2   .2


;GLOBAL COMB
;p1  p2   p3    p4   p5       
;ins strt dur   time loop	
;------------------------------------------------------------------------------------------------------------------------------------------------------------
i198 0    220   10  .3 	
e

</CsScore>
</CsoundSynthesizer>
