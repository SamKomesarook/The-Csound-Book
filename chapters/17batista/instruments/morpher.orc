;=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-;
;        Some sort of 'morphing' neural instrument         ;
;                                                          ;
;              Coded by Pedro Batista, 1998                ;
;=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-;

sr	=	44100
kr	=	4410
ksmps	=	10

	zakinit	1, 253

;----------------------------------------------------------;
	instr   1
;----------------------------------------------------------;

inump	=	p5       ; number of patterns
inump	=	(inump<1 ? 1:inump)
inump	=	(inump>4 ? 4:inump)
istps	=	p4       ; number of steps for each value
ierng	=	.99/istps/2

ihsz	table	inump-1, 1 ; size of hidden layer
ihsz	=	(ihsz<1 ? 1:ihsz)
ihsz	=	(ihsz>32 ? 32:ihsz)
iisz	=	1        ; size of input
iosz	=	1        ; size of output layer

ipat1	=	p6       ;These are used for the soundin
ipat2	=	p7       ;numbers to be passed.
ipat3	=	p8       ;(one for each input/output pair)
ipat4	=	p9
ipats	=	p10

iavrw	=	128      ;moving average window size
iavrt	=	2        ;moving average table

;RProp parameters
idw0	=	.1       ; initial dw
idwmin	=	.00001   ; minimum dw
idwmax	=	10       ; maximum dw
ietam	=	.5       ; eta minus
ietap	=	1.2      ; eta plus
imaxit	=	1000     ; maximum number of iterations

;array definitions
i_a	=	1                           ; start of activation array
i_w	=	i_a+ihsz+iosz               ; start of weight array
i_dw	=	i_w+iisz*ihsz+ihsz*iosz     ; start of weight change array
i_dedo	=	i_dw+iisz*ihsz+ihsz*iosz    ; start of dE/do array
i_dedw	=	i_dedo+ihsz+iosz            ; start of dE/dw array
i_dedwd	=	i_dedw+iisz*ihsz+ihsz*iosz  ; start of delayed dE/dw array
i_in	=	i_dedwd+iisz*ihsz+ihsz*iosz ; start of input area
i_out	=	i_in+iisz*(inump+1)         ; start of output area
i_end	=	i_out+iosz*(inump+1)
;	print	i_end

	igoto	perf
neural:

;initializations-------------------------------------------
indx	=	0
loop1:
ival	=	(rnd(200)/100)-1
	ziw	ival, i_w+indx
	ziw	idw0, i_dw+indx
	ziw	0, i_dedwd+indx
indx	=	indx+1
	if (indx<iisz*ihsz+ihsz*iosz) igoto loop1

;main loop-------------------------------------------------
iter	=	0
newitr:

;----------------------------------------------------------
;zero combined error array, dE/dw
indx	=	0
loop100:
	ziw	0, i_dedw+indx
indx	=	indx+1
	if (indx<iisz*ihsz+ihsz*iosz) igoto loop100
;----------------------------------------------------------
ipat	=	0
imiss	=	0
newpat:

;update pointers to in/out patterns------------------------
i_pat_i	=	i_in+ipat*iisz
i_pat_t	=	i_out+ipat*iosz

;----------------------------------------------------------;
;                 F O R W A R D   P A S S                  ;
;----------------------------------------------------------;

;activation of hidden layer
ineu1	=	0
loop2:
inet	=	0
ineu0	=	0
loop3:
io	zir	i_pat_i+ineu0
iw	zir	(i_w)+ineu0*ihsz+ineu1
inet	=	inet+iw*io
ineu0	=	ineu0+1
	if (ineu0<iisz) igoto loop3
ia	=	1/(1+exp(-inet))
	ziw	ia, (i_a)+ineu1
ineu1	=	ineu1+1
	if (ineu1<ihsz) igoto loop2

;activation of output layer
ineu1	=	0
loop4:
inet	=	0
ineu0	=	0
loop5:
io	zir	(i_a)+ineu0
iw	zir	(i_w+iisz*ihsz)+ineu0*iosz+ineu1
inet	=	inet+iw*io
ineu0	=	ineu0+1
	if (ineu0<ihsz) igoto loop5
ia	=	1/(1+exp(-inet))
	ziw	ia, (i_a+ihsz)+ineu1
it	zir	i_pat_t+ineu1
	if (abs(ia-it)<ierng) igoto yes
