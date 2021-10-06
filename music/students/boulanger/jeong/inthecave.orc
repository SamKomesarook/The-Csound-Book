;Yong-Jin Jeong "in the Cave"  May.2000

sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         2

garvb   init   0

          

           instr     1

aout init 0
kdeclick  linen     1, .01,p3,.01

 iamp 	= 	p5
ifdbk     =         1                       
ipor      =         cpspch(p4)
ipor2     =         cpspch(p5)
imod1     =         7*ipor
iwhite      =        50
indx1     =         7
imod2     =        1.77*ipor
indx2     =         7
ipanfrq =    p6
irvbsnd =    p7
;kndx1     linseg    0,p3/3,indx1,p3/2,indx1
;kndx1      expseg  p4, p3/2, p5, p3/2, p4
kndx1      expseg  ipor, p3/2, ipor2, p3/2, ipor
;kndx2     linseg    0,p3/2,indx2,p3/3,indx2
kndx2      expseg  p4, p3/2, p5, p3/2, p4
;kndx2      expseg  ipor, p3/2, ipor2, p3/2, ipor 
kpan            oscil    .5, ipanfrq, 1   
amod1     oscil3    imod1*kndx1,imod1/10,1
;amod2     oscil3    imod2*kndx2,(imod2+amod1)/10,1
amod2     rand      iwhite
apor      oscil3    iamp/5, (ipor+amod2)/2, 1
;apor      oscil3    iamp, iwhite, 1
;apor      oscil3    iamp,  (kndx1+ipor)/kndx2-(amod1/amod2)+(ipor*kndx2)+kndx1, 1
apor2     grain      iamp/5,  amod2,   kndx2/2,  kndx1, kndx1, .05, 1, 1.5, 1
apor3      oscil3    iamp/5, ipor+amod2, 1
;apor3     rand      iwhite
kamp      linen     1,p3/3,p3,p3/3
kpanlfo = kpan+.5
aout      =        apor*apor2*apor3/28
          outs       (aout * kdeclick*apor2*apor3)*(1-kpanlfo),     (aout * kdeclick*apor2*apor3)*kpanlfo
garvb     =      garvb+ (aout * kdeclick*apor2*apor3)*irvbsnd    
          endin
;==================================================================


instr 	3
idur		=		p3					
irvbtim	=		p4
ihiatn	=		p5
arvb		nreverb	garvb, irvbtim, ihiatn
		outs		arvb, arvb
garvb	=		0
		endin


;============================================================



       
        instr   126
idur    =       p3
iamp    =       ampdb(p4)
ifrq    =       cpspch(p5)
iatk    =       p6
irel    =       p7
ivibdel =       p8
imoddpt =       p9
imodfrq =       p10
iharm   =       p11
ipanfrq =    p12
irvbsnd =    p13
kenv    linen   iamp, iatk, idur, irel
kpan    oscil   .5, ipanfrq, 1
kvibenv linseg  0, ivibdel, 1, idur-ivibdel, .3
klfo    oscil   kvibenv*imoddpt, imodfrq, 1 
asig    buzz    kenv, iharm*klfo*10, kvibenv, 1
a1       grain   klfo+100, (klfo+kpan)*1.6, (kpan*klfo)+p9, p4, p9, .05, 1, 1.5, 1
a2       linen    a1, klfo*2, p3, klfo*2
kpanlfo =      kpan+.5
            outs     3*a2*asig*kpanlfo, 3*a2*asig*(1-kpanlfo) 
garvb     =      garvb+ (asig*irvbsnd)                     
            endin
;========================================================
         instr 	199
idur		=		p3					
irvbtim	=		p4
ihiatn	=		p5
arvb		nreverb	garvb, irvbtim, ihiatn
		outs		arvb, arvb
garvb	=		0
		endin

 
