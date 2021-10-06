;Magdalena Klapper, "adeson TN" - orchestra file

sr=48000
kr=2400
ksmps=20
nchnls=2

garev init 0                    ;global signal for reverb 
gafiltr init 0                  ;global signal for filtering
;garev2 init 0 - global signal for reverb, instr 61, 11 i 97 


;------------------------------;
	;INSTR 1 - reads sound file using 'soundin' opcode and localize 
		;the sound in one piont in space.
instr 1

inrp=p4	                        ;p4-the soundin file number
ibal=p5	                        ;p5-panorama (from left)
iamp=p6	                        ;p6-level of globel loudness (value between 0 and 1) 
irev=p7	                        ;p7-add global reverb or not, binary value:1 means yes, 0 no
ifiltr=p8                       ;p8-add global filter or not, binary value:1 means yes, 0 no
iba1=ibal*iamp
iba2=(1-ibal)*iamp
aout	soundin	inrp
   if (ifiltr==0) goto cont1
  	gafiltr=aout
  	goto cont2
cont1:	
	outs	aout*iba1, aout*iba2
cont2:
   if (irev==0)	goto cont
  	garev=aout
cont:
endin

;--------------------;
	;INSTR 2 - reads sound file from the table usin 'loscil' opcode.
		;Sound localization in space may change in time.
		;Amplitude is constant.
instr 2

inrf=p4	                        ;p4-the sound file function number
iampl=p5                        ;p5-constant amplitude (value between 0 and 1)
ibal=p6	                        ;p6-panorama (from left)
iamp=p7	                        ;p7-max frequency in relation to value 200
iff=p8                          ;p8-pitch change function
irev=p9                         ;p9-add global reverb or not, binary value:1 means yes, 0 no
ifiltr=p10                      ;p10-add global filter or not, binary value:1 means yes, 0 no
kfreq	oscil	iamp,1/p3,iff
   if (ibal<=1) goto contin     ;localization of sound changing in time or not
kbal	oscil 1,1/p3,ibal         ;Yes, ibal-move in space function number	
 	goto contin2
contin:
 	kbal=ibal                 ;No, ibal-one point in space
contin2:
aout	loscil  iampl, kfreq, inrf, 200
   if (irev==0) goto cont1
	 garev=aout
cont1:
   if (ifiltr==0) goto cont2
	gafiltr=aout
	goto	cont3
cont2:
	outs	kbal*aout,(1-kbal)*aout
cont3:
endin

;--------------------;
	;INSTR 3 - reads sound file from the table using 'loscil' opcode
		;and adds tremolo to the sound. 
		;Tremolo frequency may change in time
instr 3	    ;this instrument had been design for 'adeson TN', but finaly it was not used.

inrp=p4                         ;p4-the sound file function number
ibal=p5                         ;p5-panorama
iw1=p6                          ;p6-min value of amplitude (from 0 to 1)
iw2=p8                          ;p8-mid tremolo amplitude (from 0 to 1)
it1=p7                          ;p7-time needed to reach min value
ifreq1=p9                       ;p9-first tremolo frequency (at the begining)
ifreq2=p10                      ;p10-second tremolo frequency (at the end)
ifn=p11                         ;p11-tremolo function number
ifreq=p12                       ;p12-max frequency in relation to 200
iamp=p13                        ;p13-level of global loudnes (from 0 to 1) 
iff=p14                         ;p14-frequency change function
irev=p15                        ;p15-add global reverb or not (1-yes, 0-no)
ifiltr=p16                      ;p16-add global filter of not (1-yes, 0-no)
klin	linseg	1,it1,iw1,p3-it1-.1,1.3,.1,0
kam	linseg  0,it1*.6,iw2,it1*.4,iw2,p3-it1,.6
kfreq	expon 	ifreq1,p3,ifreq2	
ks	oscil 	kam,kfreq,ifn   ;tremolo
	kmin=klin-kam
kfreq	oscil	ifreq,1/p3,iff
	kampl=(kmin+ks)*iamp
aout	loscil	kampl,ifreq,inrp,200
   if (ifiltr==0) goto cont1
 	gafiltr=aout
 	goto cont2
cont1:
	outs 	aout*ibal, aout*(1-ibal)
cont2:
   if (irev==0) goto cont
 	garev=aout
cont:
endin

;--------------------;
	;INSTR 4 - reads sound file from the table using 'table' opcode.
		;Table index may be specified by any function. 
instr 4

