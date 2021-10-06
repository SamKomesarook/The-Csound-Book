<CsoundSynthesizer>
<CsOptions>
</CsOptions>
<CsInstruments>

;Immersion
;matthew j thies - October 2000

sr      =  	44100
kr    	=  	4410
ksmps  	=  	10
nchnls	=	2

gacmb	init	0
garvb	init	0

        instr   1		;GRANULAR SAMPLE PROCESSOR
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

kgpenv	linseg	igpstrt, p3, igpend
k1		linseg  0, .2*p3, 1, .5*p3, 1, .3*p3, 0
kfco1	expseg	ifcost, p3, ifcoend 
kfco2	expseg	ifcost, p3, ifcoend 
kres1	linseg	3, p3, 1
kres2	linseg	3, p3, 1

;ar 	granule xamp, ivoice, iratio, imode, ithd, ifn, ipshift, igskip, igskip_os, ilength, 
;       kgap, igap_os, kgsize, igsize_os, iatt, idec [,iseed] [,ipitch1] [,ipitch2] [,ipitch3] [,ipitch4] [,ifnenv]
 
a1      granule kamp*k1, ivoice, iratio, imode, ithd, ifn, ipshift, igskip, igskipos, ilength, kgpenv, igapos, kgsize, igsizeos, iatt, idec, iseed, ipch1, ipch2, ipch3, ipch4, ifnenv
a2      granule kamp*k1, ivoice, iratio, imode, ithd, ifn, ipshift, igskip, igskipos, ilength, kgpenv, igapos, kgsize, igsizeos, iatt, idec, iseed+.13, ipch1, ipch2, ipch3, ipch4, ifnenv

;ar     rezzy   asig, xfco, xres[, imode]
a3		rezzy	a1, kfco1, kres1, 0        
a4		rezzy	a2, kfco2, kres2, 0     
        
        outs    a3, a4

garvb	=	    garvb+(a1*irvbsnd)

     	endin

;--------------------------------------------------------------------------------------------------------------------------------------------------
        	instr   2					;FOF W/ENVELOPES, VOWEL INSTR 		

;ir         table   indx, ifn[, ixmode[, ixoff[, iwrap]]]

iform1 		table    0, p18
iform2 		table    1, p18
iform3 		table    2, p18
iform4 		table    3, p18
iform5 		table    4, p18
iamp1		table    5, p18
iamp2 		table    6, p18
iamp3 		table    7, p18
iamp4 		table    8, p18
iamp5 		table    9, p18
ibw1 		table    10,p18
ibw2 		table    11,p18
ibw3 		table    12,p18
ibw4 		table    13,p18
ibw5 		table    14,p18
imp1 		=        ampdb(iamp1)
imp2 		=        ampdb(iamp2)
imp3 		=        ampdb(iamp3)
imp4 		=        ampdb(iamp4)
imp5 		=        ampdb(iamp5)

kenv1		linseg	1, p3, 1
kenv2		linseg	0, p3*.2, 1
kenv3		linseg	0, p3*.4, 1
kenv4		linseg	0, p3*.6, 1
kenv5		linseg	0, p3*.8, 1

iamp		=		ampdb(p4)
ifund1		=		p5  
ifund2		=		p6

ioct1		=		p7 
ioct2		=		p8

