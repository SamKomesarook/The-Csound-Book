;---------------------------------------------------------
; Drum Kit
; Coded by Hans Mikelson January 2001
;---------------------------------------------------------
sr	=	44100			; Sample rate
kr	=	4410			; Kontrol rate
ksmps	=	10			; Samples/Kontrol period
nchnls	=	2			; Normal stereo
	zakinit	50,50			; Initialize the zak system


;---------------------------------------------------------
; Pinkish noise
;---------------------------------------------------------
	instr   1

iseed	=	p4		; Random generator seed
iout	=	p5		; Zak output channel

asig	pinkish 2, 0, 20, iseed ; Use multi-rate pink noise

	zaw	asig, iout	; Write to the audio zak channel

        endin

;---------------------------------------------------------
; Sampled noise
;---------------------------------------------------------
        instr   2

iamp1	=	p4		; Amplitude for channel 1
iamp2	=	p5		; Amplitude for channel 2
iwave	=	p6		; Sample waveform file
ioffs	=	p7		; Offset
iout1	=	p8		; Zak output channel for left signal
iout2	=	p9		; Zak output channel for right signal

asigl, asigr	diskin	iwave, 1, ioffs, 1	; Read in the wave

	zaw	asigl/32767*iamp1, iout1	; Write to zak audio
        zaw     asigr/32767*iamp2, iout2	; channels 1 and 2

        endin 

;---------------------------------------------------------
; Kick Drum 1
;---------------------------------------------------------
	instr	10

idur	=	p3		; Duration
iamp	=	p4		; Amplitude
ilowf	=	p5		; Low frequency
ihif	=	p6		; High freqency
ipanl	=	sqrt(p7)	; Pan left & right use sqrt
ipanr	=	sqrt(1-p7)	; for smoother panning
iacc	=	p8		; Accent
irez	=	p9		; Resonance
iod	=	p10		; Overdrive
imix	=	p11		; OvrToneMix

; Freq Envelope
kfenv	linseg	ihif,   idur*.1/iacc, ihif*.7,\
		idur*.2/iacc, ilowf*1.5, idur-idur*.3/iacc, ilowf    

; Freq Envelope
kfenv2	linseg	ihif*2, idur*.1/iacc, ihif,\
		idur*.2/iacc, ilowf*2, idur-idur*.3/iacc, ilowf*1.2 

; Amp Envelope generate a pulse of noise
kaenv	linseg	0, .001, 1, .02, 1, .04, .1, idur-.061, 0
kdclck	linseg	1, idur-.05, 1, .05, 0		; Declick

asigl  zar       1	; Read the noise from the zak audio channels
asigr  zar       2	; Note that the noise must be on channels 1 and 2

; Set up left channel
afltl  moogvcf   asigl*kaenv, kfenv,  irez		; Moog filter
afltl2 moogvcf   asigl*kaenv, kfenv2, irez		; Moog filter
aout1l =         (afltl+.5*imix*afltl2)*kaenv*iod/iacc	; Pulse & mix the noise
krmsl  rms       aout1l, 1000				; Limiter, get rms
kliml  table3    krmsl*.5, 5, 1				; Get limiting value
aoutl  =         aout1l*kliml*iamp*kdclck*iacc		; Scale again and ouput

; Set up right channel
afltr  moogvcf   asigr*kaenv, kfenv, irez		; Moog filter
afltr2 moogvcf   asigr*kaenv, kfenv2, irez		; Moog filter
aout1r =         (afltr+.5*imix*afltr2)*kaenv*iod/iacc	; Pulse & mix the noise
krmsr  rms       aout1r, 1000				; Limiter, get rms
klimr  table3    krmsr*.5, 5, 1				; Get limiting value
aoutr  =         aout1r*klimr*iamp*kdclck*iacc		; Scale again and ouput

       outs      aoutl*ipanl*3, aoutr*ipanr*3		; Output the sound

       endin

;---------------------------------------------------------
; Kick Drum 2
;---------------------------------------------------------
	instr	11