idl=p4                          ;p4-sound file length ( in sek.)
iroz1=p5                        ;p5-index specification function length
inr1=p6                         ;p6-index specification function number
iroz2=p7                        ;p7-sound file function length
inr2=p8                         ;p8-sound file function number
ifamp=p9                        ;p9-amplitude function (from 1 to 0)
iamp=p10                        ;p10-value of max amplitude (about 1)
ibal=p11                        ;p11-panorama
irev=p12                        ;p12-add global reverb or not (1-yes, 0-no)
ifiltr=p13                      ;p13-add global filter or not (1-yes, 0-no)
aind1	phasor	1/idl
aind2	tablei	aind1*iroz1,inr1  ;reading index
aout	table 	aind2*iroz2,inr2  ;reading sound
   if (ifamp<=1) goto contin1
kamp	oscil	iamp,1/idl,ifamp  ;amplitude
	goto contin2
contin1:
	kamp=ifamp
contin2:
   if (ifiltr==0) goto cont1
  	gafiltr=aout
  	goto cont2
cont1:
	kba1=ibal*kamp
	kba2=(1-ibal)*kamp
	outs	aout*kba1, aout*kba2
cont2:
   if (irev==0) goto cont
  	garev=aout
cont:
endin

;--------------------;
	;INSTR 5 - reads sound file from the table using 'loscil' opcode.
		;Extended modyfication of amplitude is possible.
instr 5

ifamp=p4                        ;p4-amplitude function (shape of one cicile-may be repeated with frequency changing in time) 
inf=p5                          ;p5-sound file function number
ibal=p6                         ;p6-panorama
iampl=p7                        ;p7-amplitude (from 1 to 0)
ifster=p8                       ;p8-amplitude modyfication function number
iffamp=p9                       ;p9-max amplitude of frequency changing
iamp=p10                        ;p10-max frequency in relation to 200
iff=p11                         ;p11-frequence change function
istor=p12                       ;p12-pitch coefficient
irev=p13                        ;p13-add global reverb or not (1-yes, 0-no)
ifiltr=p14                      ;p14-add global filter or not (1-yes, 0-no)
kfre	oscil	iffamp,1/p3,ifster
kfamp	oscil	1,kfre,ifamp
kfreq	oscil	iamp,1/p3,iff
	kampl=kfamp*iamp          ;amplitude modyfication
	kfrequ=kfreq+istor        ;frequency change
aout 	loscil	kampl,kfrequ,inf,200
   if (ifiltr==0) goto cont1
 	gafiltr=aout
 	goto cont2
cont1:
	outs	aout*ibal,aout*(1-ibal)
cont2:
   if (irev==0) goto cont
 	garev=aout
cont:
endin

;--------------------;
	;INSTR 6, INSTR 61 - reads sound file from the table using 'loscil' opcode.
		;Amplitude contains two segments, every one of them 
		;may be linear or exponential, there are possible also mixed
		;combinations (lin-exp, exp-lin segments of amplitude).
instr 6

itime1=p4                       ;p4-first segment time
iwart1=p5                       ;p5-if equal 1-first segment exponential, 
                                   ;if equal .01-first segment linear 
iwart2=p6                       ;p6-if equal 1-second segment exponential,
                                   ;if equal .01-second segment linear	
inf=p7                          ;p7-sound file function number
iamp=p8                         ;p8-max frequency in relation to 200
iff=p9                          ;p9-frequency change function
iampl=p10                       ;p10-global amplitude
ibal=p11                        ;p11-panorama
irev=p12                        ;p12-add global reverb or not (1-yes, 0-no)
ifiltr=p13                      ;p13-add global filter or not (1-yes, 0-no)
iwart3=1-iwart1
iwart4=1-iwart2
itime2=p3-itime1-.1
iba1=ibal*iampl
iba2=(1-ibal)*iampl
kexpo	expseg	0.01,itime1,iwart1,.1,iwart2,itime2,0.01
klin	linseg	0,itime1,iwart3,.1,iwart4,itime2,0
kfreq	oscil	iamp,1/p3,iff
	kampl=kexpo+klin          ;linear and exponential segment put together
aout	loscil	kampl,kfreq,inf,200
   if (ifiltr==0) goto cont1
 	gafiltr=aout
 	goto cont2
cont1:
	outs	aout*iba1,aout*iba2
cont2:
   if (irev==0) goto cont
  	garev=aout
cont:
endin

;--------------------;
	;INSTR 7 - produce set of harmonics with individual amplitude 
		;envelopment. Harmonics are added in loop. 
		;Amplitude envelopment for every harmonic (sine wave) is
		;preparing for it by filtering the 'echocardiogram sound' 
		;with band sutible for this harmonic pitch. Pulse but not
		;periodic characteristic of 'echo' is first smoothed with 
		;usage of one of three methods:rms, downsampling, integration.