iris		=		p9  
idur		=		p10 
idec		=		p11 
iolaps		=		p12 				;roughly --> kfund * kdur
ifna		=		1 
ifnb		=		2 
iphs		=		p13
ifmode		=		p14 
kpan		=		p15
irvbsnd		=		p16     			;reverb send range 0-1
icmbsnd		=		p17
itotdur		=		p3
ipanfn		=		p19
ipanrt1		=		p20
ipanrt2		=		p21
;--------------------------------------------------------------------------------------------------------------------------------------------------
kampenv     expseg  .01, p3*.2, 1, p3*.6, .6, p3*.2, .01       		 			;AMPLITUDE ENVELOPE
kfundenv    expseg	ifund1, p3, ifund2											;FUNDAMENTAL ENVELOPE
koctenv     linseg  ioct1, p3, ioct2											;OCTAVIATION ENVELOPE
kcmbsnd		linseg	.1, p3, icmbsnd												;DELAY SEND ENVELOPE
kpanrt		linseg  ipanrt1, p3, ipanrt2
kpnoscenv	oscil	1, 1/p3, 9													;PANNING OSCIL ENVELOPE 
kpanenv		oscil	1, 1/p3*kpanrt, ipanfn										;PANNING OSCIL
;--------------------------------------------------------------------------------------------------------------------------------------------------
;ar      	fof     xamp, xfund, xform, koct, kband, kris, kdur, kdec,iolaps, ifna, ifnb, itotdur[, iphs][, ifmode]
asig1      	fof     iamp1*kenv1, kfundenv, iform1, koctenv, ibw1, iris, idur, idec, iolaps, ifna, ifnb, itotdur, iphs, ifmode
asig2      	fof     iamp2*kenv2, kfundenv, iform2, koctenv, ibw2, iris, idur, idec, iolaps, ifna, ifnb, itotdur, iphs, ifmode
asig3      	fof     iamp3*kenv3, kfundenv, iform3, koctenv, ibw3, iris, idur, idec, iolaps, ifna, ifnb, itotdur, iphs, ifmode
asig4      	fof     iamp4*kenv4, kfundenv, iform4, koctenv, ibw4, iris, idur, idec, iolaps, ifna, ifnb, itotdur, iphs, ifmode
asig5      	fof     iamp5*kenv5, kfundenv, iform5, koctenv, ibw5, iris, idur, idec, iolaps, ifna, ifnb, itotdur, iphs, ifmode
asig		=		(asig1+asig2+asig3+asig4+asig5)/5
asigsc		=		asig*iamp
a1      	=		asigsc * kampenv                
        	outs    a1 * kpanenv, a1 * (1 - kpanenv)

garvb	    =	    garvb+(a1*irvbsnd)
gacmb		=		gacmb+(a1*icmbsnd)
        	endin


;--------------------------------------------------------------------------------------------------------------------------------------------------
		instr 3						;FM BELL
kamp	=		ampdb(p4)
kfreq	=		cpspch(p5)
kc1		=		p6
kc2		=		p7
kvdepth	=		p8
kvrate	=		p9
ifn1	=		1
ifn2	=		1
ifn3	=		1
ifn4	=		1
ivfn	=		1
iatk	=		p10
irvbsnd =		.1

kenv	linseg	0, p3*iatk, 1
;ar     fmbell  kamp, kfreq, kc1, kc2, kvdepth, kvrate, ifn1, ifn2, ifn3, ifn4, ivfn
asig	fmbell	kamp*kenv, kfreq, kc1, kc2, kvdepth, kvrate, ifn1, ifn2, ifn3, ifn4, ivfn
		outs	asig, asig
garvb	=	    garvb+(asig*irvbsnd)
		endin

;--------------------------------------------------------------------------------------------------------------------------------------------------
			instr	198					;global comb
idur		=		p3
itime 		= 		p4
iloop 		= 		p5
kenv		linen	1, .1, idur, .1
acomb 		comb	gacmb, itime, iloop, 0
			outs	acomb*kenv, acomb*kenv
gacmb		=		0
			endin

;--------------------------------------------------------------------------------------------------------------------------------------------------
		   instr 199                     ;global reverb
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

f 10 0 262144   1 "whatisit.aif" 0 4 0		; 1.70 sec

f12 0 1025 20 2 1   													;HANNING WINDOW
f13	0 4096   5   .001  2048  1  2048  .001								;OSCIL ENVELOPE

