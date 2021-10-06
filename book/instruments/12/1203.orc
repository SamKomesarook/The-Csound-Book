sr      =      	44100
kr    	=     	4410
ksmps  	=     	10
nchnls	=		1

		instr	1203	; SIMPLE PHASE MODULATION  (PM) 
isine	=		1					; f1 HAS A SINE WAVE
iamp	=		p4					; PEAK AMP OF CARRIER
ihz0	=		cpspch(p5)+p18		; THEORETICAL FUNDAMENTAL+DETUNE
icfac	=		p6					; CARRIER FACTOR
imfac	=		p7					; MODULATOR FACTOR
i2pi	=		6.2832				; 2 PI RADIANS PER CYCLE
indx	=		p8/i2pi				; MAXIMUM INDEX VALUE/2PI
ieva	=		p9					; ATTACK TIME OF MAIN ENVELOPE
ievd	=		p10					; DECAY TIME OF MAIN ENVELOPE
iamp2	=		p11*iamp			; MAIN AMP SUSTAIN LEVEL
ievr	=		p12					; RELEASE TIME OF MAIN ENVELOPE
ievss	=		p3-ieva-ievd-ievr	; ENV STEADY STATE
indx1	=		p13*indx			; INITIAL/FINAL INDEX
idxa	=		p14					; ATTACK TIME OF INDEX
idxd	=		p15					; DECAY TIME OF INDEX
indx2	=		p16*indx			; SUSTAINED INDEX
idxr	=		p17					; RELEASE TIME OF INDEX
idxss	=		p3-idxa-idxd-idxr	; INDEX STEADY STATE
kndx	linseg	indx1, idxa, indx, idxd, indx2, idxss, indx2, idxr, indx1	
kamp	linseg	0, ieva, iamp, ievd, iamp2, ievss, iamp2, ievr,0	
amodsig	oscili	kndx,ihz0*imfac,isine ; THE MODULATOR
acarphs	phasor	ihz0*icfac			; MOVING PHASE AT CARRIER FRQ
; PHASE MODULATION OF CARRIER TAKES PLACE HERE:	; NORMALIZED INDEX...
asig	tablei	acarphs+amodsig, isine, 1, 0, 1
		out		asig*kamp			; ...AND WRAP FLAG ON
		endin		