instr 7	    ;this instrument had been design for 'adeson TN', but finaly it was not used.

inrf=p4                         ;p4-sound file function number
ilog=p6                         ;p6-number of smoothing algorythm (0,1,2)
ilsk=p7                         ;p7-number of harmonics adding in loop (about 2)
iamp=p8                         ;p8-max amplitude
ifa=p9                          ;p9-amplitude function
ifb=p10                         ;p10-panorama function
iff=p11                         ;p11-single harmonic shape function
irev=p12                        ;p12-add global reverb of not (1-yes, 0-no)
ifiltr=p13                      ;p13-add global filter or not (1-yes, 0-no)
a1	soundin	inrf
	kfreq=p5                  ;p5-first harmonic
	kndex=0
	aout=0
powrot:                           ;loop beginning
	asklad=0
aamp 	reson 	a1/5,kfreq,kfreq,2 ;filter band
   if (ilog==0 || ilog==3) goto algor1
   if (ilog==1) goto algor2
   if (ilog==2) goto algor3
algor1:
kampp	rms	aamp
	goto contin
algor2:
kampp	downsamp aamp,20	
	goto contin
algor3:
kampp1	downsamp aamp,20
kampp	integ	 kampp1
contin:
asklad	oscil	kampp,kfreq,iff	
   if (ilog!=3) goto contin2
	askladout=asklad
	goto	contin3
contin2:
askladout reson	asklad,kfreq,kfreq/100,1; additional smoothing
contin3:
	aout=aout + askladout		
	kndex=kndex + 1
	kfreq=kfreq + p4
   if ( kndex < ilsk) goto powrot  ;loop end
kbal	oscil	1,1/p3,ifb
kamp	oscil	iamp,1/p3,ifa
   if (ifiltr==0) goto cont1
 	gafiltr=aout
 	goto cont2
cont1:
	kba1=kbal*kamp
	kba2=(1-kbal)*kamp
	outs	kba1*aout,kba2*aout
cont2:
   if (irev==0) goto cont
 	garev=aout
cont:
endin

;--------------------;
	;INSTR 8 - similar to 7, but harmonic are not added in loop.
		;Harmonic pitch may change. All harmonics move parallel.
		;Even harmonics move in direction oposite of odd harmonics.
instr 8

inrp=p4                         ;p4-sound file function number
kfreq=p5                        ;p5-first harminic
ilog=p6                         ;p6-number of smoothing algorythm
interw=p7                       ;p7-depth of pich move (1 - 4/3)
iff=p8                          ;p8-single harmonic shape function
ibal=p9                         ;p9-panorama
iampl=p10                       ;p10-max global amplitude (from 0 to 1) 
ifa=p11                         ;p11-amplitude function
irev=p12                        ;p12-add global reverb or not (1-yes, 0-no)
ifiltr=p13                      ;p13-add global filter or not (1-yes, 0-no)
a1	soundin	inrp
;harmonics
aamp1 	reson 	a1/5,kfreq,kfreq,2 ;filter band 
aamp2 	reson 	a1/5,2*kfreq,kfreq,2	
aamp3 	reson 	a1/5,3*kfreq,kfreq,2	
aamp4 	reson 	a1/5,4*kfreq,kfreq,2	
aamp5 	reson 	a1/5,5*kfreq,kfreq,2	
aamp6 	reson 	a1/5,6*kfreq,kfreq,2	
aamp7 	reson 	a1/5,7*kfreq,kfreq,2	
aamp8 	reson 	a1/5,8*kfreq,kfreq,2	
aamp9 	reson 	a1/5,9*kfreq,kfreq,2	
aamp10 	reson 	a1/5,10*kfreq,kfreq,2	
aamp11 	reson 	a1/5,11*kfreq,kfreq,2	
   if (ilog==0) goto algor1
   if (ilog==1) goto algor2
   if (ilog==2) goto algor3
algor1:
kampp1	rms	aamp1
kampp2	rms	aamp2
kampp3	rms	aamp3
kampp4	rms	aamp4
kampp5	rms	aamp5
kampp6	rms	aamp6
kampp7	rms	aamp7
kampp8	rms	aamp8
kampp9	rms	aamp9
kampp10	rms	aamp10
kampp11	rms	aamp11
	goto contin
algor2:
kampp1	downsamp aamp1,20         ;amplitude smoothing
kampp2	downsamp aamp2,20	
kampp3	downsamp aamp3,20	
kampp4	downsamp aamp4,20	
kampp5	downsamp aamp5,20	
kampp6	downsamp aamp6,20	
kampp7	downsamp aamp7,20	
kampp8	downsamp aamp8,20	
kampp9	downsamp aamp9,20	
kampp10	downsamp aamp10,20	
kampp11	downsamp aamp11,20	
	goto contin
