;**************************
;*                114 Hours                *
;*                                                *
;*                    2000                    *
;*              Glenn Ianaro             *
;**************************

;****  All SOUNDS COMES FROM PARTY.D WAV AN 
;****  AND WAS PROCESSED IN CSOUND USING PVOC
;****  PRIOR TO THIS ORC/SCO

sr        =         44100
kr        =         44100
ksmps     =         1
nchnls    =         2

	  zakinit 30,30
gacmb     init      0
garvb     init      0
gadly     init      0


;**********
;<inir zak>
;**********
          instr     1            ; INITIALIZE ZAK CHANNEL 30 TO 1
asig      =         1
          zaw asig, 30
          endin


;*****************
;<PVREAD CONTROL>
;*****************
                 instr    2
                 strset   31, "violin.pvc"
iend             =        p4
ifile            =        p5
ibin             =        p6
ichout           =        p7

ktime            line     0, p3, iend
kfreq1, kamp1    pvread   ktime, ifile, ibin
afreq1           =        kfreq1
                 zawm     afreq1, ichout
                 endin

;********************************
;*	  phase vocoder		*
;********************************

          instr     11
ifreqscale  =       p5			                   ; PITCH TRANSPOSITION
ispecwp   =         0				           ; PRESERVES SPECTRAL ENVELOPE WHEN NONZERO
ibeg      =         0    
iend      =         p4             	          	   ; p4 = DURATION OF INPUT_SOUND
irvbsnd   =         p6
ioutch	  =	    p7    	                 	   ; OUTPUT CHANNEL
ifile     =         p8
	
;kpan      oscil     .5, ipanfrq, 1     	           ; PANNING OSCILLATOR
;kpanlfo   =         kpan+.5           		           ; BIAS FOR PANNING OSCILLATOR
ktime     line      ibeg, p3, iend             		   ; VALUES GO FROM END TO BEGINNING
apv       pvoc      ktime, ifreqscale, ifile, ispecwp
	  zawm      apv , ioutch                           ; WRITE TO OUTPUT ZAK CHANNEL
;    	  dispfft   azoom, p3, 1024

          endin
          



;********************************
;*    vpvoc phase vocoder       *
;********************************

          instr     12
ifreqscale  =       p5			                   ; PITCH TRANSPOSITION
ispecwp   =         0				           ; PRESERVES SPECTRAL ENVELOPE WHEN NONZERO
ibeg      =         0    
iend      =         p4             	          	   ; p4 = DURATION OF INPUT_SOUND
irvbsnd   =         p6
ioutch	  =	    p7    	                 	   ; OUTPUT CHANNEL
;ifile     =         p8                                     ; INPUT FILE NAME
	
ktime     linseg   ibeg, p3*.5, iend, p3*.5, ibeg	   ; VALUES GO FROM END TO BEGINNING
          tableseg  6, p3*.333, 9, p3*.333,10, p3*.333, 7
apv       vpvoc      ktime, ifreqscale, "party1024.pvc" , ispecwp
	  zawm      apv , ioutch                           ; WRITE TO OUTPUT ZAK CHANNEL
;    	  dispfft   azoom, p3, 1024
          endin

;*********
;NEW FM
;*********
			instr 	91
inotedur	=		p3
imaxamp		=		ampdb(p4)
icarrfreq	=		p5
imodfreq	=		p6
ilowndx		=		p7
indxdiff	=		p8-p7
ifmod           =               p27
ifcar           =               p28
ichout          =               p29

; PARAMETERS DEFINING THE ADSR AMPLITUDE ENVELOPE
; TIMES ARE A PERCENTAGE OF p3
;   attack amp  = p9     attack length  = p14
;   decay amp   = p10    decay length   = p15
;   sustain amp = p11    sustain length = p16
;   release amp = p12    release length = p17
;   end amp     = p13

; PARAMETERS DEFINING THE ADSR FREQ DEVIATION ENVELOPE
; TIMES ARE A PERCENTAGE OF p3
;   attack amp  = p18    attack length  = p23
;   decay amp   = p19    decay length   = p24
;   sustain amp = p20    sustain length = p25
;   release amp = p21    release length = p26
;   end amp     = p22

aampenv		linseg	p9, p14*p3, p10, p15*p3, p11, p16*p3, p12, p17*p3, p13
adevenv		linseg	p18, p23*p3, p19, p24*p3, p20, p25*p3, p21, p26*p3, p22
amodosc		loscil	(ilowndx+indxdiff*adevenv)*imodfreq, imodfreq, ifmod, 2000, 1, 1, 24408
acarosc		loscil	imaxamp*aampenv, icarrfreq+amodosc, ifcar, 400, 1, 1, 24408
                zawm    acarosc, ichout
			endin


