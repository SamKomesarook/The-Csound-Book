;=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=;
;=     A Reality Check on Neural Nets in General, and      =;
;=             RProp Training in Particular                =;
;=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=;
;=             Coded by Pedro Batista, 1998                =;
;=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=;
;  What can be customized :
;  ======================
;  1) The number of patterns (inump); processing time is 
;     directly proportional to this number, and so is the
;     number of iterations needed to convergence
;  2) The number of discrete values used (istps); binary 
;     neurons take 2 steps, but we may want neurons that 
;     accept a wider range of values; in practice this
;     works as a precision factor (best range: 2 .. 5)
;  3) The input (iisz), hidden (ihsz), and output (iosz)
;     layer's dimension; this should be as small as possible
;     for the task at hand
;  4) The RProp parameters, although seldom changing this 
;     is needed, or plays a determining role
;=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=;
;  What will be concluded :
;  ======================
;  Two very important things can be determined using this 
;  program and under its constraints: what will the minimum
;  network topology, and what average iterations we should
;  expect. This is highly dependent on the neuron's 
;  resolution (number of steps) and the number of patterns
;=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=;

sr      =       44100
kr      =       441
ksmps   =       100

	zakinit	1, 4000       ; * * THIS MUST BE UPDATED * *
		             ;      (see arrays below)
;----------------------------------------------------------;
	instr   1
;----------------------------------------------------------;

;*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*
;Coding Parameters            * * YOU MAY CHANGE THIS * *

inump   =       5        ; number of patterns
istps	=	4        ; number of steps for each value
iisz    =       1        ; size of input
ihsz    =       16       ; size of hidden layer
iosz    =       iisz     ; size of output layer (should
		         ; equal input size, in this case)
imaxtry	=	100      ; number of attempts, for 
                         ; statistical results
imaxit	=	10000    ; maximum number of iterations:
		         ; if you reach this value, things 
                         ; arent going very well...

; These flags control display: 1=show, 0=dont show)
ishow0	=	0   ; display random patterns
ishow1	=	0   ; display error evolution
ishow2	=	0   ; display iter num, every nth iteration
itern	=	100 ; ...(every 100th iteration)
;*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*.*
		               ;Error range:
ierng	=	.99/istps/2    ;slightly smaller than half
		               ;...the step size
;RProp parameters
idw0    =       .1       ; initial dw
idwmin  =       .00001   ; minimum dw
idwmax  =       10       ; maximum dw
ietam   =       .5       ; eta minus
ietap   =       1.2      ; eta plus

;array definitions
i_a     =       1                           ; start of activation array
i_w     =       i_a+ihsz+iosz               ; start of weight array
i_dw    =       i_w+iisz*ihsz+ihsz*iosz     ; start of weight change array
i_dedo  =       i_dw+iisz*ihsz+ihsz*iosz    ; start of dE/do array
i_dedw  =       i_dedo+ihsz+iosz            ; start of dE/dw array
i_dedwd =       i_dedw+iisz*ihsz+ihsz*iosz  ; start of delayed dE/dw array
i_in    =       i_dedwd+iisz*ihsz+ihsz*iosz ; start of input area
i_out   =       i_in+iisz*inump             ; start of output area
i_end   =       i_out+iosz*inump

;	print	i_end                       ; uncomment this line to know
                                            ; exact size of zak space
;statistics
itotal	=	0
itrials	=	0

rstrt:

;initializations-------------------------------------------

;pattern constrution (assumed iisz==iosz)
ipat	=	0
l1:
indx	=	0
l2:
ival	=	int(rnd(istps-1))
ibit	=	ival*(1/istps)
	if (ishow0==0) igoto sk0
	print	ipat, indx, ival, ibit
sk0:	ziw	ibit, i_in+ipat*iisz+indx
	ziw	ibit, i_out+ipat*iosz+indx
indx	=	indx+1
	if (indx<iisz) igoto l2
ipat	=	ipat+1
	if (ipat<inump) igoto l1

;weight arrays initialization
indx    =       0
loop1:
ival    =       (rnd(200)/100)-1
	ziw     ival, i_w+indx
	ziw     idw0, i_dw+indx
	ziw     0, i_dedwd+indx
indx    =       indx+1
	if (indx<iisz*ihsz+ihsz*iosz) igoto loop1

;main loop-------------------------------------------------
iter    =       0
newitr:

;----------------------------------------------------------
;zero combined error array, dE/dw
indx	=	0
loop100:
	ziw     0, i_dedw+indx
indx  =       indx+1
	if (indx<iisz*ihsz+ihsz*iosz) igoto loop100