imiss	=	imiss+1
yes:
ineu1	=	ineu1+1
	if (ineu1<iosz) igoto loop4

;----------------------------------------------------------;
;               B A C K W A R D   P A S S                  ;
;----------------------------------------------------------;

;compute gradient dE/dw, calculating dE/do on the way:
;===============for the output layer=================
ineuk	=	0
loopk0:
it	zir	i_pat_t+ineuk
ia	zir	(i_a+ihsz)+ineuk
idedo	=	-(it-ia)
	ziw	idedo, (i_dedo+ihsz)+ineuk
ineuj	=	0
loopj0:
io	zir	(i_a)+ineuj
idedw	zir	(i_dedw+iisz*ihsz)+ineuj*iosz+ineuk
idedw	=	idedw+idedo*(ia*(1-ia))*io
	ziw	idedw, (i_dedw+iisz*ihsz)+ineuj*iosz+ineuk
ineuj	=	ineuj+1
	if (ineuj<ihsz) igoto loopj0
ineuk	=	ineuk+1
	if (ineuk<iosz) igoto loopk0

;===============for the hidden layer=================
ineui	=	0
loopi:
io	zir	i_pat_i+ineui
ineuj	=	0
loopj:
isoma	=	0
ineuk	=	0
loopk:
idedo	zir	(i_dedo+ihsz)+ineuk
iw	zir	(i_w+iisz*ihsz)+ineuj*iosz+ineuk
ia	zir	(i_a+ihsz)+ineuk
isoma	=	isoma+idedo*(ia*(1-ia))*iw
ineuk	=	ineuk+1
	if (ineuk<iosz) igoto loopk
idedo	=	isoma
	ziw	idedo, (i_dedo)+ineuj
ia	zir	(i_a)+ineuj
idedw	zir	(i_dedw)+ineui*ihsz+ineuj
idedw	=	idedw+idedo*(ia*(1-ia))*io
ineuj	=	ineuj+1
	if (ineuj<ihsz) igoto loopj
ineui	=	ineui+1
	if (ineui<iisz) igoto loopi

ipat	=	ipat+1
	if (ipat<inump) igoto newpat

	if (imiss==0) igoto done

;----------------------------------------------------------;
;            W E I G H T   C O R R E C T I O N             ;
;----------------------------------------------------------;

;weight correction

ilay	=	0

nwlay:
il0sz	=	(ilay==0 ? iisz:ihsz)   ; layer's in size
il1sz	=	(ilay==0 ? ihsz:iosz)   ; layer's out size
iwoff	=	(ilay==0 ? 0:iisz*ihsz) ; offset

ineu0	=	0

nwneu0:
ineu1	=	0

nwneu1:

iw	zir	i_w+iwoff+ineu0*il1sz+ineu1
idedw	zir	i_dedw+iwoff+ineu0*il1sz+ineu1
idedwd	zir	i_dedwd+iwoff+ineu0*il1sz+ineu1
idw	zir	i_dw+iwoff+ineu0*il1sz+ineu1

iprod	=	idedw*idedwd
	if (iprod<=0) igoto nx1
idw	=	idw*ietap
idw	=	(idw>idwmax ? idwmax:idw)
	ziw	idw, i_dw+iwoff+ineu0*il1sz+ineu1
iw	=	iw-(idedw==0 ? 0:idedw/abs(idedw))*idw
	ziw	iw, i_w+iwoff+ineu0*il1sz+ineu1
idedwd	=	idedw
	ziw	idedwd, i_dedwd+iwoff+ineu0*il1sz+ineu1
	igoto skp
nx1:	if (iprod==0) igoto nx2
idw	=	idw*ietam
idw	=	(idw<idwmin ? idwmin:idw)
	ziw	idw, i_dw+iwoff+ineu0*il1sz+ineu1
idedwd	=	0
	ziw	idedwd, i_dedwd+iwoff+ineu0*il1sz+ineu1
	igoto skp
nx2:	
iw	=	iw-(idedw==0 ? 0:idedw/abs(idedw))*idw
	ziw	iw, i_w+iwoff+ineu0*il1sz+ineu1
idedwd	=	idedw
	ziw	idedwd, i_dedwd+iwoff+ineu0*il1sz+ineu1
skp:
ineu1	=	ineu1+1
	if (ineu1<il1sz) igoto nwneu1