;FORMANT TABLES
f20 0 16 -2 800 1150 2900 3900 4950 0  -6 -32 -20 -50 80  90 120 130  140;soprano "a"
f21 0 16 -2 350 2000 2800 3600 4950 0 -20 -15 -40 -56 60 100 120 150  200;soprano "e"
f22 0 16 -2 270 2140 2950 3900 4950 0 -12 -26 -26 -44 60  90 100 120  120;soprano "i"
f23 0 16 -2 450  800 2830 3800 4950 0 -11 -22 -22 -50 70  80 100 130  135;soprano "o"
f24 0 16 -2 325  700 2700 3800 4950 0 -16 -35 -40 -60 50  60 170 180  200;soprano "u"
f25 0 16 -2 800 1150 2800 3500 4950 0  -4 -20 -36 -60 80  90 120 130  140;alto "a"
f26 0 16 -2 400 1600 2700 3300 4950 0 -24 -30 -35 -60 60  80 120 150  200;alto "e"
f27 0 16 -2 350 1700 2700 3700 4950 0 -20 -30 -36 -60 50 100 120 150  200;alto "i"
f28 0 16 -2 450  800 2830 3500 4950 0  -9 -16 -28 -55 70  80 100 130  135;alto "o"
f29 0 16 -2 325  700 2530 3500 4950 0 -12 -30 -40 -64 50  60 170 180  200;alto "u"
f30 0 16 -2 660 1120 2750 3000 3350 0  -6 -23 -24 -38 80  90 120 130  140;countertenor "a"
f31 0 16 -2 440 1800 2700 3000 3300 0 -14 -18 -20 -20 70  80 100 120  120;countertenor "e"
f32 0 16 -2 270 1850 2900 3350 3590 0 -24 -24 -36 -36 40  90 100 120  120;countertenor "i"
f33 0 16 -2 430  820 2700 3000 3300 0 -10 -26 -22 -34 40  80 100 120  120;countertenor "o"
f34 0 16 -2 370  630 2750 3000 3400 0 -20 -23 -30 -34 40  60 100 120  120;countertenor "u"
f35 0 16 -2 650 1080 2650 2900 3250 0  -6  -7  -8 -22 80  90 120 130  140;tenor "a"
f36 0 16 -2 400 1700 2600 3200 3580 0 -14 -12 -14 -20 70  80 100 120  120;tenor "e"
f37 0 16 -2 290 1870 2800 3250 3540 0 -15 -18 -20 -30 40  90 100 120  120;tenor "i"
f38 0 16 -2 400  800 2600 2800 3000 0 -10 -12 -12 -26 40  80 100 120  120;tenor "o"
f39 0 16 -2 350  600 2700 2900 3300 0 -20 -17 -14 -26 40  60 100 120  120;tenor "u"
f40 0 16 -2 600 1040 2250 2450 2750 0  -7  -9  -9 -20 60  70 110 120  130;bass "a"
f41 0 16 -2 400 1620 2400 2800 3100 0 -12  -9 -12 -18 40  80 100 120  120;bass "e"
f42 0 16 -2 250 1750 2600 3050 3340 0 -30 -16 -22 -28 60  90 100 120  120;bass "i"
f43 0 16 -2 400  750 2400 2600 2900 0 -11 -21 -20 -40 40  80 100 120  120;bass "o"
f44 0 16 -2 350  600 2400 2675 2950 0 -20 -32 -28 -36 40  80 100 120  120;bass "u"
 
;Tempo Statement
;t=time
;T=new tempo
; t1 T1  t2  T2  t3  T3  t4  T4  t5  T5
t 0  60  70  60  80  58  100 56  130 58

f0 2 ;two seconds silence
s

