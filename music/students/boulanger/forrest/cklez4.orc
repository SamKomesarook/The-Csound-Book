;********************************
;* James Forrest                *
;* CKlez.orc - csound orchestra *
;* 03.2001                      *
;********************************

;header
sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         1

;INSTRUMENT 1
;Waveguide Bass
;  from Hans Mikelson's Waveguide Bass, 
;  _CSound Book_, Richard Boulanger, ed.

          instr     1

; INITIALIZATIONS
ifqc      =         cpspch(p5)
ipluck    =         1/ifqc*p6
kcount    init      0
adline    init      0
ablock2   init      0
ablock3   init      0
afiltr    init      0
afeedbk   init      0

; OUTPUT ENVELOPE
koutenv   linseg    0,.01,1,p3-.11,1,.1,0 ; OUTPUT ENVELOPE
kfltenv   linseg    0, 1.5, 1, 1.5, 0 

; THIS ENVELOPE LOADS THE STRING WITH A TRIANGLE WAVE
kenvstr   linseg    0,ipluck/4,-p4/2,ipluck/2,p4/2,ipluck/4,0,p3-ipluck,0
aenvstr   =         kenvstr
ainput    tone      aenvstr,200

; DC BLOCKER
ablock2   =         afeedbk-ablock3+.99*ablock2
ablock3   =         afeedbk
ablock    =         ablock2

; DELAY LINE WITH FILTERED FEEDBACK
adline    delay     ablock+ainput,1/ifqc-15/sr
afiltr    tone      adline,400

; RESONANCE OF THE BODY 
abody1    reson     afiltr, 110, 40
abody1    =         abody1/5000
abody2    reson     afiltr, 70, 20
abody2    =         abody2/50000
afeedbk   =         afiltr
aout      =         afeedbk
          out       50*koutenv*(aout + kfltenv*(abody1 + abody2))

          endin

;INSTRUMENT 2
;Waveguide Clarinet
;  from Hans Mikelson's Waveguide Clarinet, 
;  _CSound Book_, Richard Boulanger, ed.
          
          instr      2
areedbell init  0
ifqc      =          cpspch(p5)
ifco      =          p7
ibore     =          1/ifqc-15/sr

; ENVELOPE FROM PERRY COOKE'S CLARINET
kenv1     linseg     0, .005, .55 + .3*p6, p3 - .015, .55 + .3*p6, .01, 0
kenvibr   linseg     0, .1, 0, .9, 1, p3-1, 1    ; VIBRATO ENVELOPE

; SUPPOSEDLY HAS SOMETHING TO DO WITH REED STIFFNESS?
kemboff   =          p8

; BREATH PRESSURE
avibr     oscil      .1*kenvibr, 5, 3
apressm   =          kenv1 + avibr

; REFLECTION FILTER FROM THE BELL IS LOWPASS
arefilt   tone      areedbell, ifco

; THE DELAY FROM BELL TO REED
abellreed delay     arefilt, ibore

; BACK PRESSURE AND REED TABLE LOOK UP
asum2     =         - apressm -.95*arefilt - kemboff
areedtab  tablei    asum2/4+.34, p9, 1, .5
amult1    =         asum2 * areedtab

; FORWARD PRESSURE
asum1     =         apressm + amult1
areedbell delay     asum1, ibore
aofilt    atone     areedbell, ifco
          out       aofilt*p4

          endin

;INSTRUMENT 3
;Random Vowel FOF Instrument
;  from Steven Cook's CHANT orchestra, 
;  _CSound Catalog_, Richard Boulanger, ed.

	instr    3

ilevl    = p4*10000   ; Output level
ipitch   = cpspch(p5) ; Pitch
ivibr    = p6         ; Vibrato rate
ivibd    = p7         ; Vibrato depth
irate    = p8         ; Random vowel rate
idet     = p9         ; Detune
ileng    = p3

kenv     linseg  0, .1, 1, p3 - .2, 1, .1, 0
iseed    = rnd(1)
k1       randi  .5, irate, iseed
k1       = k1 + .5
k2       linseg  0, p3, ivibd
k3       oscil  k2, ivibr, 1
k1f      table  k1, 11, 1
k2f      table  k1, 12, 1
k3f      table  k1, 13, 1
k4f      table  k1, 14, 1
k5f      table  k1, 15, 1
k1b      table  k1, 21, 1
k2b      table  k1, 22, 1
k3b      table  k1, 23, 1
k4b      table  k1, 24, 1
k5b      table  k1, 25, 1
kpitch   = ipitch + k3 + idet
a1       fof  1.0, kpitch, k1f, 0, k1b, .003, .02, .007, 1000, 3, 2, ileng
a2       fof  0.7, kpitch, k2f, 0, k2b, .003, .02, .007, 1000, 3, 2, ileng
a3       fof  0.5, kpitch, k3f, 0, k3b, .003, .02, .007, 1000, 3, 2, ileng
a4       fof  0.4, kpitch, k4f, 0, k4b, .003, .02, .007, 1000, 3, 2, ileng
a5       fof  0.3, kpitch, k5f, 0, k5b, .003, .02, .007, 1000, 3, 2, ileng
out      (a1 + a2 + a3 + a4 + a5)*ilevl*kenv

endin

;INSTRUMENT 4
;Exponential Bouncing Sinewave

	instr 4
idur 		= p3
iamp 		= p4
ifrq 		= cpspch(p5)	;freq to start from
ifrq2		= cpspch(p6)	;freq to fall to
iinitrate		= p7			;initial bouncing rate
ifinalrate	= p8			;final bouncing rate

arepfrqenv	expon	iinitrate, idur, ifinalrate
aampenv		oscili	iamp, arepfrqenv, 5
afrqenv1		expon	ifrq, idur, ifrq2
afrqenv2		oscili	afrqenv1, arepfrqenv, 4
asig			oscili	aampenv, afrqenv2, 3
aglobalenv	linseg	1.0, idur*0.85, 1.0, idur*0.10, 0
	out		asig*aglobalenv
	endin