ineu0	=	ineu0+1
	if (ineu0<il0sz) igoto nwneu0

ilay	=	ilay+1
	if (ilay<2) igoto nwlay

;new iteration
iter	=	iter+1
	if (iter<imaxit) igoto newitr

;----------------------------------------------------------;
;                     C O N V E R G E                      ;
;----------------------------------------------------------;

done:	;print iter

;calculate response to stimulus pattern
ineu1	=	0
loop6:
inet	=	0
ineu0	=	0
loop7:
io	zir	i_in+inump*iisz+ineu0
iw	zir	(i_w)+ineu0*ihsz+ineu1
inet	=	inet+iw*io
ineu0	=	ineu0+1
	if (ineu0<iisz) igoto loop7
ia	=	1/(1+exp(-inet))
	ziw	ia, (i_a)+ineu1
ineu1	=	ineu1+1
	if (ineu1<ihsz) igoto loop6

;activation of output layer
ineu1	=	0
loop8:
inet	=	0
ineu0	=	0
loop9:
io	zir	(i_a)+ineu0
iw	zir	(i_w+iisz*ihsz)+ineu0*iosz+ineu1
inet	=	inet+iw*io
ineu0	=	ineu0+1
	if (ineu0<ihsz) igoto loop9
ia	=	1/(1+exp(-inet))
	ziw	ia, i_out+inump*iosz+ineu1
ineu1	=	ineu1+1
	if (ineu1<iosz) igoto loop8

	rireturn
;----------------------------------------------------------;
;                  P E R F O R M A N C E                   ;
;----------------------------------------------------------;
perf:
a1	soundin	ipat1
k1	downsamp a1
	if (inump<2) goto skp1

a2	soundin	ipat2
k2	downsamp a2
	if (inump<3) goto skp1

a3	soundin	ipat3
k3	downsamp a3
	if (inump<4) goto skp1

a4	soundin	ipat4
k4	downsamp a4

skp1:as	soundin	ipats
ks	downsamp as

;find maximum and minimum values for all patterns
kmax	=	-32768
kmin	=	+32767
kpat	=	0
loop10:
	if (kpat>0) kgoto skip1
kval	=	k1
	kgoto skip9
skip1:	if (kpat>1) kgoto skip2
kval	=	k2
	kgoto skip9
skip2:	if (kpat>2) kgoto skip3
kval	=	k3
	kgoto skip9
skip3:	if (kpat>3) kgoto skip4
kval	=	k4
	kgoto skip9
skip4:	
kval	=	ks
skip9:	if (kval<=kmax) kgoto next1
kmax	=	kval
next1:	if (kval>=kmin) kgoto next2
kmin	=	kval
next2:
kpat	=	kpat+1
	if (kpat<=inump) kgoto loop10

;if dynamic range is zero, go back to 1st approach
	if (kmax!=kmin) kgoto next3
kmin	=	-32768
kmax	=	+32768

;else scale values using real dynamic range
next3:	zkw	(k1-kmin)/(kmax-kmin), i_in
	zkw	(k1-kmin)/(kmax-kmin), i_out
	if (inump<2) kgoto skp2
	zkw	(k2-kmin)/(kmax-kmin), i_in+1
	zkw	(k2-kmin)/(kmax-kmin), i_out+1
	if (inump<3) kgoto skp2
	zkw	(k3-kmin)/(kmax-kmin), i_in+2
	zkw	(k3-kmin)/(kmax-kmin), i_out+2
	if (inump<4) kgoto skp2
	zkw	(k4-kmin)/(kmax-kmin), i_in+3
	zkw	(k4-kmin)/(kmax-kmin), i_out+3

skp2:	zkw	(ks-kmin)/(kmax-kmin), i_in+inump

;-----------------------------------------
	reinit neural
;-----------------------------------------

kval	zkr	i_out+inump

;apply moving average
kwin	init	0
kwin	=	(kwin<iavrw ? kwin+1:kwin)
kndx	=	1
ksum	=	kval
loppa:
kval0	table	kndx, iavrt
	tablew	kval0, kndx-1, iavrt
ksum	=	ksum+kval0
kndx	=	kndx+1
	if (kndx<iavrw) kgoto loppa
	tablew	kval, iavrw-1, iavrt
kresp	=	(ksum/kwin)*(kmax-kmin)+kmin
aresp	interp	kresp                 ;audio response

	out	aresp

	endin