;************
;<LOSCIL FM>
;************
			instr 	90
inotedur	=		p3
imaxamp		=		ampdb(p4)
icarrfreq	=		p5
imodfreq	=		p6
ilowndx		=		p7
indxdiff	=		p8-p7
itabmod         =               p27
itabcar         =               p28
ioutch          =               p29
;ichin           =               p30
;amodsig         zar             ichin

; PARAMETERS DEFINING THE ADSR AMPLITUDE ENVELOPE
; TIMES ARE A PERCENTAGE OF p3
;   attack amp  = p9     attack length  = p14
;   decay amp   = p10    decay length   = p15
;   sustain amp = p11    sustain length = p16
;   release amp = p12    release length = p17
;   end amp     = p13

; PARAMETERS DEFINING THE ADSR FREQ DEVIATION ENVELOPE
; TIMES ARE A PERCENTAGE OF p3
;   attack amp  = p18    attack length  = p23
;   decay amp   = p19    decay length   = p24
;   sustain amp = p20    sustain length = p25
;   release amp = p21    release length = p26
;   end amp     = p22

aampenv		linseg	p9, p14*p3, p10, p15*p3, p11, p16*p3, p12, p17*p3, p13
adevenv		linseg	p18, p23*p3, p19, p24*p3, p20, p25*p3, p21, p26*p3, p22
amodosc		loscil	(ilowndx+indxdiff*adevenv)*imodfreq, imodfreq, itabmod, 1
acarosc		loscil	imaxamp*aampenv, icarrfreq+amodosc, itabcar, 1
                zawm    acarosc, ioutch
                endin

;****************
;<SAMPLE READER>
;****************

         instr      15

ichin    =          p7
amodsig  zar        ichin
iamp     =          p4 
ipitch   =          p5
ifile    =          p6
ioutch   =          p8
asig     loscil     iamp, ipitch, ifile, 1,

         zawm       asig, ioutch
         endin


;********
;diskin
;********

         instr    6
ipitch   =        p4
ichout   =        p5
ifile    =        p6
ilev     =        p7
asig     diskin   ifile, ipitch

kenv	line    .01, p3, 1
afilt   lowresx   asig, 500*kenv, 1
         zawm     ilev*afilt, ichout
         endin
;********************************
;*	  Global Reverb		*
;********************************

          instr      94
idur      =          p3
irvbtim   =          p4
ihiatn    =          p5
ichin	  =	     p6
ichout    =          p7
icutoff   =          p8
garvb     zar        ichin
arvb      nreverb    garvb, irvbtim, ihiatn               ; SHORTENS REVERB TIME  
kenv      linen      1, 0, p3, .6*p3
afilt     tone       arvb, 2000*kenv                      ; LOPASS FILTER FOLLOWING DECAY
          zawm        afilt*kenv, ichout                  ; ZAWM LETS YOU ASSING SAME CHNL AS ORIGINAL SIGNAL
;	  dispfft arvb, 1, 1024
          endin

;********************************
;*	 Cook's X-Flanger (mod)	*
;********************************
         
         instr      95 ; Dual Flanger with normal and cross feedback

ilevl    = p4       ; Output level
idelay   = p5/1000  ; Delay in ms
idepth   = p6/2000  ; LFO depth in ms
irate1   = p7       ; L LFO rate
irate2   = p8       ; R LFO rate
iphase   = p9/360   ; R LFO phase
iwave    = p10      ; LFO waveform
ifdbk1   = p11      ; L feedback
ifdbk2   = p12      ; R feedback
ixfdbk   = p13      ; X feedback
idry     = p14*.707 ; Dry output level
ichin    = p15
ioutchl   = p16
ioutchr   = p17
imax     = idepth + idelay + .1
adel1    init 0
adel2    init 0

ain      zar   ichin

asig1    = ain + ixfdbk*adel2
asig2    = ain + ixfdbk*adel1
alfo1    oscili  idepth, irate1, iwave
alfo1    = alfo1 + idepth
alfo2    oscili  idepth, irate2, iwave, iphase
alfo2    = alfo2 + idepth
alfo3    oscili  .001, .2, 1
alfo4    oscili  .001, .2, 1, .25

aflange1 flanger  asig1, alfo1 + idelay, ifdbk1*alfo3, imax
aflange2 flanger  asig2, alfo2 + idelay, ifdbk2*alfo4, imax
outs1    (aflange1 + ain*idry)*ilevl
outs2    (aflange2 + ain*idry)*ilevl
         zawm     (aflange1 + ain*idry)*ilevl, ioutchl
         zawm     (aflange2 + ain*idry)*ilevl, ioutchr

        endin