idur	=	p3		; Duration
iamp	=	p4		; Amplitude
ihif	=	p5		; Low frequency
ilof	=	p6		; High freqency
ipanl	=	sqrt(p7)	; Pan left & right use sqrt
ipanr	=	sqrt(1-p7)	; for smoother panning
idec	=	p8		; Decay
itens	=	p9		; Tension
ihit	=	p10		; Accent
iq	=	p11		; Pitch Bend Q (oscilation)
iod	=	p12		; Amplitude of overtones
ioc	=	p13		; Control of overtone amplitudes
iof	=	p14		; Control of overtone frequencies
isus	=	p15		; Sustain
iqf	=	p16		; FM resonance frequency
ilpf	=	p17		; Amp low pass frequency

; Freq Envelope
afqc	linseg	ihif,idec,ilof,idur*-idec,ilof	; Hi-Lo fqc sweep
afqc2	rezzy	afqc,iqf,iq			; Add some ripples
afqc3	=	afqc-afqc2*itens		; Mix fqc sweep with ripples

aamp	expseg	1,idur,isus			; Exp amp envelope
aamp2   butlp	aamp,ilpf			; Low pass version
aamp3	=	(aamp*ihit+aamp2*(1-ihit))	; Mix the two envelopes for different attacks
adclk	linseg	0,.002,1,idur-.004,1,.002,0	; Declick envelope

asig	oscil	1,afqc3,1			; Simple sine oscillator

ioc1	=	1+ioc				; Overtone control for base fqc*2
ioc2	=	1+ioc*2				; ditto fqc*3
ioc3	=	1+ioc*3				; ditto fqc*5

asig2a	oscil	1,afqc3*2,1,.25			; Sine oscillator 2
asigo	=	asig2a+.95			; Scale for the tanh
asig2b	=	-tanh((asig2a+.9)*ioc1)+1		; Create a squarish envelope for the overtones
asig2c	=	(asig2a*asig2b)*aamp3^ioc1	; This makes pulses of sine waves

asig3a	oscil	1,afqc3*(1+iof*2),1,.25		; Sine oscillator 3
asig3b	=	-tanh(asigo*ioc2)+1		; Squarish envelope pulses
asig3c	=	(asig3a*asig3b)*aamp3^ioc2	; Adjust the magnitude with ioc2

asig5a	oscil	1,afqc3*(1+iof*4),1,.25		; Sine oscillator 5
asig5b	=	-tanh(asigo*ioc2)+1		; Squarish envelope pulses
asig5c	=	(asig5a*asig5b)*aamp3^ioc3	; Adjust the magnitude

; Prepare for output
aout	=	(asig*aamp3+(asig2c+asig3c+asig5c)*iod)*adclk*iamp
aoutl	=	aout
aoutr	=	aout

       outs      aoutl*ipanl, aoutr*ipanr		; Output the sound

       endin

;---------------------------------------------------------
; Stereo Cymbal 2
;---------------------------------------------------------
       instr	24

idur	=	p3		; Duration
iamp	=	p4		; Amplitude
ifqc	=	cpspch(p5)	; Pitch
ipanl	=	sqrt(p6)	; Pan left
ipanr	=	sqrt(1-p6)	; Pan right
ifco	=	p7		; Fco
iq	=	p8		; Q
iotv	=	p9		; Overtone volume
iotf	=	ifco*p10	; Fco*OTFqc
iotq	=	iq*p11		; Q*OTQ
iinchl	=	1		; Noise input for left channel
iinchr	=	2		; Noise input for right channel
imix	=	p12

kdclk	linseg	0, .002, 1, idur-.004, 1, .002, 0 ; Declick envelope
kamp	expseg	1, idur, .01
kamp2	linseg	0, idur*.2, 1, idur*.4, .3, idur*.4, 0
kamp2   =       kamp2*imix
kamp3	linseg	0, .002, 1, .004, .5, .004, 0, idur-.01, 0
kflp	linseg	8000, .01, 5000, idur-.01, 1000

arndl	zar	iinchl
arndr	zar	iinchr

;asig0	vco	1, ifqc*.5,  2, .5, 1, 1	; Generate impulse
asig1	vco	1, ifqc,     2, .5, 1, 1	; Generate impulse
asig2	vco	1, ifqc*1.5, 2, .5, 1, 1	; Generate impulse