algor3:
kampp1.1 downsamp aamp1,20
kampp1	 integ	 kampp1.1
kampp1.2 downsamp aamp2,20
kampp2	 integ	 kampp1.2
kampp1.3 downsamp aamp3,20
kampp3	 integ	 kampp1.3
kampp1.4 downsamp aamp4,20
kampp4	 integ	 kampp1.4
kampp1.5 downsamp aamp5,20
kampp5	 integ	 kampp1.5
kampp1.6 downsamp aamp6,20
kampp6	 integ	 kampp1.6
kampp1.7 downsamp aamp7,20
kampp7	 integ	 kampp1.7
kampp1.8 downsamp aamp8,20
kampp8	 integ	 kampp1.8
kampp1.9 downsamp aamp9,20
kampp9	 integ	 kampp1.9
kampp1.10 downsamp aamp10,20
kampp10	  integ	 kampp1.10
kampp1.11 downsamp aamp11,20
kampp11	  integ	 kampp1.11
contin:
kfreq1	expseg	1,p3/4,interw,p3/4,1,p3/4,1/interw,p3/4,1
kfreq2	expseg	1,p3/4,1/interw,p3/4,1,p3/4,interw,p3/4,1

asklad1	oscil	kampp1,kfreq*kfreq1,iff	
aout1	reson	asklad1,kfreq*kfreq1,kfreq/100,1 ;smoothing
asklad2	oscil	kampp2,2*kfreq*kfreq2,iff	
aout2	reson	asklad2,2*kfreq*kfreq2,kfreq/100,1
asklad3	oscil	kampp3,3*kfreq*kfreq2,iff	
aout3	reson	asklad3,3*kfreq*kfreq2,kfreq/100,1
asklad4	oscil	kampp4,4*kfreq*kfreq1,iff	
aout4	reson   asklad4,4*kfreq*kfreq1,kfreq/100,1
asklad5	oscil	kampp5,5*kfreq*kfreq1,iff	
aout5	reson	asklad5,5*kfreq*kfreq1,kfreq/100,1
asklad6	oscil	kampp6,6*kfreq*kfreq2,iff	
aout6	reson	asklad6,6*kfreq*kfreq2,kfreq/100,1
asklad7	oscil	kampp7,7*kfreq*kfreq2,iff	
aout7	reson	asklad7,7*kfreq*kfreq2,kfreq/100,1
asklad8	oscil	kampp8,8*kfreq*kfreq1,iff	
aout8	reson	asklad8,8*kfreq*kfreq1,kfreq/100,1
asklad9	oscil	kampp9,9*kfreq*kfreq1,iff	
aout9	reson	asklad9,9*kfreq*kfreq1,kfreq/100,1
asklad10 oscil	kampp10,10*kfreq*kfreq2,iff	
aout10	reson	asklad10,10*kfreq*kfreq2,kfreq/100,1
asklad11 oscil	kampp11,11*kfreq*kfreq2,iff	
aout11	reson	asklad11,11*kfreq*kfreq2,kfreq/100,1
  	aout=aout1+aout2+aout3+aout4+aout5+aout6+aout7+aout8+aout9+aout10+aout11
kampl	oscil	iampl,1/p3,ifa
   if (ifiltr==0) goto cont1
  	gafiltr=aout
  	goto cont2
cont1:
	kba1=kampl*ibal
	kba2=kampl*(1-ibal)
  	outs	aout*kba1,aout*kba2
cont2:
   if (irev==0) goto cont
 	garev=aout
cont:
endin

;--------------------;
	;INSTR 9 - reads sound file and filters to pitchs from it.
instr 9

inrp=p4                         ;p4-sound file function number
iamp=p5                         ;p5-global amplitude
iamax=p6                        ;p6-max frequency
iff=p7                          ;p7-frequency change function
ifreqf=p8                       ;p8-mid frequency of filter
iwart=p9                        ;p9-filter band width at the end
iobd=p10                        ;p10-echo frequency
interw=p11                      ;p11-pitchs gap
itime=p12                       ;p12-time of filtration
irtime=p13                      ;p13-reverb time function
irf=p14                         ;p14-max reverb
ifiltr=p15                      ;p15-add global filter or not (1-yes, 0-no)
iamp=p16                        ;p16-reverb amplitude
iampp=p17                       ;p17-facton of output signala amplitude
ifi=ifreqf*interw
iap=iamp*.5
iapp=iampp*.5
kfreq	oscil	iamax,1/p3,iff
ain	loscil	iamp,kfreq,inrp,200
acomb	comb	ain,.5*p3,iobd
kpasm	expseg	15000,p3-itime,iwart,itime,iwart
afiltr1	reson	.5*acomb,ifreqf,kpasm
afiltr2	reson	.5*acomb,ifi,kpasm
	afiltr=afiltr1+afiltr2
   if (irtime==0) goto contin1