;GRANULE SAMPLE PROCESSING INSTRUMENT
;in st     dur  amp V  R       M  TH FN PS  GS  GSO L     GP  GPO SZ  SZO AT  DC  SD   PS1  PS2  PS3  PS4 FNENV CMB  GP1  GP2  FC1  FC2  RVB
;p1 p2     p3   p4  p5 p6      p7 p8 p9 p10 p11 p12 p13   p14 p15 p16 p17 p18 p19 p20  p21  p22  p23  p24 p25   p26  p27  p28  p29  p30  p31
;---------------------------------------------------------------------------------------------------------------------------------------------
i1  15    27.2  60  12 .0625   0  0  10 2   0   0   1.70  0   0  .5   50  40  40  0    .5   .25  0    0   0     0    0    0    100  5000 .05
i1  41 	   3.4  54  .   1      .  .  .  3   .   .   1.70  .   .  .    <   .   .   .1   1    .5   .25  .   .     .    .    .    250  5000 <
i1  40    27.2  60  .  .0625   .  .  .  3   .   .   1.70  .   .  .    .   .   .   .25  .5   .25  1    .   .     .    .    .    500  5000 .
i1  66    54.4  61  .  .03125  .  .  .  3   .   .   1.70  .   .  .    .   .   .   <    .5   .25  .125 .   .     .    .    .    1000 5000 .
i1  96    27.2  59  .  .03125  .  .  .  2   .   5   1.70  .   .  .    .   .   .   .    .5   .25  .125 .   .     .    .    .    1000 5000 .
i1  120   27.2  63  .  .0625   .  .  .  4   .   0   1.70  .   .  .    75  .   .   .70  .5   .25  .125 1   .     .    .    .    2500 5000 .
i1  130   13.6  61  .  .0625   .  .  .  3   .  10   1.70  .   .  .    75  .   .   .70  .5   .25  .125 1   .     .    .    .    2500 5000 .
i1  151	  13.6  62  .   .25    .  .  .  2   .   0   1.70  .   .  .    25  .   20  .5   1    .5   0    .   .     .    .    .    5000 5000 .1
i1  164	   3.4  54  .   .25    .  .  .  1   .   .   1.70  .   .  .    25  20  40  <    1    0    0    .   .     .    .    .    5000 5000 <
i1  166	   5.1  54  .   .25    .  .  .  1   .   .   1.70  .   .  .    25  20  40  .    1    0    0    .   .     .    .    .    5000 5000 .
i1  168	   3.6  53  .   .5     .  .  .  1   .   .   1.70  .   .  .    25  20  40  .1   1    0    0    .   .     .    .    .    5000 5000 .2
i1  170	   5.1  54  .   .25    .  .  .  1   .   7   1.70  .   .  .    25  20  40  .05  1    0    0    .   .     .    .    .    5000 5000 .075
i1  172	   1.7  55  .   1      .  .  .  1   .   0   1.70  .   .  .    25  20  40  0    1    0    0    .   .     .    .    .    5000 5000 .08


;FOF VOWEL CLICKS
;p1      p2    p3    p4    p5	  p6     p7     p8    p9    p10    p11   p12   p13   p14    p15   p16      p17   p18   p19   p20    p21
;instr   st    dur   amp   fund1  fund2  oct1  oct2   ris   dur1   dec   olaps phs   fmode  pan   rvbsnd  cmbsnd table panfn panrt1 panrt2
;------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
i2       10    160   62    2      2 	 1     0     .003   .02    .007  50    0     1      1     .1      .9 	 35    3     1      5
i2       50    122   52    2      5   	 0     .     .      .     .      50    0     .      0     .       . 	 25    7     120    60
i2       80     92   50    6      5   	 .     .     .      .     .      50    0     .      0     .       . 	 20    8     160    90
 
;BELL
;p1   p2    p3  p4  p5    p6  p7  p8    p9    p10
;inst st    dur amp frq   c1  c2  vdpth vrate atk
;--------------------------------------------------------------------------------------------------------------------------------------------------
i3    0      6   70  8.02  1   5   .5    5    .5
i3    .5     .   .   7.02  .   .   .     .    .
i3    1.5    .   .   7.05  .   .   .     .    .

i3    7      .   .   8.02  2   8   .4    4    .3
i3    7.5    .   .   7.02  .   .   .     .    .
i3    8.5    .   .   7.05  .   .   .     .    .
  
