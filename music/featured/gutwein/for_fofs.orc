;*********************** Gutwein FOF.ORC  ******************************
					  
sr = 44100
kr = 441
ksmps = 100
nchnls = 2
gaRvbL 	init 	0	 ; GLOBAL...make zero at orch init time
gaRvbR 	init 	0
gkRvbFeedBak init 0
giAmpMult init 1.3
;**************************************************************************
; INSTR 1:        ELABORATE VOCAL INSTRUMENT: 76 P-FIELDS!
;		MALE & FEMALE VOICED, UNVOICED, MIXED, & CHORUSED DIPTHONGS
;
;You may use converted MIDI files since the orchestra ignores P4.
;Just cut/paste p6-p77 beneath each note-event in the score
;**************************************************************************
;	       			  8-POINT DIPTHONG-STREAM P FIELDS
;			  	  ____Expressive ctrl. over ea. vowel_____
;P1   P2   P3	P4     p5  	p6 -13 (Vowel table nums, f11-f35)
;     ontm idur ignore iamp	p14-21 (pitch in oct. pchclass... 8.01)
;				p22-29 (8pt. vowel amplitude env. = % iamp )	
;				p30-37 (vibrato intensity in integers 1-10)
;				p38-45 (pan: 0-1.-  Use 2 decimal floats)
;				p46-53 (Microtone shift:  microtones 0-.9999)	
;				p54-61 (Rvbgain: varies by type..delay & mix combined)	
;  				P62-69 (Voiced/Unvoiced Mix, .5=equal, 0=voiced, 1=unvoiced)
;				p70-76 (linseg durs. for above, USE ADDITIVE VALUES)
;				p77 = Reverb feedback
;				p78 = iFX = Chorus typesc
;
instr 1	
	idur = p3
	iamp = (p5*550)
	iNamp = iamp*.000003 ; noise amplitude mult. for whispers
	
	ipch1 = cpspch(p14) 
	ipch2 = cpspch(p15)
	ipch3 = cpspch(p16)
	ipch4 = cpspch(p17)
	ipch5 = cpspch(p18)
	ipch6 = cpspch(p19)
	ipch7 = cpspch(p20)
	ipch8 = cpspch(p21)

	
	 		
	;Convert Additive Notation of linseg durations to % of idur
	isubdiv = idur/(p70+p71+p72+p73+p74+p75+p76)
	idur1 = isubdiv*p70
	idur2 = isubdiv*p71 
	idur3 = isubdiv*p72
	idur4 = isubdiv*p73 
	idur5 = isubdiv*p74	
	idur6 = isubdiv*p75
	idur7 = isubdiv*p76

	iFX = 0
	iFX = p78
	gkRvbFeedBak = p77
	
	;Copy formant-table contents into variables (5 formants and 4 amplitudes)
			     ;index   tablenum	
	ifmnt0a table 	   0,    p6	
	ifmnt0b table 	   0,    p7	;frequencies
	ifmnt0c table	   0,    p8
	ifmnt0d table	   0,    p9
	ifmnt0e table 	   0,    p10
	ifmnt0f table 	   0,    p11
	ifmnt0g table	   0,    p12
	ifmnt0h table	   0,    p13
	ifmnt1a table 	   1,    p6	
	ifmnt1b table 	   1,    p7	
	ifmnt1c table	   1,    p8
	ifmnt1d table	   1,    p9
	ifmnt1e table 	   1,    p10
	ifmnt1f table 	   1,    p11
	ifmnt1g table	   1,    p12
	ifmnt1h table	   1,    p13
	ifmnt2a table 	   2,    p6	
	ifmnt2b table 	   2,    p7	
	ifmnt2c table	   2,    p8
	ifmnt2d table	   2,    p9
	ifmnt2e table 	   2,    p10
	ifmnt2f table 	   2,    p11
	ifmnt2g table	   2,    p12
	ifmnt2h table	   2,    p13	
	ifmnt3a table 	   3,    p6	
	ifmnt3b table 	   3,    p7	
	ifmnt3c table	   3,    p8
	ifmnt3d table	   3,    p9
	ifmnt3e table 	   3,    p10
	ifmnt3f table 	   3,    p11
	ifmnt3g table	   3,    p12
	ifmnt3h table	   3,    p13
	ifmnt4a table 	   4,    p6	
	ifmnt4b table 	   4,    p7	
	ifmnt4c table	   4,    p8
	ifmnt4d table	   4,    p9
	ifmnt4e table 	   4,    p10
	ifmnt4f table 	   4,    p11
	ifmnt4g table	   4,    p12
	ifmnt4h table	   4,    p13

	ifamp1a table 	   5,    p6	;amplitudes
	ifamp1b table 	   5,    p7
	ifamp1c table 	   5,    p8
	ifamp1d table 	   5,    p9
	ifamp1e table 	   5,    p10
	ifamp1f table 	   5,    p11
	ifamp1g table 	   5,    p12
	ifamp1h table 	   5,    p13
	ifamp2a table 	   6,    p6	
	ifamp2b table 	   6,    p7
	ifamp2c table 	   6,    p8
	ifamp2d table 	   6,    p9
	ifamp2e table 	   6,    p10
	ifamp2f table 	   6,    p11
	ifamp2g table 	   6,    p12
	ifamp2h table 	   6,    p13
	ifamp3a table 	   7,    p6	
	ifamp3b table 	   7,    p7
	ifamp3c table 	   7,    p8
	ifamp3d table 	   7,    p9
	ifamp3e table 	   7,    p10
	ifamp3f table 	   7,    p11
	ifamp3g table 	   7,    p12
	ifamp3h table 	   7,    p13
	ifamp4a table 	   8,    p6	
	ifamp4b table 	   8,    p7
	ifamp4c table 	   8,    p8
	ifamp4d table 	   8,    p9
	ifamp4e table 	   8,    p10
	ifamp4f table 	   8,    p11
	ifamp4g table 	   8,    p12
	ifamp4h table 	   8,    p13
	
	;8-POINT LINSEG ENVELOPES FOR TRANSFORMATION BETWEEN COMBINATIONS OF 8 VOWELS
	;Amplitude Env. (percents of iamp)
	aamp    linseg iamp*p22, idur1, iamp*p23, idur2, iamp*p24, idur3, iamp*p25, idur4, iamp*p26, idur5, iamp*p27, idur6, iamp*p28, idur7, iamp*p29
	aNamp	linseg iNamp*p22, idur1, iNamp*p23, idur2, iNamp*p24, idur3, iNamp*p25, idur4, iNamp*p26, idur5, iNamp*p27, idur6, iNamp*p28, idur7, iNamp*p29

	;formant frequencies for noise filter
	kfmnt0  linseg ifmnt0a, idur1, ifmnt0b, idur2, ifmnt0c, idur3, ifmnt0d, idur4, ifmnt0e, idur5, ifmnt0f, idur6, ifmnt0g, idur7, ifmnt0h
	kfmnt1	linseg ifmnt1a, idur1, ifmnt1b, idur2, ifmnt1c, idur3, ifmnt1d, idur4, ifmnt1e, idur5, ifmnt1f, idur6, ifmnt1g, idur7, ifmnt1h
	kfmnt2	linseg ifmnt2a, idur1, ifmnt2b, idur2, ifmnt2c, idur3, ifmnt2d, idur4, ifmnt2e, idur5, ifmnt2f, idur6, ifmnt2g, idur7, ifmnt2h
	kfmnt3	linseg ifmnt3a, idur1, ifmnt3b, idur2, ifmnt3c, idur3, ifmnt3d, idur4, ifmnt3e, idur5, ifmnt3f, idur6, ifmnt3g, idur7, ifmnt3h
	kfmnt4	linseg ifmnt4a, idur1, ifmnt4b, idur2, ifmnt4c, idur3, ifmnt4d, idur4, ifmnt4e, idur5, ifmnt4f, idur6, ifmnt4g, idur7, ifmnt4h
	;formant frequencies for vowels
	afmnt0  linseg ifmnt0a, idur1, ifmnt0b, idur2, ifmnt0c, idur3, ifmnt0d, idur4, ifmnt0e, idur5, ifmnt0f, idur6, ifmnt0g, idur7, ifmnt0h
	afmnt1	linseg ifmnt1a, idur1, ifmnt1b, idur2, ifmnt1c, idur3, ifmnt1d, idur4, ifmnt1e, idur5, ifmnt1f, idur6, ifmnt1g, idur7, ifmnt1h
	afmnt2	linseg ifmnt2a, idur1, ifmnt2b, idur2, ifmnt2c, idur3, ifmnt2d, idur4, ifmnt2e, idur5, ifmnt2f, idur6, ifmnt2g, idur7, ifmnt2h
	afmnt3	linseg ifmnt3a, idur1, ifmnt3b, idur2, ifmnt3c, idur3, ifmnt3d, idur4, ifmnt3e, idur5, ifmnt3f, idur6, ifmnt3g, idur7, ifmnt3h
	afmnt4	linseg ifmnt4a, idur1, ifmnt4b, idur2, ifmnt4c, idur3, ifmnt4d, idur4, ifmnt4e, idur5, ifmnt4f, idur6, ifmnt4g, idur7, ifmnt4h
	;formant amplitudes (percents vowel amplitudes)
	afamp1  linseg ifamp1a, idur1, ifamp1b, idur2, ifamp1c, idur3, ifamp1d, idur4, ifamp1e, idur5, ifamp1f, idur6, ifamp1g, idur7, ifamp1h
	afamp2  linseg ifamp2a, idur1, ifamp2b, idur2, ifamp2c, idur3, ifamp2d, idur4, ifamp2e, idur5, ifamp2f, idur6, ifamp2g, idur7, ifamp2h
	afamp3	linseg ifamp3a, idur1, ifamp3b, idur2, ifamp3c, idur3, ifamp3d, idur4, ifamp3e, idur5, ifamp3f, idur6, ifamp3g, idur7, ifamp3h
	afamp4	linseg ifamp4a, idur1, ifamp4b, idur2, ifamp4c, idur3, ifamp4d, idur4, ifamp4e, idur5, ifamp4f, idur6, ifamp4g, idur7, ifamp4h
	
	;Vibrato w/depth = p22-29
	kvibwth linseg   p30, idur1, p31, idur2, p32, idur3, p33, idur4, p34, idur5, p35, idur6, p36, idur7, p37
	ivibave = (p14+p15+p16+p17+p18+p19+p20+p21)/8
	if ivibave >= 8 igoto femalevib
	if ivibave < 8 igoto malevib
	femalevib:	
		ivibhz = ivibave-5
		goto continue
	malevib:	
		ivibhz = ivibave-2
	continue:
	avib oscil    kvibwth+1.5,  ivibhz+(kvibwth*.3),  1  ; (ampl., hz, GEN)
	kvib oscil    kvibwth+1.5,  ivibhz+(kvibwth*.3),  1  
	
	;pitch-change between vowels of dipthong
	apch    linseg ipch1, idur1, ipch2, idur2, ipch3, idur3, ipch4, idur4, ipch5, idur5, ipch6, idur6, ipch7, idur7, ipch8
	
	;microtonal shift option
	; If FX-type (p45-52) < 1 then add/subtract microtones from apch
	; A semitone above apch = apch + (apch * (.08333333333)).
	; Multply .0833333 by  value stored in FX-type
	kMtone  linseg p46, idur1, p47, idur2, p48, idur3, p49, idur4, p50, idur5, p51, idur6, p52, idur7, p53
	if (kMtone < 1) goto Microtone
	Microtone:
		apch = apch+(apch*(kMtone*.08333333333))
		
	;FILTERED NOISE = UNVOICED FORMANTS: center-frequencies=formants
	aNoise		rand	10000; seed=10000
	aN0		areson	aNoise, kfmnt0+kvib, 40 
	aN1		areson	aNoise, kfmnt1+kvib, 40
	aN2		areson	aNoise, kfmnt2+kvib, 40
	aN3		areson	aNoise, kfmnt3+kvib, 40
	aN4		areson	aNoise, kfmnt4+kvib, 40
	aNoise0 = aN0*aNamp*.05
	aNoise1 = aN1*(aNamp*afamp1); ea. band of noise has rel. formant amplitude
	aNoise2 = aN2*(aNamp*afamp2)
	aNoise3 = aN3*(aNamp*afamp3)
	aNoise4 = aN4*(aNamp*afamp4)
	
	;GET AMP VALUES FOR UNVOICES SOUNDS (kUnVcMix)
	kUnVcMix linseg p62, idur1, p63, idur2, p64, idur3, p65, idur4, p66, idur5, p67, idur6, p68, idur7, p69
	aUnvoiced = (aNoise0+aNoise1+aNoise2+aNoise3+aNoise4)*(kUnVcMix)
	
	;FOF OPCODES: VOICED FORMANTS FOR SOLO VOICE or 1st IN CHORUS
	;		  (any rate: const.	|                   |(must be given fixed val.|
	;         (ctrl., or audio )|(only &ctrl. rates)|   at initialization)
	;ar  fof  xamp  	   xfund  xform koct kband kris  kdur kdec  iolaps ifna ifnb 		;totdur [iphs] [ifmode]
	aA0  fof   aamp,  	apch+avib,afmnt0,0,  40,  .001, .08, .002,  120,    1,   2,   p3
	aA1  fof   aamp*afamp1, apch+avib,afmnt1,0,  40,  .001, .08, .002,  120,    1,   2,   p3
	aA2  fof   aamp*afamp2, apch+avib,afmnt2,0,  40,  .001, .08, .002,  120,    1,   2,   p3
	aA3  fof   aamp*afamp3, apch+avib,afmnt3,0,  40,  .001, .08, .002,  120,    1,   2,    p3
	aA4  fof   aamp*afamp4, apch+avib,afmnt4,0,  40,  .001, .08, .002,  120,    1,   2,    p3
	
;USE AVE. OF P14-P21 TO DETERMINE IF YOU NEED OCT. DBLING.
	
	if iFX != 0 goto PchChorus  ;PITCH & VIB. CHANGES IF CHORUSED
	aVoicedL = (aA0+aA1+aA2+aA3+aA4)*(1-kUnVcMix)
	aVoicedR = aVoicedL	
	goto Pan_Switch

	PchChorus:
		ipchave = (p14+p15+p16+p17+p18+p19+p20+p21)/8
		if iFX >= 1 goto Compute_fofB
		if iFX == 3 goto Compute_fofCD

			Compute_fofB:
				if ipchave >= 9 goto B_1
				if ipchave >= 7 goto B_2
				if ipchave >= 1 goto B_3
				B_1:
					ipct = .002
					goto B_cont
				B_2:
					ipct = .008
					goto B_cont
				B_3:
					ipct = .025 	
								
				B_cont:
			; subtle shift of pitch & rate of pitch-change between vowels of dipthong
				aBpch  linseg ipch1+(ipch1*ipct), idur1+(idur1*.1), ipch2+(ipch2*ipct), idur2-(idur2*.1), ipch3+(ipch3*ipct), idur3+(idur3*.1), ipch4+(ipch4*ipct), idur4-(idur4*.1), ipch5+(ipch5*ipct), idur5+(idur5*.1), ipch6+(ipch6*ipct), idur6-(idur6*.1), ipch7+(ipch7*ipct), idur7, ipch8+(ipch8*ipct)
				aBvib  oscil   kvibwth+2,  ivibhz-1,  1 
				aB0  fof   aamp,  	    aBpch+aBvib,afmnt0,0,  70,  .011, .08, .052,  120,    1,   2,   p3
				aB1  fof   aamp*afamp1, aBpch+aBvib,afmnt1,0,  70,  .011, .08, .052,  120,    1,   2,   p3
				aB2  fof   aamp*afamp2, aBpch+aBvib,afmnt2,0,  70,  .011, .08, .052,  120,    1,   2,   p3
				aB3  fof   aamp*afamp3, aBpch+aBvib,afmnt3,0,  70,  .011, .08, .052,  120,    1,   2,    p3
				aB4  fof   aamp*afamp4, aBpch+aBvib,afmnt4,0,  70,  .011, .08, .052,  120,    1,   2,    p3
				
				if iFX >=2 goto Compute_fofCD
				goto Compute_Chorus_Stereo
 
			Compute_fofCD:

				if ipchave >= 9 goto CD_1
				if ipchave >= 7 goto CD_2
				if ipchave >= 1 goto CD_3
				CD_1:
					ipct = .004
					goto CD_cont
				CD_2:
					ipct = .007
					goto CD_cont
				CD_3:
					ipct = .024 
								
				CD_cont:
				aCpch  linseg ipch1, idur1+(idur1*.1), ipch2, idur2-(idur2*.1), ipch3, idur3+(idur3*.1), ipch4, idur4-(idur4*.1), ipch5, idur5+(idur5*.1), ipch6, idur6-(idur6*.1), ipch7, idur7, ipch8
				aCvib  oscil   kvibwth-1,  ivibhz+1,  1 
				aC0  fof   aamp,  	    aCpch+aCvib,afmnt0,0,  20,  .001, .08, .002,  120,    1,   2,   p3
				aC1  fof   aamp*afamp1, aCpch+aCvib,afmnt1,0,  20,  .001, .08, .002,  120,    1,   2,   p3
				aC2  fof   aamp*afamp2, aCpch+aCvib,afmnt2,0,  20,  .001, .08, .002,  120,    1,   2,   p3
				aC3  fof   aamp*afamp3, aCpch+aCvib,afmnt3,0,  20,  .001, .08, .002,  120,    1,   2,    p3
				aC4  fof   aamp*afamp4, aCpch+aCvib,afmnt4,0,  20,  .001, .08, .002,  120,    1,   2,    p3
		
				aDpch  linseg ipch1+(ipch1*ipct), idur1+(idur1*.1), ipch2+(ipch2*ipct), idur2-(idur2*.1), ipch3+(ipch3*ipct), idur3+(idur3*.1), ipch4+(ipch4*ipct), idur4-(idur4*.1), ipch5+(ipch5*ipct), idur5+(idur5*.1), ipch6+(ipch6*ipct), idur6-(idur6*.1), ipch7+(ipch7*ipct), idur7, ipch8+(ipch8*ipct)
				aDvib  oscil   kvibwth-2,  ivibhz+.5,  1 
				aD0  fof   aamp,  	    aDpch+aDvib,afmnt0,0,  10,  .001, .08, .002,  120,    1,   2,   p3
				aD1  fof   aamp*afamp1, aDpch+aDvib,afmnt1,0,  10,  .001, .08, .002,  120,    1,   2,   p3
				aD2  fof   aamp*afamp2, aDpch+aDvib,afmnt2,0,  10,  .001, .08, .002,  120,    1,   2,   p3
				aD3  fof   aamp*afamp3, aDpch+aDvib,afmnt3,0,  10,  .001, .08, .002,  120,    1,   2,    p3
				aD4  fof   aamp*afamp4, aDpch+aDvib,afmnt4,0,  10,  .001, .08, .002,  120,    1,   2,    p3
				
				goto Compute_Chorus_Stereo
		
		Compute_Chorus_Stereo:
		; Panned & fixed & combined outputs have final amps scaled to = eachother
		; P-fields in score for panning are ignored in chorused output		
			if iFX == 1 goto Stereo1
			if iFX == 2 goto Stereo2
			if iFX >= 3 goto Stereo3
		
			Stereo1: ; fixed pair of voices				
				aLa = ((aA0+aA1+aA2+aA3+aA4)*.80)*1.37
				aLb = ((aB0+aB1+aB2+aB3+aB4)*.20)*1.37
				aRa = ((aA0+aA1+aA2+aA3+aA4)*.80)*1.37
				aRb = ((aB0+aB1+aB2+aB3+aB4)*.20)*1.37
				aVoicedL = ((aLa+aLb)*.446)*(1-kUnVcMix) 
				aVoicedR = ((aRa+aRb)*.446)*(1-kUnVcMix)
				goto Pan_Switch
 
			Stereo2: ; panned pair of voices 
				kpanLc  oscil  1,  .18,  1; amp, freq, GEN, phase 
				kpanRc  oscil  1,  .32,  1
				kpanLd  oscil  1,  .30,  1 
				kpanRd  oscil  1,  .22,  1
				aLc = (aC0+aC1+aC2+aC3+aC4)*kpanLc				
				aRc = (aC0+aC1+aC2+aC3+aC4)*kpanRc				
				aLd = (aD0+aD1+aD2+aD3+aD4)*kpanLd				
				aRd = (aD0+aD1+aD2+aD3+aD4)*kpanRd
				aVoicedL = ((aLc+aLd)*.2233)*(1-kUnVcMix) 
				aVoicedR = ((aRc+aRd)*.2233)*(1-kUnVcMix)
				goto Pan_Switch

			Stereo3: ; fixed & panned pairs	combined		
				aLa = ((aA0+aA1+aA2+aA3+aA4)*.80)*1.37
				aLb = ((aB0+aB1+aB2+aB3+aB4)*.20)*1.37
				aRa = ((aA0+aA1+aA2+aA3+aA4)*.80)*1.37
				aRb = ((aB0+aB1+aB2+aB3+aB4)*.20)*1.37
				kpanLc  oscil  1,  .09,  1
				kpanRc  oscil  1,  .16,  1
				kpanLd  oscil  1,  .15,  1 
				kpanRd  oscil  1,  .11,  1
				aLc = (aC0+aC1+aC2+aC3+aC4)*kpanLc				
				aRc = (aC0+aC1+aC2+aC3+aC4)*kpanRc				
				aLd = (aD0+aD1+aD2+aD3+aD4)*kpanLd				
				aRd = (aD0+aD1+aD2+aD3+aD4)*kpanRd
				aVoicedL = ((aLa+aLb+aLc+aLd)*.2233)*(1-kUnVcMix) 
				aVoicedR = ((aRa+aRb+aRc+aRd)*.2233)*(1-kUnVcMix)

	Pan_Switch:
	
		; COMBINE VOICED & UNVOICED SOUNDS, then...
		; IF NOT CHORUSED (LFOed - nopan), SET PANNING LEVELS
		if iFX != 0 goto NoPan
		kpan  linseg p38, idur1, p39, idur2, p40, idur3, p41, idur4, p42, idur5, p43, idur6, p44, idur7, p45
		aDryL = (aUnvoiced+aVoicedL)*kpan	
		aDryR = (aUnvoiced+aVoicedR)*(1-kpan)
		goto Reverb_Switch
		
		NoPan:
			aDryL = (aUnvoiced+aVoicedL)	
			aDryR = (aUnvoiced+aVoicedR)
		
	Reverb_Switch:
		kRvbgain  linseg p54, idur1, p55, idur2, p56, idur3, p57, idur4, p58, idur5, p59, idur6, p60, idur7, p61
		if (kRvbgain == 0) goto Dry_Out
		if (kRvbgain > 0) goto Rev_Snd
	
	Rev_Snd: 
		gaRvbL = aDryL * kRvbgain	; Reverbed sig. is a % of the dry sig.
		gaRvbR = aDryR * kRvbgain
		aDryL = (aDryL*(1-kRvbgain)); The dry sig. is reduced by that percent
		aDryR = (aDryR*(1-kRvbgain)); to keep global amp constant, this still does
									; not control reverb-feedback-decay or polyphony
	Dry_Out:						; which ultimately are controlled by p4 (iamp)						
		outs  aDryL, aDryR 
	END:	

endin

;*****************************************************
;	STEREO REVERB
instr 98

	aL	reverb	gaRvbL,  gkRvbFeedBak	; put global signal into reverb
	aR      reverb	gaRvbR,  gkRvbFeedBak
	outs	aL, aR
	gaRvbL 	= 	0			; reinit the global signal
	gaRvbR 	= 	0
endin	