krtime	oscil	irf,1/p3,irtime
aout	reverb	afiltr,krtime
	goto contin2
contin1:
	iamp*aout=afiltr
contin2:
   if (ifiltr==0) goto cont1
 	gafiltr=aout*iap+afiltr*iapp
	goto cont2
cont1:
	asign=aout*iap+afiltr*iapp
	outs	asign,asign
cont2:
endin

;--------------------;
	;INSTR 10 - using 'adsyn' opcode.
instr 10

itime=p4                        ;p4-max amplitude
iftime=p5                       ;p5-amplitude function
ifmod=p6                        ;p6-max frequency
iffmod=p7                       ;p7-frequency function
ispeed=p8                       ;p8-max time
ifspeed=p9                      ;p9-time function
ibal=p10                        ;p10-panorama
irev=p14                        ;p14-add global reverb or not (1-yes, 0-no)
ifiltr=p15                      ;p15-add global filter or not (1-yes, 0-no)
ktime	oscil	itime,1/p3,iftime
kfmod	oscil	ifmod,1/p12,iffmod
kspeed	oscil	ispeed,1/p3,ifspeed
aout 	adsyn	ktime,p13+kfmod,kspeed, p11
   if (ifiltr==0) goto cont1
 	gafiltr=aout
 	goto cont2
cont1:
	outs	aout*ibal,aout*(1-ibal)
cont2:
   if (irev==0) goto cont
 	garev=aout
cont:
endin

;--------------------;
	;INSTR 99 - global effect of reverb
instr 99

ifn=p4                          ;p4-reverb function
ipogl=p5                        ;p5-max reverb
ifs=p6                          ;p6-panorama function
istor=p7                        ;p7-reverb amplitude (about 1)
ibal=p8                         ;p8-sound localization in space
igl=p9                          ;p9-global signal amplitude
	ain=garev
krev	oscil	ipogl,1/p3,ifn
aout	reverb	ain,krev
   if ( ifs<1) goto contin1
kspace	oscil	1,1/p3,ifs
	goto contin2
contin1:
	kspace=ifs
contin2:
	iglo=igl*.5
	outs	iglo*ibal*garev+istor*aout*kspace,iglo*(1-ibal)*garev+istor*aout*(1-kspace)
endin

;--------------------;
	;INSTR 98 - global effect of filtering. All basic types off filter are possible.
instr 98		

ialg=p4                         ;p4-filter type
ain=gafiltr
iaf=p5                          ;p5-cutoff frequency function
iampf=p6                        ;p6-max amplitude of cutoff frequency function
if=p7                           ;p7-cutoff frequency
ibw=p8                          ;p8-filter band width
ibf=p9                          ;p9-band change function
ibal=p10                        ;p10-panorama
iamp=p11                        ;p11-global amplitude
iba1=iamp*ibal
iba2=iamp*(1-ibal)
kfreq	oscil	iampf,1/p3,iaf
kbw	oscil	ibw,1/p3,ibf
   if (ialg==1) goto algorytm1
   if (ialg==2) goto algorytm2
   if (ialg==3) goto algorytm3
   if (ialg==4) goto algorytm4
algorytm1:                        ;low-pass filter
aout	tone	ain, if+kfreq
	goto contin
algorytm2:                        ;high-pass filter
aout1	tone	ain, if+kfreq
	aout=ain-aout1
	goto contin
algorytm3:                        ;band-pass filter
aout	reson	ain, if+kfreq, kbw
	goto contin
algorytm4:                        ;band-rejection filter
aout1	reson	ain, if+kfreq, kbw
	aout=ain-aout1
	goto contin
contin:
	outs	iba1*aout,iba2*aout
endin
;--------------------;
	;This instrument was design to mix all the piece.
instr 12

inr = p4                        ;p4-sound file function number
il = p5                         ;p5-change chanels or not
iamp = p6                       ;p6-max amplitude
inrf = p7                       ;p7-amplitude function
kamp	oscil	iamp, 1/p3, inrf
al, ap	soundin inr
   if ( il > .5 ) goto cont1
	outs	kamp*al,kamp*ap
	goto cont2
cont1:
	outs   kamp*ap,kamp*al
cont2:
endin
;------------------------------------;
