<CsoundSynthesizer>
<CsOptions>
</CsOptions>
<CsInstruments>

;Time Dilation
;matthew j thies - september 2000

sr      =       44100
kr      =       4410
ksmps   =       10
nchnls  =       2

gacmb1	init	0
gacmb2	init	0
        
        instr   1
kamp    =   p4
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

kgpenv	linseg	igpstrt, p3, igpend
k1		linseg  0, 0.1*p3, 1, 0.6*p3, 1, 0.3*p3, 0
kfco1	expseg	ifcost, p3, ifcoend 
kfco2	expseg	ifcost, p3, ifcoend 
kres1	linseg	3, p3, 1
kres2	linseg	3, p3, 1

;ar 	granule xamp, ivoice, iratio, imode, ithd, ifn, ipshift, igskip, igskip_os, ilength, 
;       kgap, igap_os, kgsize, igsize_os, iatt, idec [,iseed] [,ipitch1] [,ipitch2] [,ipitch3] [,ipitch4] [,ifnenv]
 
a1      granule kamp*k1, ivoice, iratio, imode, ithd, ifn, ipshift, igskip, igskipos, ilength, kgpenv, igapos, kgsize, igsizeos, iatt, idec, iseed, ipch1, ipch2, ipch3, ipch4, ifnenv
a2      granule kamp*k1, ivoice, iratio, imode, ithd, ifn, ipshift, igskip, igskipos, ilength, kgpenv, igapos, kgsize, igsizeos, iatt, idec, iseed+.17, ipch1, ipch2, ipch3, ipch4, ifnenv

;ar 	comb 	asig, krvt, ilpt[, istor]

;ar     rezzy   asig, xfco, xres[, imode]
a3		rezzy	a1, kfco1, kres1, 0        
a4		rezzy	a2, kfco2, kres2, 0     
        
        outs    a3, a4

gacmb1	=		gacmb1+(a3*icmbsnd)
gacmb2	=		gacmb2+(a4*icmbsnd)

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
f 1 0 524288 1 "female.aif" 0 4 0	; 4.496 sec

;Tempo statements
;   t1  tempo1  t2  tempo2  t3  tempo3  t4  tempo4  t5  tempo5  
t   0   60      45  60      55  58      85  65      116 60 

;GRANULE SAMPLE PROCESSING INSTRUMENT
;in st     dur  amp  V  R    M  TH FN PS  GS  GSO L     GP  GPO SZ  SZO AT  DC  SD   PS1  PS2  PS3  PS4 FNENV CMB  GP1  GP2  FC1  FC2
;p1 p2     p3   p4   p5 p6   p7 p8 p9 p10 p11 p12 p13   p14 p15 p16 p17 p18 p19 p20  p21  p22  p23  p24 p25   p26  p27  p28  p29  p30
;---------------------------------------------------------------------------------------------------------------------------------------------
i1  0 	   36.4 4500 6  .25  0  0  1  1   0   0   4.55 .01  10  .5  10  20  20  .39  1    0    0    0   0     .8   1    .1   100  5000
i1  22.75  .    .    12 .    .  .  .  .   .   .   .    .    .   .   .   .   .   .40  .5   .    .    .   .     .    .    .    200  .
i1  36.4   .    .    16 .    .  .  .  2   .   .   .    .    .   .   .   .   .   .38  1    .25  .    .   .     .    .    .    300  7500
i1  54.6   .    .    24 .    .  .  .  .   .   .   .    .    15  .4  .   .   .   .41  .    .5   .    .   .     .    .    .    500  1000
i1  63.7   72.8 .    12 .125 .  .  .  .   .   .   .    .    30  .   .   .   .   .38  .    .    .    .   .     .    .    .5   500  5000
i1  81.9   36.4 .    16 .25  .  .  .  .   .   .   .    .    10  .6  20  .   .   .48  .    .25  .    .   .     .    2    .1   1000 100
i1  104.65 .    5000 6  .    .  .  .  1   .   .   .    .    .   .5  10  .   .   .39  .    0    .    .   .     .    1    .5   100  5000
i1  122.85 .    .    12 .    .  .  .  2   .   .   .    .    .   .4  30  .   .   .47  .    .5   .    .   .     .    1    .5   300  1000
i1  145.6  .    4500 24 .    .  .  .  1   .   .   .    .    .   .5  10  .   .   .39  .5   0    .    .   .     .    .    .    .    5000
i1  154.7  .    .    16 .    .  .  .  2   .   .   .    .    20  .   .   .   .   .36  1    .25  .    .   .     .    .    .1   200  1000
i1  172.9  .    3500 24 .    .  .  .  .   .   .   .    .    .   .   .   .   .   .39  .25  0    .    .   .     .    .    .1   .    .

;do
i1  39 	   10   6000 6   1   1  0  1  1   0   0   1    .01  50  .5  10  5   30  .39  .5   0    0    0   0     .8   1     1  5000  100
i1  55 	   .    .    12  .   .  .  .  .   .   .   .    .    .   .   .   .   .   .39  .    .    .    .   .     .    .     .  .     .  
i1  57 	   .    7000 6   .   .  .  .  .   .   .   .    .    .   .   .   .   .   .39  .25  .    .    .   .     .    .     .  .     .  
i1  62 	   .    6000 6   .   .  .  .  2   .   .   .    .    .   .   .   .   .   .41  .5   .25  .    .   .     .    .     .  .     .  
i1  70 	   .    .    12  .   .  .  .  1   .   .   .    .    .   .   .   .   .   .40  .    .    .    .   .     .    .     .  .     .  
i1  86 	   .    7000 6   .   .  .  .  2   .   .   .    .    .   .   .   .   .   .39  .25  .125 .    .   .     .    .     .  .     .  
i1  91 	   .    6000 10  .   .  .  .  1   .   .   .    .    .   .   .   .   .   .44  .5   .    .    .   .     .9   .     .  .     .  
i1  99 	   .    7000 12  .   .  .  .  .   .   .   .    .    .   .   .   .   .   .47  .    .    .    .   .     .    .     .  .     .  
i1  116	   .    6000 6   .   .  .  .  .   .   .   .    .    .   .   .   .   .   .51  .    .    .    .   .     .8   .     .  .     .  
i1  124	   .    6000 12  .   .  .  .  .   .   .   .    .    .   .   .   .   .   .51  .125 .    .    .   .     .    .     .  .     .  
i1  136	   .    5000 6   .   .  .  .  2   .   .   .    .    .   .   .   .   .   .39  .5   .25  .    .   .     .7   .     .  .     .  
i1  148	   .    4500 12  .   .  .  .  1   .   .   .    .    .   .   .   .   .   .39  .    .    .    .   .     .    .     .  .     .  
i1  158	   .    4000 6   .   .  .  .  .   .   .   .    .    .   .   .   .   .   .39  .    .    .    .   .     .6   .     .  .     .  


;GLOBAL COMB
;p1  p2   p3    p4   p5       
;ins strt dur   time loop	
;--------------------------------------------------------------------------------------------------------------------------------------------------
i198 0    211   10   .5 	
e


</CsScore>
</CsoundSynthesizer>
