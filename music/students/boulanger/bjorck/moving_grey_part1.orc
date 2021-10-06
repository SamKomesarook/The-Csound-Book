;===========================================================
; Moving Grey Part I
; csound project by andreas Sep/Oct 2000
; for Dr. B's Csound Class
;=============================================================================


sr        =         44100
kr        =         44100
ksmps     =         1
nchnls    =         2



garvbsig  init      0


gasig     init      0



gacomb	  init		0


;=================================================
;	INSTRUMENT 1	-	FM instrument
;=================================================
						
			instr 1
ifreq     =         p4
iamp      =         ampdb(p5)
iatt      =         p6*p3
;idec     =         ampdb(p7)
irel      =         p8*p3
isus      =         p3-(iatt+irel) 
 
indxa     =         p9*p3    
indxmax   =         p10
indxr     =         p11*p3    
indxend   =         p12     

imoda     =         p13*p3     
imodl     =         p14
imodr     =         p15*p3
imodend   =         p17
imodst    =         p16
imods     =         p3-(imoda+imodr)

ipan1	  =			p18
ipantime  =			p19
ipan2	  =			p20

irvbsnd	  =			p21
idlysnd	  =			p22

kamp           linseg    0,iatt,iamp, isus, iamp, irel, 0 			    ;amplitude envelope
kndx           linseg    0,indxa,indxmax,indxr,indxend				    ;envelope controlling mod index
kmod           expseg    imodst,imoda,imodl,imods,imodl,imodr,imodend	;envelope controling mod frequency

afm1      foscil    kamp,ifreq,       1,     kmod,       kndx,11
afm2      foscil    kamp,ifreq*1.003, 1.003, kmod*.003,  kndx,11
afm3      foscil    kamp,ifreq*1.002,1.002,kmod*1.002,	 kndx,11		; 7-band chorus FM oscils
afm4      foscil    kamp,ifreq*.997,  .997,  kmod*.997,  kndx,11
afm5      foscil    kamp,ifreq*.998, .998, kmod*.998, 	 kndx,11
afm6      foscil    kamp,ifreq*.999,  .999,  kmod*.999,  kndx,11
afm7      foscil    kamp,ifreq*1.001, 1.001, kmod*1.001, kndx,11


kpan      linseg     ipan1,ipantime,ipan2

krtl=sqrt(2)/2*cos(kpan)+sin(kpan)	    ;constant power panning
krtr=sqrt(2)/2*cos(kpan)-sin(kpan)	    ;from C.Roads "CM Tutorial" pp460

afm            =         (afm1+afm2+afm3+afm4+afm5+afm6+afm7)*.5

al=afm*krtl
ar=afm*krtr
              ; outs       afm*kpan,afm*(1-kpan)
		outs  al,ar

garvbsig  =         garvbsig+(afm*irvbsnd)

gasig     =         gasig+(afm*idlysnd)

;gacomb     =         gacomb+(afm*idlysnd)

endin

;=========================================
;    INSTRUMENT 2 click instrument
;  modified from an instrument by Kim Cascone
;=================================================


          instr 2
                                             
ifrq1 	  = p4								 ;start frq of filter sweep
ifrq2	  = p5								 ;end frq of filter sweep

krnd	  randi		1.02, .242			     ; was 1.42 & .42, generates a random frequency for the filter and adsr
;krnd	  poisson	1.42					 ; poisson noise generator instead of randi
aclk      =         p3*krnd                  ; freq of filter and adsr env 
                                             
apls      oscil     7000,aclk,3              ; generates pulse with inharmonic env from f3
abp       butterbp  apls,5000,1100           ; filters pulse
abp       =         abp*3                    ; boosts output from filter
anoise    oscil     abp,aclk,8               ; gives filtered signal same waveshape as pulse
kswp      expon      ifrq1,p3*.9,ifrq2       ; controls filter sweep

afilt     reson     anoise,kswp,20           ; filter sweep

afilt2    oscil     afilt,1/p3,10            ; amp-modulates output from filter
kpan 	  randi		1, .5
;kpan      linseg    0,p3*.5,1, p3*.3, .5    ; pan
afilt2    =         afilt2*.03               ; scales final filter output      
     
krtl=sqrt(2)/2*cos(kpan)+sin(kpan)	    ;constant power panning
krtr=sqrt(2)/2*cos(kpan)-sin(kpan)	    ;from C.Roads "CM Tutorial" pp460

al=afilt2*krtl
ar=afilt2*krtr