i3    14     .   .   8.02  4   9   .3    3    .2
i3    14.5   .   .   7.02  .   .   .     .    .
i3    15.5   .   .   7.05  .   .   .     .    .
 
i3    16     .   66  6.02  2   .   .     .    .5
  
i3    21     .   70  8.02  5   8   .2    4    .2
i3    21.5   .   .   7.02  .   .   .     .    . 
i3    22.5   .   .   7.05  .   .   .     .    .
 
i3    28     5   .   8.02  7   10  .2    5    .3
i3    28.5   .   .   7.02  .   .   .     .    . 
i3    29.5   .   .   7.05  .   .   .     .    .
 
i3    35     .   .   8.02  5   9   .2    6    .4
i3    35.5   .   .   7.02  .   .   .     .    . 
i3    36.5   .   .   7.05  .   .   .     .    .

i3    42     .   .   8.02  3   10  .3    4    .5
i3    42.5   .   .   7.02  .   .   .     .    . 
i3    43.5   .   .   7.065 .   .   .     .    .
i3    44     .   .   7.05  .   .   .     .    .
 
i3    49     .   .   8.02  1   9   .5    2    .3
i3    49.5   .   .   7.02  .   .   .     .    . 
i3    50.5   .   .   7.065 .   .   .     .    .
i3    51     .   .   7.05  .   .   .     .    .

i3    56     .   .   8.02  2   8   .7    2    .2
i3    56.5   .   .   7.02  .   .   .     .    . 
i3    57.5   .   .   7.065 .   .   .     .    .
i3    58     .   .   7.05  .   .   .     .    .

i3    58     .   .   6.02  .   .   .     .    .5
 
i3    63     .   .   8.02  1   7   .5    3    .2
i3    63.5   .   .   7.02  .   .   .     .    . 
i3    64.5   .   .   7.065 .   .   .     .    .
i3    65     .   .   7.05  .   .   .     .    .
 
i3    70     .   .   8.02  3   8   .2    4    .2
i3    70.5   .   .   7.02  .   .   .     .    . 
i3    71.5   .   .   7.065 .   .   .     .    .
i3    72     .   .   7.05  .   .   .     .    .

i3    77     .   72  8.02  4   8   .2    4    .3
i3    77.5   .   .   7.02  .   .   .     .    . 
i3    78.5   .   .   7.065 .   .   .     .    .
i3    79     .   .   7.05  .   .   .     .    .

i3    79     .   .   6.02  .   .   .     .    .

i3    84     7   .   8.02  5   8   .2    4    .4
i3    84.5   .   .   7.02  .   .   .     .    . 
i3    85.5   .   .   7.065 .   .   .     .    .
i3    86     .   .   7.05  .   .   .     .    .

i3    86     .   .   6.02  .   .   .     .    .5

i3    91     .   .   8.02  6   8   .2    4    .5
i3    91.5   .   .   7.02  .   .   .     .    . 
i3    92.5   .   .   7.065 .   .   .     .    .
i3    93     .   .   7.05  .   .   .     .    .

i3    93     .   .   6.02  .   .   .     3    .4

i3    99     .   .   8.02  7   8   .2    4    .4
i3    99.5   .   .   7.02  .   .   .     .    . 
i3    100.5  .   .   7.065 .   .   .     .    .
i3    101    .   .   7.05  .   .   .     .    .

i3    100    .   .   6.02  .   .   .     3    .4

i3    107    .   .   8.02  8   8   .2    4    .3
i3    107.5  .   .   7.09  .   .   .     .    . 
i3    108.5  .   .   7.02  .   .   .     .    . 
i3    109    .   .   7.065 .   .   .     .    .
i3    110.5  .   .   7.05  .   .   .     .    .

i3    110    .   .   6.02  .   .   .     2    .4