;********
;<DELAY>
;********

         instr   93
idel     =       p4
iskip    =       p5
icut     =       p6
ilayer   =       p7
idel2    =       p8
iskip2   =       p9
icut2    =       p10
ilayer2  =       p11
idel3    =       p12
iskip3   =       p13
icut3    =       p14
ilayer3  =       p15
idel4    =       p16
iskip4   =       p17
icut4    =       p18
ilayer4  =       p19
ichin    =       p20
ichout   =       p21
asig     zar     ichin
afilt    tonex   asig, icut, ilayer
adel     delay   afilt, idel, iskip
afilt2   tonex   asig, icut2, ilayer2
adel2    delay   afilt2, idel2, iskip2
afilt3   tonex   asig, icut3, ilayer3
adel3    delay   afilt, idel3, iskip3
afilt4  tonex   asig, icut4, ilayer4
adel4   delay   afilt2, idel4, iskip4
         zawm    p22*adel+p23*adel2+p24*adel3+p25*adel4, ichout 
         endin

;**********
;<ENVELOPE>
;**********
        instr   14                 ;AMPLITUDE ENVELOPE

iatkamp =       p4                 ;               
idecamp =       p5                 ;             .;<--idecamp
isusamp =       p6                 ;           .;  .;
irelamp =       p7                 ;         ,;     .;.;.;.;.;.;<--irelamp
iendamp =       p8                 ;       .;        |          .;
iatktim =       p9                 ;     .;          |            .; 
idectim =       p10                ;   .;           isusamp         .; 
isustim =       p11                ; .;<--iatkamp                     .;<--iendamp
ireltim =       p12                ;
ichin   =       p13                ;(((TIMES ARE % OF P3)))
ichout  =       p14
asig    zar     ichin
aampenv	linseg	p4, p9*p3, p5, p10*p3, p6, p11*p3, p7, p12*p3, p8
        zawm    aampenv*asig, ichout
;        dispfft aampenv, 1, 1024
        endin

;************
;<OCSILLATOR>
;************
        instr   3
iamp    =       p4
ifreq   =       p5
itab    =       p6
iphase  =       p7
ichout  =       20 ;p8
asig    oscil   iamp, ifreq, itab, iphase 
        zawm    asig, ichout
        endin

;******************
;<RESFILTER W/ADSR>
;******************
        instr   16

iatkamp =       p4                 ;               
idecamp =       p5                 ;             .;<--idecamp
isusamp =       p6                 ;           .;  .;
irelamp =       p7                 ;         ,;     .;.;.;.;.;.;<--irelamp
iendamp =       p8                 ;       .;        |          .;
iatktim =       p9                 ;     .;          |            .; 
idectim =       p10                ;   .;           isusamp         .; 
isustim =       p11                ; .;<--iatkamp                     .;<--iendamp
ireltim =       p12                ;
ichin   =       p13                ;(((TIMES ARE % OF P3)))
ichout  =       p14
icut    =       p15                ; IN HZ
ires    =       p16                ; 1-100
asig1   zar     ichin
kenv	linseg	p4, p9*p3, p5, p10*p3, p6, p11*p3, p7, p12*p3, p8
afilt   rezzy   asig1, icut*kenv, ires
        zawm    afilt, ichout
        endin


;***********
;<MODULATOR>
;***********
        instr   98
ichin1  =       p4
ichin2  =       p5
ichout  =       p6
amod    =       ichin1*ichin2
        zawm    amod, ichout

        endin 
;---------------------------------------------------------------------------
; MIXER SECTION
;---------------------------------------------------------------------------
        instr   99    
asig1   zar     p4                  ; p4 = ch1 IN
igl1    init    p5*p6               ; p5 = ch1 GAIN
igr1    init    p5*(1-p6)           ; p6 = ch1 PAN
asig2   zar     p7                  ; p7 = ch2 IN
igl2    init    p8*p9               ; p8 = ch2 GAIN
igr2    init    p8*(1-p9)           ; p9 = ch2 PAN
asig3   zar     p10                 ; p10 = ch3 IN
igl3    init    p11*p12             ; p11 = ch3 GAIN
igr3    init    p11*(1-p12)         ; p12 = ch3 PAN
asig4   zar     p13                 ; p13 = ch4 IN
igl4    init    p14*p15             ; p14 = ch4 GAIN
igr4    init    p14*(1-p15)         ; p15 = ch4 PAN
asigl   =       asig1*igl1+asig2*igl2+asig3*igl3+asig4*igl4 
asigr   =       asig1*igr1+asig2*igr2+asig3*igr3+asig4*igr4 
        outs    asigl, asigr    
        zacl    0, 30   
        endin

