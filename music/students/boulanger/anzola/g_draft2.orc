;*******************************************************************************************
;***************************************   " g. "   ****************************************
;***** Piece for Dr. Boulanger's C-Sound Class May 1997, This Draft August 1997 ************
;***** Thanks to Dr. Boulanger and to Hans Mikelson for their help, advice and support *****
;*******************************************************************************************


sr=44100
kr=44100			
ksmps=1			
nchnls=2


	gaux1l init 0	;Initialize global variables for Sweeping EQ.
	gaux1r init 0

	gaux2l init 0	;Initialize global variables for Reverb
	gaux2r init 0


; Variation on Mikelson's Table Based Rezzy Synths w/ distortion
; Blocking filter added by Hans Mikelson

instr 1

        idur   = p3 
        iamp   = ampdb(p4)
        ifqc   = cpspch(p5)
        iatk   = p6
        irel   = (p3 - p6) * .3
        irez   = p8
        itabl1 = p9
        ibal = p10
        ichrs = p11 * .001
        isend2 = p12

       ablock2 init   0							;Initialize blocking filter.
       ablock3 init   0


; Amplitude envelope
        kenv1 linen iamp, iatk, idur, irel
        kenv2 oscil iamp, 1 / idur, 14
        
; Frequency Sweep
        kfco linseg p7, .3*p3, 3*p7, .7*p3, .7*p7

; This relationship attempts to separate Freq from Res.
        ka1 = 100/irez/sqrt(kfco)-1
        ka2 = 1000/kfco

; Initialize Yn-1 & Yn-2 to zero
        aynm1 init 0
        aynm2 init 0

; Oscillators w/ chorus
        axn1 oscil kenv1, ifqc, itabl1
        axn2 oscil kenv1, (ifqc * (1+ichrs)), itabl1
        axn3 oscil kenv1, (ifqc * (1-ichrs)), itabl1
        axn4 pluck kenv2, ifqc  * 2 , ifqc * 4, itabl1, 3
        axn5 pluck kenv2, (ifqc * (1+ichrs)) * 2 , (ifqc * (1+ichrs)) * 4, itabl1, 3
        axn6 pluck kenv2, (ifqc * (1-ichrs)) * 2 , (ifqc * (1-ichrs)) * 4, itabl1, 3

        axnbk = (axn1 + axn2 + axn3) * .1 + (axn4 + axn5 + axn6) * .1 ; (.33 * .3)

        ablock2 =      axnbk-ablock3+.99*ablock2  ;This is a DC blocking filter
        ablock3 =      axnbk                      ;used to prevent drift away from
        axn     =      ablock2                    ;zero.


; Replace the differential eq. with a difference eq.
        
        ayn = ((ka1+2*ka2)*aynm1-ka2*aynm2+axn)/(1+ka1+ka2)

        atemp tone axn, kfco
        aclip1 = (ayn-atemp)/100000
        aclip tablei aclip1, 7, 1, .5
        aout = aclip * 20000 + atemp

        aynm2 = aynm1
        aynm1 = ayn

; Amp envelope and output, also amount to aux sends                             
        
        aout balance aout, axn
                
        aoutl = aout * ( 1 - ibal)
        aoutr = aout * ibal
                
        gaux2l = gaux2l + (aoutl * isend2)
        gaux2r = gaux2r + (aoutr * isend2)
                
        outs aoutl, aoutr

endin


;Pad

instr 2 

	iamp = ampdb(p4)
	inote = cpspch(p5)
	iwav = p8
	idur = p3
	ibal = p9
	ichrs = p10 * .001
	isend1 = p11 * 10
	isend2 = p12
	
	k1	linen iamp,p6 * .6,idur,p7 		
	k2	linen iamp,p6,idur,p7				; Slower Envelope for the chorused oscil's
	a3	oscil	k2,(inote*(1-ichrs)),iwav
	a2	oscil	k2,(inote*(1+ichrs)),iwav
	a1	oscil	k1,inote,iwav
		
	asig = a1 + a2 + a3
	asig = asig * .3 					
	
	asigl= asig * (1 - ibal)
	asigr= asig * ibal
	
	gaux1l = gaux1l + (asigl * isend1) 
	gaux1r = gaux1r + (asigr * isend1)
	
	gaux2l = gaux2l + (asigl * isend2) 
	gaux2r = gaux2r + (asigr * isend2)  
	
	outs asigl,asigr
		
endin


;Percussion , variation on Jean-Claude Risset's Drums
;Blocking Filter by Hans Mikelson