asigl	=	(asig1*asig2*(1+arndl))*kamp+arndl*kamp2
asigr	=	(asig1*asig2*(1+arndr))*kamp+arndr*kamp2

aoutl1	rezzy	asigl, ifco, iq, 1	; Apply amp envelope and declick
aoutr1	rezzy	asigr, ifco, iq, 1	; Apply amp envelope and declick

aoutl2	rezzy	asigl, iotf, iotq, 1	; Apply amp envelope and declick
aoutr2	rezzy	asigr, iotf, iotq, 1	; Apply amp envelope and declick

aoutl	=	aoutl1+aoutl2*iotv	; Mix the signal with the overtone
aoutr	=	aoutr1+aoutr2*iotv

alpl	butlp	aoutl, 15000		; Low pass filter the very high
alpr	butlp	aoutr, 15000		; frequencies to get rid of some noise

	outs	alpl*ipanl*iamp*kdclk, alpr*ipanr*iamp*kdclk

	endin

;---------------------------------------------------------
; Snare 4
;---------------------------------------------------------
       instr     34

idur	=	p3		; Duration
iamp	=	p4		; Amplitude
ifqc	=	cpspch(p5)	; Pitch to frequency
ipanl	=	sqrt(p6)	; Pan left
ipanr	=	sqrt(1-p6)	; Pan right
irez	=	p7		; Tone
ispdec	=	p8		; Spring decay
ispton	=	p9		; Spring tone
ispmix	=	p10		; Spring mix
ispq	=	p11		; Spring Q
ipbnd	=	p12		; Pitch bend
ipbtm	=	p13		; Pitch bend time

arndr1 init      0
arndr2 init      0

kdclk  linseg    1, idur-.002, 1, .002, 0                ; Declick envelope
aamp   linseg    1, .2/ifqc, 1, .2/ifqc, 0, idur-.002, 0 ; An amplitude pulse
kptch  linseg    1, ipbtm, ipbnd, ipbtm, 1, .1, 1

aosc1   vco      1, ifqc, 2, 1, 1, 1 ; Use a pulse of the vco to stimulate the filters
aosc    =        -aosc1*aamp        ; Multiply by the envelope pulse
aosc2   butterlp aosc, 12000        ; Lowpass at 12K to take the edge off

asig1   moogvcf  aosc,    ifqc*kptch, .9*irez      ; Moof filter with high resonance for basic drum tone
asig2   moogvcf  aosc*.5, ifqc*2.1*kptch, .75*irez ; Sweeten with an overtone

aampr  expseg    .1, .002, 1, .2, .005

arnd1	zar      1
arnd2	zar      2

arnd1   =        arnd1*2*asig1
arndr1 delay     arnd1-arndr2*.6, .01

arnd2   =        arnd2*2*asig1
arndr2 delay     arnd2-arndr1*.6, .01

ahp1l   rezzy    arnd1+arndr1, 2700*ispton*kptch, 5*ispq, 1 ; High pass rezzy based at 2700
ahp2l   butterbp arnd1, 2000*ispton*kptch, 500/ispq  ; Generate an undertone
ahp3l   butterbp arnd1, 5400*ispton*kptch, 500/ispq  ; Generate an overtone
ahpl    pareq    ahp1l+ahp2l*.7+ahp3l*.3, 15000, .1, .707, 2 ; Attenuate the highs a bit

ahp1r   rezzy    arnd2+arndr2, 2700*ispton*kptch, 5*ispq, 1 ; High pass rezzy based at 2700
ahp2r   butterbp arnd2, 2000*ispton*kptch, 500/ispq  ; Generate an undertone
ahp3r   butterbp arnd2, 5400*ispton*kptch, 500/ispq  ; Generate an overtone
ahpr    pareq    ahp1r+ahp2r*.7+ahp3r*.3, 15000, .1, .707, 2 ; Attenuate the highs a bit


; Mix drum tones, pulse and noise signal & declick
aoutl  =         (asig1+asig2+aosc2*.1+ahpl*ispmix*4)*iamp*kdclk 
aoutr  =         (asig1+asig2+aosc2*.1+ahpr*ispmix*4)*iamp*kdclk 
       outs      aoutl*ipanl, aoutr*ipanr              ; Output the sound

       endin

