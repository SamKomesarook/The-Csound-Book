sr = 44100
kr = 4410
ksmps = 10
nchnls = 2

garvbsig   init  0
ga2rvbsig  init  0
gasig     init  0
garsig     init  0
garezsig   init  0

instr 1				;tidal
iamp = ampdb(p4)
iatk = p5
idur = p3
irel = p6
ipt1 = p7
itm1 = p8
ipt2 = p9
itm2 = p10
ipt3 = p11
itm3 = p3 - (itm1+itm2)
ipt4 = p12
ifreq = p13
inh   = p14
ifunc = p15
ibw   = p16
ipanrate = 17
ipanfunc = p18
irvt = p19
ilpt = p20
irvbgain = p21
kenv  linen  iamp, iatk, idur, irel
kcf  linseg  ipt1, itm1, ipt2, itm2, ipt3, itm3, ipt4
kpan  oscil  1, 1/p3*ipanrate, ipanfunc
abuzz  buzz  kenv, ifreq, inh, ifunc
acomb  comb  abuzz, irvt, ilpt
ares  reson  acomb, kcf, ibw
aout  delay  ares, .05
	outs aout*sqrt(kpan), aout*(1-sqrt(kpan))
	ga2rvbsig = ga2rvbsig+aout*irvbgain
	endin
	
instr 2				;tidal 2 (fade)
iamp = ampdb(p4)
idur = p3
ipt1 = p5
itm1 = p6
ipt2 = p7
itm2 = p8
ipt3 = p9
itm3 = p3 - (itm1+itm2)
ipt4 = p10
ifreq = p11
inh   = p12
ifunc = p13
ibw   = p14
ipanrate = 15
ipanfunc = p16
irvt = p17
ilpt = p18
irvbgain = p19
kenv  oscil  iamp, 1/p3, 11
kcf  linseg  ipt1, itm1, ipt2, itm2, ipt3, itm3, ipt4
kpan  oscil  1, 1/p3*ipanrate, ipanfunc
abuzz  buzz  kenv, ifreq, inh, ifunc
acomb  comb  abuzz, irvt, ilpt
ares  reson  acomb, kcf, ibw
aout  delay  ares, .05
	outs aout*sqrt(kpan), aout*(1-sqrt(kpan))
	ga2rvbsig = ga2rvbsig+aout*irvbgain
	endin

instr 3		;convolve w/"underbit"(A, G, B)
iamp  = p4
iatk  = p5
irel  = p6
iamp1 = p7
iamp2 = p8
iamp3 = p9
ibalance = p10
kenv   linseg  0, iatk, iamp, p3-(iatk+irel+.1), iamp, irel/2, .1, irel/2, 0, p3-(iatk+(p3-iatk+irel+.1)+irel), 0
a1     soundin  "undstr.snd"
acom1  comb  a1, 0, .75				;to
acom2  comb  acom1, 0, 1.5			;create
a1 = a1+acom1+acom2					;smearing
acon1   convolve  a1, "but-12.cv"
	adif1   diff acon1*iamp1 
acon2  convolve  a1, "but-2(fd).cv" 
	adif2  diff acon2*iamp2
acon3  convolve  a1, "but+2(fd).cv" 
	adif3  diff acon3*iamp3
adif = adif1+adif2+adif3
abr  butterbr  adif, 550, 100
outs (abr*ibalance)*kenv, (abr*(1-ibalance))*kenv
	endin

