; runs with DirectCSound v. 3.09
; author - Richard Bowers - April 2000
; NB there are some redundant lables which won't affect performance
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
<CsoundSynthesiser>
<CsOptions>
;enables sound in/out
-+e -g -+p12 -b882 -odevaudio -idevaudio -m3
</CsOptions>
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
<CsInstruments>

	sr=44100
	kr=441
	ksmps = 100 
	nchnls = 1	
	ga1	init 0
	gkdata 	init -1
	gitablen=524288
	gitabcps = 1/(gitablen/sr); standard read through audio table
	gkinxprev init 0
	gkptime01	init	0
	gkpflag01	init	0
	gkrelflag01	init	0
	gkpitchflag	init	0
	gkpitchprev 	init 	0
	gkrmsprev	init	2000
	gklow		init	800
	gkptimeprev	init	0
	gkchoose	init	0
	gknum		init	0
	gkproct		init	9
	gkstart		init	0
	gkend		init	0
	gkdur		init	0
	gkdurcps	init	gitabcps

;*********************
;MONITORING INSTRUMENT
;*********************
instr	18
;------------------------------
;GET SIGNAL AND SIGNAL STRENGTH
;------------------------------
ga1	in
gkrms	rms	ga1

;------------
;FLOW CONTROL
;------------
if gkpflag01=1 kgoto comprel01
if gkrelflag01=1 kgoto trigger

;------------------------------------------
;IF GKRMS LOUD COMPARE GKRMSPREV WITH GKRMS
;------------------------------------------
comppeak01: if gkrms<2000 kgoto return
if gkrms>gkrmsprev kgoto continue 	; SKIP IF STILL RISING
gkstart	timeinsts			; else capture the time
gkpflag01=1				; and SET THE SKIP FLAG

;-------------------------------------------------
;NOW TEST FOR LOWER THRESHOLD WHILST WRITING AUDIO
;-------------------------------------------------
comprel01:

ktnow	timeinsts;<<<useful??

if gkrms>gklow kgoto continue		; SKIP IF NOT LOW
gkend	timeinsts			; else capture end time
gkdur=gkend-gkstart			; calculate duration
gkdurcps=1/gkdur			; calculate cps rate to read table once for gkdur secs.
printk2	gkdur, 50
gkrelflag01=1				; and SET THE SKIP FLAG
gkpflag01=0				; and UNSET THE OLD FLAG

gkrmsprev=2000				; RESET UPPER THRESHOLD FOR NEW EVENT

;---------------------------------
;RESET DEFAULTS TO RESTART PROCESS
;---------------------------------

trigger: 
escape:

gkrelflag01=0; RESET THE OLD FLAG
kgoto reset
;------------------------------------------
;ASSIGN GKRMS TO GKRMSPREV BEFORE RETURNING
;------------------------------------------
continue: gkrmsprev=gkrms
kgoto return
reset: gkrmsprev=2000
return: 
endin


;;;;;;;;;;;;;;;;;;;;;;;;;;;
instr	90; PITCH DETECTION
;;;;;;;;;;;;;;;;;;;;;;;;;;;

gkpitchflag=(gkpflag01=1 ? 1 : 0)

if gkpitchflag=0 kgoto return

	wsig	spectrum	ga1, .02, 6, 12, 10
koct, kamp	specptrk	wsig, 1, 7.02, 10.04, 9.00, 10, 10, .8, 1, 8

koct=(koct=0 ? gkproct : koct)
kcps=cpsoct(koct)
gkproct=koct

;----------------------
;WRITING AUDIO TO TABLE
;----------------------

and	phasor	gitabcps
andex=and*gitablen
write: tablew	ga1, andex, 1, 0, 0, 1


;---------------------
;WRITING DATA TO TABLE
;---------------------
if gkpitchflag=gkpitchprev kgoto contin
kindexno=andex; the pointer into audio table to be placed in the data table
gkdata=(gkdata<127 ? gkdata+1 : 1); get the next index point modulo the table length
gkdata=(gkinxprev>kindexno ? 0 : gkdata)	; test for wraparound
gkinxprev=kindexno				; assign old value for test

tablew	kindexno, gkdata, 7, 0, 0, 1; write the value kindexno at location gkdata
gknum	rand	gkdata-1 ; get a random value from within scope of current pointer postion
reinit	segment

;;;;;;;

contin:
return:

;----------------
;CHOOSE A SEGMENT
;----------------

segment:
inum=int(abs(gknum))
idur=gkdur
print	inum
printk2	gkdata

locate: ioffset	table	inum, 7	; read location inum from f7
inext	table	inum+1, 7 	; read next value

iplaces=abs(inext-ioffset)	; calculate number of points for audio chunk in table

;------------
;READ SEGMENT
;------------

kfact1= kcps/1223 ;the ratio of kcps to a base frequency
and2	phasor	kfact1/(iplaces/sr)
knd	phasor	kfact1/(iplaces/sr)
andex2=(and2*iplaces)+ioffset
gasig5	tablei	andex2, 1, 0, 0, 1
kenv	tablei	knd, 8, 1, 0, 1; envelope segment
kdec	linseg	0, .01, 3, idur*7, 0 

out	(gasig5*kenv)*kdec

rireturn

;-----------------
;READ ENTIRE TABLE
;-----------------

kfm	oscil	gkrms/30000, kcps, 4; frequency modulator
gasig2a	oscili	.5, gitabcps+kfm, 1

gkpitchprev=gkpitchflag; note previous state
end: endin

;;;;;;;;;;;;;;;;;;
instr	91; REVERB
;;;;;;;;;;;;;;;;;;

;--------------------------------------------
;CYCLING ENVELOPE TO CREATE SOME WHITE SPACE
;--------------------------------------------

;control duration of envelope
kspace	oscili	1, gkdurcps, 2	
asig	reverb2	gasig2a*kspace, 1, .5
out	asig

endin
</CsInstruments>
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
<CsScore>
; DUMMY FOR 6000 s. REALTIME PERFORMANCE
f0	6000	
; 11.8+ SECS. AUDIO
f1	0	524288 -10 	1
; SLOW ENVELOPE
f2	0	2048	7	0	10	1	538	1	1500	0
; RAMP DOWN
f3	0	128	7	1	64	0	64	0
; SINE
f4	0	1024	10	1

; TABLE TO RECEIVE DATA
f7	0	128	-2	0
; GAUSSIAN CURVE FOR GRAINS
f8	0	2048	20	6	1


i90	0	6000
i91	0	6000
i18	0	6000

e

</CsScore>
</CsoundSynthesiser>