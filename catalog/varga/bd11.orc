sr	=  44100
kr	=  22050
ksmps	=  2
nchnls	=  1

	seed 0

#define MIDI2CPS(xmidi) # (440.0*exp(log(2.0)*(($xmidi)-69.0)/12.0)) #
#define CPS2MIDI(xcps)  # ((log(($xcps)/440.0)/log(2.0))*12.0+69.0) #

	instr 1

/* ------------------------------------------------------------------------- */

ivol	=  1.2		/* volume					*/
ibpm	=  150		/* tempo					*/

irel	=  0.05		/* release time					*/

istrtf1	=  64.0		/* start frequency / note f.			*/
ifdec1	=  128		/* freq. decay speed				*/

insmix	=  1.0		/* noise mix					*/

iHP1f	=  0.5		/* HP filter 1 frequency / osc. freq.		*/
iBP1f	=  1.0		/* BP filter 1 frequency / osc. freq.		*/
iBP1b	=  1.0		/* BP filter 1 bandwidth / osc. freq.		*/

iHP2f	=  2.0		/* HP filter 2 frequency / osc. freq.		*/
iHP2m	=  0.0		/* HP filter 2 mix				*/
iHP3f	=  8.0		/* HP filter 3 frequency / osc. freq.		*/
iHP3m	=  0.0		/* HP filter 3 mix				*/

iHPxf	=  1.0		/* output HP filter frequency / note frequency	*/
iHPxr	=  0.7		/* output HP filter resonance			*/

iLPf1	=  4.0		/* output LP filter frequency 1 / osc. freq.	*/
iLPd1	=  4		/* output LP filter frequency 1 decay speed	*/
iLPf2	=  4.0		/* output LP filter frequency 2 / osc. freq.	*/
iLPd2	=  4		/* output LP filter frequency 2 decay speed	*/

iAMxd	=  8		/* amp. envelope speed				*/

iAM1s	=  0.25		/* amp. envelope 1 start value			*/
iAM1d	=  8		/* amp. envelope 1 decay speed			*/
iAM2s	=  2.0		/* amp. envelope 2 start value			*/
iAM2d	=  2		/* amp. envelope 2 decay speed			*/

/* ------------------------------------------------------------------------- */

ibtime	=  60/ibpm

p3	=  p3+irel+0.05

imkey	=  p4
imvel	=  p5

icps	=  $MIDI2CPS(imkey)
iamp	=  (0.0039+imvel*imvel/16192)*ivol*16384
kamp	linseg 1,p3-(irel+0.05),1,irel,0,0.05,0

k_	line 0, 1, 1				/* calculate osc. frequency */
kcps	=  icps*(k_*(ifdec1/ibtime)+istrtf1)/(k_*(ifdec1/ibtime)+1)

knumh	=  sr/(2*kcps)				/* square oscillator */

a__	buzz sr/(10*3.14159265), kcps, knumh, 256, 0
a___	buzz sr/(10*3.14159265), kcps, knumh, 256, 0.5
a0	tone a__-a___, 10

a_	unirand 2				/* noise generator */
a0	=  a0+(a_-1)*insmix

a1	=  a0	/* save osc. output */

a0	butterhp a0,iHP1f*kcps			/* HP filter 1 */

a0	butterbp a0,iBP1f*kcps,iBP1b*kcps	/* BP filter 1 */

a_	butterhp a1,iHP2f*kcps			/* HP filter 2 and 3 */
a__	butterhp a1,iHP3f*kcps
a0	=  a0+a_*iHP2m+a__*iHP3m

a0	butterhp a0,iHPxf*icps				/* output HP filter */
a0	pareq a0,iHPxf*icps,iHPxr*1.4142,iHPxr,0

k_	port 1,ibtime/iAMxd,0				/* amp. envelope */
k__	=  sin(k_*3.14159265*2.0)
a0	=  a0*k__

k_	expseg 1,ibtime/iAM1d,0.5			/* amp. envelopes */
k__	expseg 1,ibtime/iAM2d,0.5
k_	=  (1-k_)*(1-iAM1s)+iAM1s
k__	=  (1-k__)*(1-iAM2s)+iAM2s
a0	=  a0*k_*k__

k_	port 0,ibtime/iLPd1,iLPf1			/* output LP filter */
k__	port 0,ibtime/iLPd2,iLPf2
a0	butterlp a0,kcps*(k_+k__)

a0	butterlp a0*iamp*kamp,sr*0.48

	out a0

	endin

	instr 90
	endin