;----------------------------------------------------------
ipat    =       0
imiss   =       0
newpat:

;update pointers to in/out patterns------------------------
i_pat_i =       i_in+ipat*iisz
i_pat_t =       i_out+ipat*iisz

;----------------------------------------------------------;
;                 F O R W A R D   P A S S                  ;
;----------------------------------------------------------;

;activation of hidden layer
ineu1   =       0
loop2:
inet    =       0
ineu0   =       0
loop3:
io      zir     i_pat_i+ineu0
iw      zir     (i_w)+ineu0*ihsz+ineu1
inet    =       inet+iw*io
ineu0   =       ineu0+1
	if (ineu0<iisz) igoto loop3
ia      =       1/(1+exp(-inet))
	ziw     ia, (i_a)+ineu1
ineu1   =       ineu1+1
	if (ineu1<ihsz) igoto loop2

;activation of output layer
ineu1   =       0
loop4:
inet    =       0
ineu0   =       0
loop5:
io      zir     (i_a)+ineu0
iw      zir     (i_w+iisz*ihsz)+ineu0*iosz+ineu1
inet    =       inet+iw*io
ineu0   =       ineu0+1
	if (ineu0<ihsz) igoto loop5
ia      =       1/(1+exp(-inet))
	ziw     ia, (i_a+ihsz)+ineu1
it      zir     i_pat_t+ineu1
	if (abs(ia-it)<ierng) igoto yes
imiss	=	imiss+1
yes:
ineu1   =       ineu1+1
	if (ineu1<iosz) igoto loop4

;----------------------------------------------------------;
;               B A C K W A R D   P A S S                  ;
;----------------------------------------------------------;

;compute gradient dE/dw, calculating dE/do on the way:
;===============for the output layer=================
ineuk   =       0
loopk0:
it      zir     i_pat_t+ineuk
ia      zir     (i_a+ihsz)+ineuk
idedo   =       -(it-ia)
	ziw     idedo, (i_dedo+ihsz)+ineuk
ineuj   =       0
loopj0:
io      zir     (i_a)+ineuj
idedw   zir     (i_dedw+iisz*ihsz)+ineuj*iosz+ineuk
idedw   =       idedw+idedo*(ia*(1-ia))*io
	ziw     idedw, (i_dedw+iisz*ihsz)+ineuj*iosz+ineuk
ineuj   =       ineuj+1
	if (ineuj<ihsz) igoto loopj0
ineuk   =       ineuk+1
	if (ineuk<iosz) igoto loopk0

;===============for the hidden layer=================
ineui   =       0
loopi:
io      zir     i_pat_i+ineui
ineuj   =       0
loopj:
isoma   =       0
ineuk   =       0
loopk:
idedo   zir     (i_dedo+ihsz)+ineuk
iw      zir     (i_w+iisz*ihsz)+ineuj*iosz+ineuk
ia      zir     (i_a+ihsz)+ineuk
isoma   =       isoma+idedo*(ia*(1-ia))*iw
ineuk   =       ineuk+1
	if (ineuk<iosz) igoto loopk
idedo   =       isoma
	ziw     idedo, (i_dedo)+ineuj
ia      zir     (i_a)+ineuj
idedw   zir     (i_dedw)+ineui*ihsz+ineuj
idedw   =       idedw+idedo*(ia*(1-ia))*io
ineuj   =       ineuj+1
	if (ineuj<ihsz) igoto loopj
ineui   =       ineui+1
	if (ineui<iisz) igoto loopi

ipat    =       ipat+1
	if (ipat<inump) igoto newpat

;=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=
;print error for this iteration
;
;   itoterr = total error for all weights, 
;             over all patterns
;   imiss   = number of missed bits, over
;             all patterns
;
	if (ishow1==0) igoto sk1
itoterr	=	0
ii	=	0
z1:
idedw	zir	i_dedw+ii
itoterr	=	itoterr+idedw
ii	=	ii+1
	if (ii<ihsz*(iisz+iosz)) igoto z1
	print iter, itoterr, imiss
	igoto sk2
sk1:	if (ishow2==0) igoto sk2
	if (frac(iter/itern)!=0) igoto sk2
	print iter
sk2:
;=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=

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
iter    =       iter+1
	if (iter<imaxit) igoto newitr

;----------------------------------------------------------;
;                     C O N V E R G E                      ;
;----------------------------------------------------------;

done:

itrials	=	itrials+1
itotal	=	itotal+iter
iavrg	=	itotal/itrials

print	iter, iavrg

	if (itrials<imaxtry) igoto rstrt

	endin

