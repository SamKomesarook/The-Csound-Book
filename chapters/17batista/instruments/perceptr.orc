;=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*;
; A simple single-layer bidirectional perceptron,  ;
; using hebbian learning                           ;
;                                                  ;
; Coded for CSound by Pedro Batista jun/98         ;
;=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*;

sr	=	44100
kr	=	44100
ksmps	=	1

	zakinit	1, 288

;--------------------------------------------------
	instr	1
;--------------------------------------------------

inump	=	3 ; number of patterns (maximum 3)

;--------------------------------------------------
ibin	=	 1; [1-16]
ibout	=	17; [17-32]
ipes	=	33; [33-288]
;--------------------------------------------------
ksigi1	=	0
ksigi2	=	0
ksigi3	=	0
ksigo1	=	0
ksigo2	=	0
ksigo3	=	0
kstim	=	0

;--------------------------------------------------
; Sample input patterns

ain1	soundin	"c:\csound\samples\soundin.1"
ksigi1	downsamp ain1

ain2	soundin	"c:\csound\samples\soundin.2"
ksigi2	downsamp ain2

ain3	soundin	"c:\csound\samples\soundin.3"
ksigi3	downsamp ain3

;--------------------------------------------------
; Sample output patterns

ksigo1	=	ksigi1

ksigo2	=	ksigi2

ksigo3	=	ksigi3

;--------------------------------------------------
; Stimulus pattern

kstim	=	ksigi1

;
;--------------------------------------------------
; Perceptron processing start
;--------------------------------------------------
; initialize weights
kndi	=	0
loopi:
kndj	=	0
loopj:
	zkw	0, ipes+kndi*16+kndj
kndj	=	kndj+1
	if (kndj<16) kgoto loopj
kndi	=	kndi+1
	if (kndi<16) kgoto loopi

kpass	=	1
restrt:	;------------------------------------------

; select training signals
	if (kpass==1) kgoto case1
	if (kpass==2) kgoto case2
	if (kpass==3) kgoto case3
	kgoto	skip
case1:	
ksigi	=	ksigi1
ksigo	=	ksigo1
	kgoto	skip
case2:	
ksigi	=	ksigi2
ksigo	=	ksigo2
	kgoto	skip
case3:	
ksigi	=	ksigi3
ksigo	=	ksigo3
skip:

; convert input signal to binary
kndx	=	0
ksigi	=	ksigi+32768
loop1:
kbit	=	(frac(ksigi/2)==0 ? 0:1)
	zkw	kbit, ibin+kndx
ksigi	=	int(ksigi/2)
kndx	=	kndx+1
	if (kndx<16) kgoto loop1

; convert output signal to binary
kndx	=	0
ksigo	=	ksigo+32768
loop2:
kbit	=	(frac(ksigo/2)==0 ? 0:1)
	zkw	kbit, ibout+kndx
ksigo	=	int(ksigo/2)
kndx	=	kndx+1
	if (kndx<16) kgoto loop2

; train pattern
train:
kndi	=	0
loop3:
kndj	=	0
loop4:
kbi	zkr	ibin+kndi
kbo	zkr	ibout+kndj
kw	zkr	ipes+kndi*16+kndj
kw	=	kw+((kbi*2-1)*(kbo*2-1))
	zkw	kw, ipes+kndi*16+kndj
kndj	=	kndj+1
	if (kndj<16) kgoto loop4
kndi	=	kndi+1
	if (kndi<16) kgoto loop3

kpass	=	kpass+1

; proceed with next pattern
	if (kpass<=inump) kgoto restrt

; convert stimulus signal to binary
kndx	=	0
kstim	=	kstim+32768
loop5:
kbit	=	(frac(kstim/2)==0 ? 0:1)
	zkw	kbit, ibin+kndx
	zkw	0, ibout+kndx
kstim	=	int(kstim/2)
kndx	=	kndx+1
	if (kndx<16) kgoto loop5

; calculate response from stimulus pattern
prop:
kerr	=	0
kndi	=	0
loop6:
kbo	zkr	ibout+kndi
kact	=	0
kndj	=	0
loop7:
kbi	zkr	ibin+kndj
kw	zkr	ipes+kndj*16+kndi
kact	=	kact+kw*kbi
kndj	=	kndj+1
	if (kndj<16) kgoto loop7
	if (kact==0) kgoto skp1
kact	=	(kact>0 ? 1:0)
kerr	=	kerr+abs(kact-kbo)
	zkw	kact, ibout+kndi
skp1:
kndi	=	kndi+1
	if (kndi<16) kgoto loop6

kndi	=	0
loop8:
kbi	zkr	ibin+kndi
kact	=	0
kndj	=	0
loop9:
kbo	zkr	ibout+kndj
kw	zkr	ipes+kndj*16+kndi
kact	=	kact+kw*kbo
kndj	=	kndj+1
	if (kndj<16) kgoto loop9
	if (kact==0) kgoto skp2
kact	=	(kact>0 ? 1:0)
kerr	=	kerr+abs(kact-kbi)
	zkw	kact, ibin+kndi
skp2:
kndi	=	kndi+1
	if (kndi<16) kgoto loop8

	if (kerr>0) kgoto prop ; until stable

; convert binary response to audio value
kndx	=	0
ksigo	=	0
kpow2	=	1

loop10:
kbit	zkr	ibout+kndx
ksigo	=	ksigo+kbit*kpow2
kpow2	=	kpow2*2
kndx	=	kndx+1
	if (kndx<16) kgoto loop10

ksigo	=	ksigo-32768

; compress the resulting signal 

;kclip	table	... accepting ideas here :)

;--------------------------------------------------
; Output section
;--------------------------------------------------
aout	interp	ksigo
	out	aout

	endin
