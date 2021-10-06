; Wind Chimes in AC
; by David Linnenbank
; mailto:
; dalinnen@ma.ultranet.com

sr		=	44100
kr		=	4410
ksmps	=	10
nchnls	=	1

	instr 101	; fm instrument with modulator on a pitch slope
kamp	=		ampdb(p5)
ifreq	=		cpspch(p4)
idive	=		cpspch(p8)			; initial/target pitch of modulator
idur	=		p3
kenv	linen	kamp, p6, idur, p7
kseg	linseg	idive, .25*idur, ifreq+.003, .76*idur, idive
a1		oscil	kenv, kseg, 1
a2		oscil	kenv, ifreq+a1, 1
acomb	comb	a2, 4, 1/ifreq		; comb filter w/ loop time = period of ifreq
		out		acomb*kenv*.00175	; rescaled for non-floats
	endin
