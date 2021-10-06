;Text File Funk
;By Matt Moldover  AKA  Dead Ace
;(617)236-0321   deadace@deadace.com     http://www.deadace.com
;INTERESTING THINGS: a lot of the instruments use a little randomness on amplitude or cutoff
;frequency to add realism.  Several of the beats use instrument 103 which randomly chooses to
;play a kick drum, snare drum or nothing.  I use the index counter ($dex) on many parameter fields
;to create dynamic effects lasting 8 bars even though the repeated sections are usually only 2 bars.  

sr	=	44100
kr	=	4410
ksmps	=	10
nchnls	=	1

garvb	init	0
gacmb	init	0


;Gverb
	instr 900
idur		=	p3
irvbtim	=	p4
ihiatn	=	p5
arvb	nreverb	garvb, irvbtim, ihiatn
	out arvb
garvb	=	0
	endin


;Gdelay
		instr	901
idur		=		p3
itime 	= 		p4
iloop 	= 		p5
kenv	linen	1, .01, idur, .01
acomb 	comb	gacmb, itime, iloop, 0
		out		acomb*kenv
gacmb	=		0
	endin


;HiHat with variable amp hit-length, freq / rand added to amp and freq
	instr 100
idur = p3
iamp = p4
icutoff = p5
ilength = p6
icutrnd  trirand (icutoff/2.4)
iamprnd  unirand (iamp*.30)
kcutenv linseg 0, ilength*.1, icutoff, ilength*.5, 0
kampenv expseg .001, ilength*.05, 1, ilength*.5, .002
anoise  rand iamp+iamprnd
afilt butterlp anoise, kcutenv+icutrnd
asig = (afilt*kampenv)*.8
	out asig
garvb	=	garvb+(asig*.11) 
;gacmb	=	gacmb+(asig*.4) 
endin


; Kick drum with variable amp and freq / rand added to amp and freq
	instr 101
idur = p3
iamp = p4
ifreq = p5
iamprnd unirand (iamp*.2)
ifreqrnd1 unirand (ifreq*.2)
ifreqrnd2 unirand (ifreq*.3)
ifreqrnd3 unirand (ifreq*.4)
asin1 oscil iamp, (ifreq)+ifreqrnd1, 1
asin2 oscil iamp, (ifreq*1.1)+ifreqrnd2, 1
asin3 oscil iamp, (ifreq*.9)+ifreqrnd3, 1
asinsum = (asin1+asin2+asin3)/2
anoise rand 10000
anoisefilt butterlp anoise, ifreq*1.2
aampenv expseg .001, .03, 1, .4, .001
asig = (anoisefilt*aampenv*(iamp/600))+(asinsum*aampenv)
	out asig
 garvb	=	garvb+(asig*.03) 
 ;gacmb	=	gacmb+(asig*.4) 
	endin


; Snare drum with variable amp and freq / rand added to amp and bandW
	instr 102
idur = p3
iamp = p4
ifreq = p5
irndbnd1 unirand ifreq*.5
irndbnd2 unirand ifreq*.3
kfiltenv linseg (ifreq*1.5)+irndbnd1, .7, ifreq+irndbnd2
irndamp unirand iamp*.3
anoise rand (iamp+irndamp)/11
afilt  reson anoise, ifreq+irndbnd1*.7, kfiltenv+(ifreq*.5)
afilt2 butlp anoise, (ifreq*3)-(irndbnd2*.5)
afilt3 buthp afilt2, ifreq
aampenv expseg .001, .01, 1, .07, .4, .3, .001
asig = ((afilt+afilt3)*aampenv)
	out asig
garvb	=	garvb+(asig*.12) 
 ;gacmb	=	gacmb+(asig*.4) 
	endin


;random silence/kick/snare
	instr 103
;iblah unirand 1234
;seed iblah
idur = p3
iamp = p4
ifreq = p5
iseedread = p6
clockon 1
iclocker readclock 1 
iseedme = abs(iclocker)*iseedread
seed iseedme
ipicker unirand 3
iintpicker = int(ipicker)
if (iintpicker==0) goto  silence
if (iintpicker==1) goto  kick
if (iintpicker==2) goto  snare
silence:	
		asoscil oscil 0, 20, 1
		asig = asoscil
goto		contin

kick:				
		ifreq = 60
		iamprnd unirand (iamp*.2)
		ifreqrnd1 unirand (ifreq*.2)
		ifreqrnd2 unirand (ifreq*.3)
		ifreqrnd3 unirand (ifreq*.4)
		asin1 oscil iamp, (ifreq)+ifreqrnd1, 1
		asin2 oscil iamp, (ifreq*1.1)+ifreqrnd2, 1
		asin3 oscil iamp, (ifreq*.9)+ifreqrnd3, 1
		asinsum = (asin1+asin2+asin3)/2
		anoise rand 10000
		anoisefilt butterlp anoise, ifreq*1.2
		aampenv expseg .001, .03, 1, .2, .001
		asig = (anoisefilt*aampenv*(iamp/400))+(asinsum*aampenv)
		
 		garvb	=	garvb+(asig*.02) 
 		;gacmb	=	gacmb+(asig*.4) 

goto		contin