i3    115    .   .   8.02  7   7   .2    4    .2
i3    115.5  .   .   7.02  .   .   .     .    . 
i3    116    .   .   7.065 .   .   .     .    .
i3    116.5  .   .   7.05  .   .   .     .    .

i3    116    .   .   6.02  4   10  .     2    .4

i3    123    .   .   8.02  6   7   .2    4    .2
i3    123.5  .   .   7.09  .   .   .     .    . 
i3    124.5  .   .   7.02  .   .   .     .    . 
i3    125    .   .   7.065 .   .   .     .    .
i3    126.5  .   .   7.05  .   .   .     .    .

i3    126    .   .   6.02  .   7   .     2    .4
;--------------------------------------------------------------------------------------------------------------------------------------------------
i3    131    .   .   8.02  9   5   .2    4    .3
i3    131.5  .   .   7.09  .   .   .     .    . 
i3    132.5  .   .   7.02  .   .   .     .    . 
i3    133    .   .   7.065 .   .   .     .    .
i3    134.5  .   .   7.05  .   .   .     .    .

i3    133    .   .   6.02  .   .   .     2    .4

i3    138    .   .   8.02  10  5   .2    4    .2
i3    138.5  .   .   7.09 .   .   .     .    . 
i3    139.5  .   .   7.02  .   .   .     .    . 
i3    140    .   .   7.065 .   .   .     .    .
i3    141.5  .   .   7.05  .   .   .     .    .

i3    140    .   .   6.02  .   .   .     2    .4

i3    145    .   .   8.02  8   6   .2    4    .3
i3    145.5  .   .   7.02  .   .   .     .    . 
i3    146    .   .   7.065 .   .   .     .    .
i3    146.5  .   .   7.05  .   .   .     .    .

i3    146    .   .   6.02  .   .   .     2    .4

i3    152    .   .   8.02  7   7   .2    4    .3
i3    152.5  .   .   7.02  .   .   .     .    . 
i3    153.5  .   .   7.05  .   .   .     .    .

i3    153    .   .   6.02  .   .   .     2    .4
;--------------------------------------------------------------------------------------------------------------------------------------------------
i3    131    .   66  9.02  5   5   .2    4    .3
i3    131.5  .   .   8.09  .   .   .     .    . 
i3    132.5  .   .   8.02  .   .   .     .    . 
i3    133    .   .   8.065 .   .   .     .    .
i3    134.5  .   .   8.05  .   .   .     .    .

i3    138    .   .   9.02  4   6   .2    4    .3
i3    138.5  .   .   8.09  .   .   .     .    . 
i3    139.5  .   .   8.02  .   .   .     .    . 
i3    140    .   .   8.065 .   .   .     .    .
i3    141.5  .   .   8.05  .   .   .     .    .

i3    145    .   .   9.02  5   7   .2    4    .2
i3    145.5  .   .   8.02  .   .   .     .    . 
i3    146    .   .   8.065 .   .   .     .    .
i3    146.5  .   .   8.05  .   .   .     .    .

i3    159    .   69  8.02  6   7   .2    4    .3
i3    159.5  .   .   7.02  .   .   .     .    . 
i3    160.5  .   .   7.05  .   .   .     .    .

i3    159    .   67  6.02  5   8   .1    4    .2

i3    162    .   68  6.02  4   9   .2    3    .05

i3    165    .   .   6.02  3   .   .3    2    .1

i3    168    .   .   6.02  3   .   .4    2    .2
 
i3    171    .   .   6.02  3   .   .5    2    .2
  

 
;GLOBAL COMB
;p1     p2      p3      p4      p5       
;ins	strt	dur 	time	loop	
;--------------------------------------------------------------------------------------------------------------------------------------------------
i198	 0		174		20		.5


;GLOBAL REVERB
;p1        p2       p3    p4      p5  
;instr     St       Dur   rvbtim  hiatn    
;--------------------------------------------------------------------------------------------------------------------------------------------------
i199       0        200    1      .5
e


</CsScore>
</CsoundSynthesizer>
