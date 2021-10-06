;===========================================================
; Moving Grey Part II
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


;=========================================
;    INSTRUMENT 2 click instrument
;  modified from an instrument by Kim Cascone
;=================================================


          instr 2
                                             
ifrq1 	  = p4								 ;start frq of filter sweep
ifrq2	  = p5								 ;end frq of filter sweep

krnd	  randi		81, .2			   	     ; was 1.42 & .42, generates a random frequency for the filter and adsr
;krnd	  poisson	1.42					 ; poisson noise generator instead of randi
aclk      =         p3*krnd                  ; freq of filter and adsr env 
                                             
apls      oscil     7000,aclk,3              ; generates pulse with inharmonic env from f3
abp       butterbp  apls,5000,1100           ; filters pulse
abp       =         abp*3                    ; boosts output from filter
anoise    oscil     abp,aclk,8               ; gives filtered signal same waveshape as pulse
kswp      expon      ifrq1,p3*.9,ifrq2       ; controls filter sweep

afilt     reson     anoise,kswp,20           ; filter sweep

afilt2    oscil     afilt,1/p3,10            ; amp-modulates output from filter
;kpan 	  randi		1, .5
kpan      linseg    0,p3*.5,1, p3*.3, .5    ; pan
afilt2    =         afilt2*.03               ; scales final filter output      
     
krtl=sqrt(2)/2*cos(kpan)+sin(kpan)	    ;constant power panning
krtr=sqrt(2)/2*cos(kpan)-sin(kpan)	    ;from C.Roads "CM Tutorial" pp460

al=afilt2*krtl
ar=afilt2*krtr

;          outs      afilt2*kpan,afilt2*(1-kpan)
			
			outs al, ar
			
			
garvbsig  =         garvbsig+(afilt2*.2)
     
;gasig      =        gasig+(afilt2*.9)

gacomb      =        gacomb+(afilt2*.9)



          endin


;=================================================
; INSTRUMENT 4 --- noise instrument
;	modified kim cascone instr
;=================================================

          instr 4

kfreq     =         p5
kpanrt    =			p6                                        
kramp     linseg    0, p3*.5, p4, p3*.5, 0       ; THIS CONTROLS THE AMP OF RANDI
kenv1     linen     p4, p3/.1, p3, p3/.1         ; THIS CONTROLS THE FRQ OF RANDI
anoise    randi     kramp,kenv1				     ; noise source
kpan      oscil     1,kpanrt,11				     ; pan-lfo
aosc      oscil     anoise,kfreq+(kpan*5),11         ; ANOISE IS FED TO THE A INPUT OF AOSC       
aosc2     reson     aosc, p5, 96, 2        	     ; filter
;aosc2     reson    aosc,kpan+100,100,2           ; KPAN+100 IS OFFSET FOR FILTER SWEEP INPUT
aosc	  =			aosc2*1                     ;scales output

krtl=sqrt(2)/2*cos(kpan)+sin(kpan)	    	;constant power panning
krtr=sqrt(2)/2*cos(kpan)-sin(kpan)	     	;from C.Roads "CM Tutorial" pp460

al=aosc*krtl
ar=aosc*krtr

			outs al, ar	
			
garvbsig  =         garvbsig+(aosc*.1)


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
          
