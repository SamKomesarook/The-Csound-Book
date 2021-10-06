sr	=  44100
kr	=  22050
ksmps	=  2
nchnls	=  1

	seed 0
gax0	init 0

#define MIDI2CPS(xmidi) # (440.0*exp(log(2.0)*(($xmidi)-69.0)/12.0)) #
#define CPS2MIDI(xcps)  # ((log(($xcps)/440.0)/log(2.0))*12.0+69.0) #

	instr 1

/* ------------------------------------------------------------------------- */

ivol	table  0,40	/* volume					*/
ibpm	table  1,40	/* tempo					*/

irel	table  2,40	/* release time					*/

istrtf1	table  3,40	/* start frequency 1				*/
ifdec1	table  4,40	/* freq. decay speed 1				*/
istrtf2	table  5,40	/* start frequency 2				*/
ifdec2	table  6,40	/* freq. decay speed 2				*/

ibwx0	table  7,40	/* noise bandwidth offset (Hz)			*/
ibwx1	table  8,40	/* noise bandwidth / osc. frequency		*/

iLPf	table  9,40	/* LP filter start frq. / osc. freq.		*/
iLPd	table 10,40	/* LP filter freq. decay speed			*/

iAM1s	table 11,40	/* amp. envelope 1 start value			*/
iAM1d	table 12,40	/* amp. envelope 1 decay speed			*/
iAM2s	table 13,40	/* amp. envelope 2 start value			*/
iAM2d	table 14,40	/* amp. envelope 2 decay speed			*/

/* ------------------------------------------------------------------------- */

ibtime	=  60/ibpm

p3	=  p3+irel+0.05

imkey	=  p4
imvel	=  p5

icps	=  $MIDI2CPS(imkey)
iamp	=  (0.0039+imvel*imvel/16192)*ivol
kamp	linseg 1,p3-(irel+0.05),1,irel,0,0.05,0

k_	port 1,ibtime/ifdec1,istrtf1		/* calculate base frequency */
k__	port 1,ibtime/ifdec2,istrtf2
kcps	=  icps*k_*k__

a_	unirand 2				/* oscillator */
a_	=  a_-1
a_	butterbp a_,kcps,ibwx0+kcps*ibwx1
a0	=  a_

k_	expseg 1,ibtime/iAM1d,0.5			/* amp. envelopes */
k__	expseg 1,ibtime/iAM2d,0.5
k_	=  (1-k_)*(1-iAM1s)+iAM1s
k__	=  (1-k__)*(1-iAM2s)+iAM2s
a0	=  a0*k_*k__

a1	=  a0

k_	port 0,ibtime/iLPd,iLPf			/* LP filter */
a0	butterlp a0,kcps*k_

a_	butterhp a1,kcps*1
a_	butterlp a_,kcps*8
k_	expseg 1,0.005,0.5
a0	=  a0+1.5*a_*k_

gax0	=  gax0+a0*iamp*kamp

	endin

	instr 90

/* ------------------------------------------------------------------------- */
iamp	table	0,64	/* output gain					*/
imax1	table	1,64	/* 1. max. level		1st limiter	*/
idel1	table	2,64	/* 1. delay time				*/
idec1	table	3,64	/* 1. decay speed				*/
iatt1	table	4,64	/* 1. attack speed				*/
ifrq1	table	5,64	/* 1. lowpass filter freq.			*/
imax2	table	6,64	/* 2. max. level		2nd limiter	*/
idel2	table	7,64	/* 2. delay time				*/
idec2	table	8,64	/* 2. decay speed				*/
iatt2	table	9,64	/* 2. attack speed				*/
ifrq2	table	10,64	/* 2. lowpass filter freq.			*/
/* ------------------------------------------------------------------------- */

a1	=  gax0		/* get input signal */
gax0	=  0

klv01	init 0
klv02	init 0

ad1	delay a1,idel1			/* 1. limiter */

klx	downsamp abs(a1)
klv01	=  (klx>klv01 ? klv01+(klx-klv01)*idec1:klv01+(klx-klv01)*iatt1)
al1	upsamp klv01
al1	butterlp al1,ifrq1
klv01x	downsamp al1

a1	=  (klv01x<imax1 ? ad1:ad1*imax1/klv01x)

ad1	delay a1,idel2			/* 2. limiter */

klx	downsamp abs(a1)
klv02	=  (klx>klv02 ? klv02+(klx-klv02)*idec2:klv02+(klx-klv02)*iatt2)
al1	upsamp klv02
al1	butterlp al1,ifrq2
klv02x	downsamp al1

ad1	=  (klv02x<imax2 ? ad1:ad1*imax2/klv02x)

ad1	butterlp iamp*ad1,sr*0.48

	out ad1

	endin


