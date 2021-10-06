

; GRANULE.ORC
; ORCHESTRA FILE FOR GENERATING STEREO OUTPUT USING TWO GRANULE OPCODES
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