;          outs      afilt2*kpan,afilt2*(1-kpan)
			outs al, ar
garvbsig  =         garvbsig+(afilt2*.15)
     
;gasig      =        gasig+(afilt2*.9)

gacomb      =        gacomb+(afilt2*.9)


          endin

;=================================================================
;   INSTRUMENT 3 - S&H instrument
;		modified Cascone instr.
;=================================================================

          instr 3
krtenv    expseg	p5, p3/2, p6, p3/2, p9				 ;envelope changing the rate of the s&h
krt       =         krtenv                   ; THIS IS THE FRQ OF THE RANDH OUTPUT & CLK OSC
isd       =			p4                       ; p4 HOLDS THE VALUE OF THE SEED OF RANDH UG
krnenv    line      p7, p3, p8				 ;pitch env
krn       randh     krnenv,krt,isd           ; NOISE INPUT TO S&H
kclk      oscil     80,krt,14               ; KCLK CLOCKS THE S&H -- f14 IS A DUTY CYCLE WAVE
ksh       samphold  krn, kclk 				 ;S&H
a2        oscil     300, ksh,11              ; SINE OSC CONTROLLED BY S&H;;;amp=600
a3        oscil     a2,1/p3,10               ; f10=ADSR -- a3 IS THE OUTPUT
;kpan     oscil     1,.04,17				 ; lfo pan
kpan	  linseg	1, p3*.33, 0, p3*.66, -1				 ; envelope pan

kenv	  linen		.3, p3/3, p3, p3/4		 ;amp env controlling output

krtl=sqrt(2)/2*cos(kpan)+sin(kpan)	    	 ;constant power panning
krtr=sqrt(2)/2*cos(kpan)-sin(kpan)	   	 	 ;from C.Roads "CM Tutorial" pp460
	 
a3 		   =	a3*kenv

al=a3*krtl
ar=a3*krtr

         ; outs      asig1,asig2
			outs al, ar

garvbsig  =         garvbsig+(a3*.08)
;gasig      =         gasig+(a3*.5)
gacomb      =         gacomb+(a3*.9)
          endin



;=================================================
; INSTRUMENT 4 --- noise instrument
;	modified kim cascone instr
;=================================================

          instr 4

kfreq     =         p5
                                        
kramp     linseg    0,p3*.7,p4,p3*.3,0       ; THIS CONTROLS THE AMP OF RANDI
kenv1     linen     p4,5, p3,5              ; THIS CONTROLS THE FRQ OF RANDI
anoise    randi     kramp,kenv1
aosc      oscil     anoise,kfreq,11          ; ANOISE IS FED TO THE A INPUT OF AOSC
kpan      oscil     1,.5,1
kcf 	  line		p7, p3, p8
kbw		  line		p8, p3, p7
aosc2     reson     aosc,p5,96,2      ; KPAN+100 IS OFFSET FOR FILTER SWEEP INPUT

;aosc2     reson     aosc,kpan+100,100,2      ; KPAN+100 IS OFFSET FOR FILTER SWEEP INPUT
          
aosc	  =			aosc2*.8             ;*.222          	;scales output

krtl=sqrt(2)/2*cos(kpan)+sin(kpan)	    ;constant power panning
krtr=sqrt(2)/2*cos(kpan)-sin(kpan)	    ;from C.Roads "CM Tutorial" pp460

al=aosc*krtl
ar=aosc*krtr

;          outs      aosc*kpan,aosc*(1-kpan)
			
			outs al, ar	
			
garvbsig  =         garvbsig+(aosc*.033)


          endin





;=================
; GLOBAL REVERB
;=================

          instr 99

a1        reverb2   garvbsig, p4, p5
          outs      a1,a1

garvbsig  =         0

          endin


;================
; GLOBAL DELAY
;================

          instr 98            ; THIS DELAY IS IN PARALLEL CONFIG
                                             
a1        delay     gasig,p4                 ; DELAY=1.25
a2        delay     gasig,p4*2               ; DELAY=2.50
          outs      a1,a2

gasig     =         0

          endin

;=================
; GLOBAL COMBDELAY
;=================

          instr 97

ar1        comb  gacomb, p4, p5
ar2		   comb	 gacomb, p4, p5/4
al1        comb  gacomb, p4, p5*.66
al2		   comb	 gacomb, p4, p5/2

a1        = ar1+(ar2*.5)
a2        = (al1*.2)+(al2*.8)
          outs      a1,a2

gacomb  =         0

		 endin