instr 7

	i1 = p5 * .5
	i2 = cpspch(p4 * .1)
	i3 = 1 / p3
	i4 = p5 * .8
	i5 = cpspch(p4)
	ibal = p6
	isend1 = p7 * 10
	isend2 = p8	
	
	ablck2 init   0						;Initialize blocking filter.
	ablck3 init   0
	
	kenv oscil i1, i3, 14
	
	a2 oscil i1,i3,10
	a2 oscil a2,i2,11

	a3 oscil i4,i3,12
	a3 oscil a3,i5,1
   
	a4 pluck kenv,i5*.5,i5*3,0,3
   
	asnbk = (a2 + a3 + a4)
	ablck2 = asnbk-ablck3+.99*ablck2	;This is a DC blocking filter
    ablck3 = asnbk                      ;used to prevent drift away from
    asig	= ablck2                    ;zero.
		
	asigl = (asig) * (1 - ibal)
	asigr = (asig) * ibal
   
   	gaux1l = gaux1l + ( asigl * isend1)
   	gaux1r = gaux1r + ( asigr * isend1)
   	
   	gaux2l = gaux2l + ( asigl * isend2)
   	gaux2r = gaux2r + ( asigr * isend2)

	outs   asigl,asigr

endin


;Bass

instr 9

	idur = p3
	iamp = ampdb(p4)
	iptch1 = cpspch(p5)
	ipbend = cpspch(p5 + p6)
	isend1 = p7 * 10 
	isend2 = p8
	
	
	kptch line iptch1, idur, ipbend								;Determines Pitch & Bend
	
	kenv oscil iamp, 1 / p3, 13									;ADSR envelope
	a1 oscil kenv, kptch, 3
		
	kpan oscil 1, 1 / p3, 1										;Generates Panning
	
	aoutl = a1 * (1 - kpan)
	aoutr = a1 * kpan
	
	gaux1l = aoutl * isend1
	gaux1r = aoutr * isend1
	
	gaux2l = aoutl * isend2
	gaux2r = aoutr * isend2

	outs aoutl, aoutr 
	
endin  


;CubeWater , variation on Kim Cascone's Water

instr 12

	igain = p4
	isd = p5									;p4 holds the value of the seed of randh UG
	ifreq = p6 									;must be values < or close to 1, controls pitch
	krt = p7									;this is the frq of the randh output & clk osc
	isend2 = p8									;aux send to reverb

	krnd randh 10000,krt,isd					;noise input to S&H
	kclk oscil 100,krt, 5						;kclk clocks the S&H -- f14 is a duty cycle wave
	ksh	samphold krnd, kclk						;S&H

	a2 oscil 2, 100,1							;sine osc (f1) controlled by S&H

	ksh = ksh * ifreq		;* .5

	a4	reson	a2,ksh,50						;filter with s&h controling the Fc
	a3	oscil	a4,1/p3,13						;a3 is the output f13 ADSR

	a3 = a3 * igain

	kpan	oscil	1,.14, 4

	aoutl	=	a3 * (1-kpan)
	aoutr	=	a3 * kpan 

	gaux2l = aoutl * isend2
	gaux2r = aoutr * isend2
	
	outs	aoutl,aoutr

endin


;Sweeping EQ Stereo In/Out

instr 99

	idur = p3
	igain = p4 * .5
	ifreq1 = p5
	ifreq2 = p6
	iwidth = p7
	isend2 = p8
		 
	kamp linen igain,idur * .05, idur, idur * .1	; one envelope for both filters
	
	ksweep line ifreq1, idur,ifreq2
	
	asigl = gaux1l
	asigr = gaux1r
	 
	afiltl butterbp asigl,ksweep,iwidth
	aphsrl = afiltl * kamp
	
	afiltr butterbp asigr,ksweep,iwidth	
	aphsrr = afiltr * kamp
	
	;display aphsrl, idur ; shows filter amp
	;display aphsrr, idur
	
	gaux2l = gaux2l + (aphsrl * isend2) 
	gaux2r = gaux2r + (aphsrr * isend2) 
	
	outs aphsrl, aphsrr
	
	gaux1l = 0
	gaux1r = 0

endin


;Reverb & Delay

instr 100
  	
  	igain = p4
  	irvt = p5
  	ifrq = p6
  	ifeedb = p7
  	ilenght = p8
  	
  	ablock2l init 0								; Initialize Blocking Filter
  	ablock3l init 0
  	
  	ablock2r init 0
  	ablock3r init 0
  	
  	asigl = gaux2l
  	asigr = gaux2r	
	
	a1l alpass asigl, ifeedb, ilenght * 1.5		; Different time settings for left and right
	a2l reverb2 asigl, irvt, ifrq
	abkl = (a1l * .7 + a2l * .5 ) * igain
	
	a1r alpass asigr, ifeedb, ilenght 
	a2r reverb2 asigr, irvt * 1.2, ifrq
	abkr = (a1r * .7 + a2r * .5 ) * igain
	
	ablock2l = abkl - ablock3l+ .99 * ablock2l	; Blocking Filter by Hans Mikelson
	ablock3l = abkl								; Avoids DC offset		
	asigl = ablock2l
	
	ablock2r = abkr - ablock3r+ .99 * ablock2r 
	ablock3r = abkr
	asigr = ablock2r
	
	outs asigl, asigr
	
	gaux2l = 0
	gaux2r = 0
	
endin