instr 4		;convolve "but-12.cv" w/"underbit"(A, G, F#)
iamp = p4
iatk = p5
irel = p6
iamp1 = p7
iamp2 = p8
iamp3 = p9
ibalance = p10
kenv  linseg  0, iatk, iamp, p3-(iatk+irel+.1), iamp, irel, 0, p3-(iatk+(p3-iatk+irel+.1)+irel), 0
a1  soundin  "undstr.snd"
acom1  comb  a1, 0, .75				;to
acom2  comb  acom1, 0, 1.5			;create
a1 = a1+acom1+acom2					;smearing
acon1  convolve  a1, "but-12.cv"
	adif1  diff acon1*iamp1 
acon2  convolve  a1, "but-2(fd).cv" 
	adif2  diff acon2*iamp2
acon3  convolve  a1, "but+9(fd).cv" 
	adif3  diff acon3*iamp3
adif = adif1+adif2+adif3
abr  butterbr  adif, 599, 75
outs (abr*ibalance)*kenv, (abr*(1-ibalance))*kenv
	endin
	
instr 5		;convolve w/"underbit"(A, G, B) w/fade
iamp1 = p4
iamp2 = p5
iamp3 = p6
ibalance = p7
irezgain  = p8
kenv   oscil  .14, 1/p3, 8
a1     soundin  "undstr.snd"
acom1  comb  a1, 0, .75				;to
acom2  comb  acom1, 0, 1.5			;create
a1 = a1+acom1+acom2					;smearing
acon1   convolve  a1, "but-12.cv"
	adif1   diff acon1*iamp1 
acon2  convolve  a1, "but-2(fd).cv" 
	adif2  diff acon2*iamp2
acon3  convolve  a1, "but+2(fd).cv" 
	adif3  diff acon3*iamp3
adif = adif1+adif2+adif3
outs (adif*ibalance)*kenv, (adif*(1-ibalance))*kenv
garezsig  = garezsig+adif*irezgain
	endin
	

instr 6			;"ohohoh"
ibalance = p5
iloop = 1/p4
iamp = p6
i1trim = p7
i2trim = p8
kenv  linen  iamp, .001, p3, 3
a1  soundin  "ohohoh"
a2  comb  a1, 7, iloop
a2 = a2*i1trim
a3  comb  a2, 7, iloop
a3 = a3*i2trim
outs (a2*ibalance)*kenv, (a3*(1-ibalance))*kenv
endin

instr 7			;"ohwhere"
ibalance = p5
iloop = 1/p4
iamp = p6
i1trim = p7
i2trim = p8
kenv  linen  iamp, .001, p3, 3
a1  soundin  "ohwhere"
a2  atone a1, 550
a3  comb  a2, 7, iloop
a3 = a3*i1trim
a4  comb  a3, 7, iloop
a4 = a4*i2trim
outs ((a1+a3)*ibalance)*kenv,((a1+a3)*(1-ibalance))*kenv
endin 

instr 8			;climbing explosion
iamp = ampdb(p4)
iattack = p5
idur = p3
irel = p6
iboop = p3-(p8+p10)
irvbgain = p13
ibalance = p14
kenv  linen  iamp, iattack, idur, irel
krise  linseg  p7, p8, p9, p10, p11, iboop, p12
a2  rand  1
a1  reson  a2, krise, 75
asig = kenv*a1
	outs asig*ibalance, asig*(1-ibalance)
garvbsig = garvbsig+asig*irvbgain
endin

instr 9			;fire
iamp = ampdb(p4)
iboop = p3-(p6+p8)
ibalance = p11
kenv  oscil  iamp, 1/p3, 9
krise  linseg  p5, p6, p7, p8, p9, iboop, p10
a2  rand 	kenv
a1  reson  a2, krise, 75
	outs  a1*ibalance, a1*(1-ibalance)
gasig = gasig+a1
endin

instr 10			;moving bass
ipt1 = p4
itm1 = p5
ipt2 = p6
itm2 = p7
ipt3 = p8
ipt4 = p9
iamp = p10
iatk = p11
ipanfn = p12
iboop = p3-(itm1+itm2+.1)
kpan  oscil  1, 1/p3, ipanfn
kfrq  expseg  ipt1, itm1, ipt2, itm2, ipt3, iboop, ipt4 
kenv  linen   iamp, iatk, p3, 1
a2  oscil  1, kfrq, 1
a1  reson  a2, 80, 250
outs (sqrt(kpan)*a1)*kenv, ((1-sqrt(kpan))*a1)*kenv
endin

instr 11			;stationary bass
ipt1 = p4
itm1 = p5
ipt2 = p6
itm2 = p7
ipt3 = p8
ipt4 = p9
iamp = p10
iatk = p11
iboop = p3-(itm1+itm2+.1)
kfrq  expseg  ipt1, itm1, ipt2, itm2, ipt3, iboop, ipt4 
kenv  linen   iamp, iatk, p3, 1
a2  oscil  1, kfrq, 1
a1  reson  a2, 80, 250
outs a1*kenv, a1*kenv
endin

instr 12			;"sss"
ibalance = p5
iloop = 1/p4
iamp = p6
i1trim = p7
i2trim = p8
kenv  linen iamp, .001, p3, 3
a1  soundin  "sss"
a2  atone a1, 550
a3  comb  a2, 6, iloop
a3 = a3*i1trim
a4  comb  a3, 6, iloop
a4 = a4*i2trim
outs ((a1+a4)*ibalance)*kenv,((a1+a3)*(1-ibalance))*kenv
endin 

instr 13			;"excuse me"
ibalance = p5
iloop = 1/p4
iamp = p6
i1trim = p9
i2trim = p10
kenv  linen iamp, .001, p3, 3
a1  soundin  "excuseme"
a2  atone a1, 550
a3  comb  a2, p7, iloop
a3 = a3*i1trim
a4  comb  a3, p8, iloop
a4 = a4*i2trim
outs ((a1+a3)*ibalance)*kenv,((a1+a4)*(1-ibalance))*kenv
endin 


instr 14			;"while"
ibalance = p5
ilop = 1/p4
iamp = p6
i1trim = p9
i2trim = p10
kenv  linen  iamp, .001, p3, 3
a1  soundin  "while"
a2  atone a1, 550
a3  comb  a2, p7, ilop
a4  comb  a3, p8, ilop
a3 = a3*i1trim
a4 = a4*i2trim
outs ((a1+a3)*ibalance)*kenv,((a1+a4)*(1-ibalance))*kenv
endin 

instr 15			;"I"
ibalance = p5
ilop = 1/p4
iamp = p6
i1trim = p9
i2trim = p10
kenv  linen  iamp, .05, p3, 3
a1  soundin  "I"
a2  atone a1, 550
a3  comb  a2, p7, ilop
a4  comb  a3, p8, ilop
a3 = a3*i1trim
a4 = a4*i2trim
outs ((a1+a4)*ibalance)*kenv,((a1+a3)*(1-ibalance))*kenv
endin 

instr 16			;"dissa"
ibalance = p5
ilop = 1/p4
iamp = p6
i1trim = p9
i2trim = p10
kenv  linen  iamp, .01, p3, 3
a1  soundin  "dissa"
a2  atone a1, 550
a3  comb  a2, p7, ilop
a4  comb  a3, p8, ilop
a3 = a3*i1trim
a4 = a4*i2trim
outs ((a1+a3)*ibalance)*kenv,((a1+a4)*(1-ibalance))*kenv
endin 

instr 17			;"pear"
ibalance = p5
ilop = 1/p4
iamp = p6
i1trim = p9 
kenv  linen  iamp, .08, p3, 3
a1  soundin  "pear"
a2  atone a1, 550
a3  comb  a2, p7, ilop
a4  comb  a3, p8, ilop
a4 = a4*i1trim 
outs ((a1+a4)*ibalance)*kenv,((a1+a4)*(1-ibalance))*kenv
endin 
	
	
instr 99		;global reverb 1 (on i8)
irvbtim = p4
asig  reverb  garvbsig, irvbtim
alp  butterlp  asig, 3000
	outs  alp, -alp
garvbsig = 0
	endin  

instr 100		;global reverb 2 w/100ms pre delay (on i1)
irvbtim = p4
asig  reverb  ga2rvbsig, irvbtim
alp  butterlp  asig, 2000
adel delay     alp, .1
	outs  adel*.5, adel*(1-.5)
ga2rvbsig = 0
	endin  


; mod of:
;***************************************
;** Moorer's circulating-delay reverb **
;***************************************
instr 102		;on i104
   idur = p3
   iamp = p4
   ipan = p5
   iwetmix = p6
   irvbtime = p7

   adry = garsig
   adry = adry*iamp

   awet = adry

   acomb1       comb    awet, irvbtime, .050
   acomb2       comb    awet, irvbtime, .056
   acomb3       comb    awet, irvbtime, .061
   acomb4       comb    awet, irvbtime, .068
   acomb5       comb    awet, irvbtime, .072
   acomb6       comb    awet, irvbtime, .078
   awet = (acomb1+acomb2+acomb3+acomb4+acomb5+acomb6)

   awet         alpass  awet, .12, .006
   alp  butterlp  awet, 2000
   adel  delay  alp, .55
   
   aout = adry + adel*iwetmix   
   aoutl = aout*ipan
   aoutr = aout*(1-ipan)
        outs aoutl, aoutr
        garsig = 0
endin


;*********************************************
;** MIKELSON'S [Global] Tube Amp  (on i9) **
;*********************************************
instr 104
asig     init   0
kamp     linseg 0, .002, 1, p3-.004, 1, .002, 0
igaini   =      p4
igainf   =      p5
iduty    =      p6
islope   =      p7
irvbgain = 		p8
ibalance = 		p9
aold     =      asig
asig     =      igaini*gasig/40000 
aclip    tablei asig,10,1,.5        
aclip    =      igainf*aclip*10000
atemp    delayr  .1
adel1    deltapi (1-iduty*asig)/3000 + (1+islope*(asig-aold))/3000
         delayw  aclip
         outs    (adel1*kamp)*ibalance,adel1*(kamp*(1-ibalance)) 
garsig = garsig+adel1*irvbgain
	gasig = 0
endin


instr 105		;Global resonant filter w/fade
igain = p4
ipt1 = p5
ipt2 = p6
ibalance = p7
kenv  oscil  .1, 1/p3, 8
kcf  expon  ipt1, p3, ipt2
ares  reson  garezsig*igain, kcf, 250
outs (ares*ibalance)*kenv, (ares*(1-ibalance))*kenv
	garezsig = 0 
endin