snare:	
		ifreq = 900 
		irndbnd1 unirand ifreq*.5
		irndbnd2 unirand ifreq*.3
		kfiltenv linseg (ifreq*1.5)+irndbnd1, .7, ifreq+irndbnd2
		irndamp unirand iamp*.3
		anoise rand (iamp+irndamp)/11
		afilt  reson anoise, ifreq+irndbnd1*.7, kfiltenv+(ifreq*.5)
		afilt2 butlp anoise, (ifreq*3)-(irndbnd2*.5)
		afilt3 buthp afilt2, ifreq
		aampenv expseg .001, .02, 1, .07, .4, .2, .001
		asig = ((afilt+afilt3)*aampenv)	
		garvb	=	garvb+(asig*.1) 
 		;gacmb	=	gacmb+(asig*.4) 
goto		contin
contin:		
		out asig
endin



;Sqareish tone with variable pitch slide, filter CO slide, and pseudo-Q
	instr 200
idur = p3
iamp = p4
ifreq1 = cpspch(p5)
ifreq2 = cpspch(p6)
icutoff1 = p7
icutoff2 = p8
iresmix = p9
kcutoff linseg icutoff1, idur, icutoff2
kfreq linseg ifreq1, idur, ifreq2
asqr1 oscil iamp, kfreq, 2
asqr2 oscil iamp, kfreq*1.01, 2
asqr3 oscil iamp, kfreq*.99, 2
asqr4 oscil iamp, kfreq*1.02, 2
asqr5 oscil iamp, kfreq*.98, 2
asqr6 oscil iamp, kfreq, 2
asqr7 oscil iamp, kfreq*1.05, 2
asqr8 oscil iamp, kfreq*.95, 2
asin1 oscil iamp, kfreq+1, 1
asin2 oscil iamp, kfreq, 1
asin3 oscil iamp, kfreq-1, 1
atone1 = ((asqr6+asqr7+asqr8)/3)+((asin1+asin2+asin3)/6)*.66
atone2 = (asqr1+asqr2+asqr3+asqr4+asqr5)/5
aampenv  linseg 0, idur*.03, 1, idur*.07, .9, idur*.85, .7, idur*.05, 0 
amix = ((atone1+atone2)/2)*aampenv
afilt1 butlp amix, kcutoff
afilt3 butlp afilt1, kcutoff
afilt2 butbp amix, kcutoff, kcutoff/(7)
adcfix dcblock (afilt3+((afilt2*12)*iresmix))
asig = adcfix
	out asig
	endin


;pluck with FM
	instr 201
idur = p3
iamp = p4
ifreq = cpspch(p5)
ifmdep = p6
ifmratio = p7
ifmfreq = ifmratio*ifreq
afmsin oscil ifmdep, ifmfreq, 1
astring pluck iamp, afmsin+ifreq, ifreq, 0, 1
kampenv linseg .001, idur*.05, 1, idur*.95, .001
ifiltrnd unirand .5 
kfiltenv linseg 1, idur, .2+ifiltrnd
afilt butlp astring, 18000*kfiltenv
;adcfix dcblock (afilt*kampenv)
;asig = adcfix
asig = (afilt*kampenv)
	out asig
garvb	=	garvb+(asig*.11) 
;gacmb	=	gacmb+(asig*.4) 	
	endin


;dynamic FM instrument
            instr 69
kindexenv  		expseg 1, p3/3, p9, p3/3, p9/2, p3/3, 1
kampenv    		linen  p4, p3/12, p3, p3/3 
kexpramp   		expon  1, p3, p8      
ksinerate  		expon  p10, p3, 1 
ksinemod   		oscil  p4, (1/p3)*ksinerate, 1 
koctavespike      expseg 1, p3/3, 1.1, p3/6, 10, p3/6, 1 
afmout  foscil  (kampenv*ksinemod)/5000, p5/koctavespike, p7, kexpramp, kindexenv, p6		
;adcfix dcblock afmout
;asig = adcfix
asig = afmout
		out asig
garvb	=	garvb+(asig*.15) 
;gacmb	=	gacmb+(asig*.4) 
		endin    


;overcomplicated granular with LPF
    instr 420
idur = p3
iamp = ampdb(p6)
ifrq = cpspch(p8)
iatk = p4
irel = p5
ifun = p14
iden1 = p10
iden2 = p11
iampoff = ampdb(p7)
ifrqoff = cpspch(p9)
igdur = p12
igduroff = p13
iranddepth = p15
ilfodepth = p16
ilfoitts = p17
ilfodurmod = p18
ilfofiltmod = p19
imix = p20       ;0=dry
iampatt = p21
kampenv expseg .001, iatk, 1, idur-iatk-irel, .9, irel, .001
kgfrqdev oscil ifrqoff*ifrqoff, 1/idur, 3
kdenexp expseg iden1, idur/8, iden2/2, idur/4, iden2/1.5, idur/16, iden1*2, idur/8, iden2, idur/16, iden2/3, idur/8, iden1*1.4, idur/4, iden1 
krandlin linseg 0, idur, iranddepth
klfo oscil ilfodepth, ilfoitts/idur, 1
kfiltenv linseg 0, iatk/2, 1, idur/1.33, .7, idur/3, 0
asig1 grain 3000, ifrq*krandlin, kdenexp, iampoff, ifrqoff*kgfrqdev, igdur+(klfo*ilfodurmod), ifun, 3, igduroff
alpf  butterlp  asig1/2, (kfiltenv*15000+(klfo*kfiltenv)/10) 
asig = ((((asig1)+(alpf*imix))*kampenv)/2)*iampatt
		out asig
	garvb	=	garvb+(asig*.13) 
	;gacmb	=	gacmb+(asig*.4) 		
		endin


;Starts a clock based on the CPUs clock
	instr 300
clockon 1
	endin
