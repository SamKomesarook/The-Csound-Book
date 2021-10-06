;=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-;
;              A neural instrument skeleton,               ;
;              to be used with generic data                ;
;                                                          ;
;              Coded by Pedro Batista, 1998                ;
;=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-;

sr	=	44100
kr	=	4410
ksmps	=	10

	zakinit	1, 335 ; * * UPDATE * *

;----------------------------------------------------------;
	instr	1
;----------------------------------------------------------;

;* * UPDATE * * UPDATE * * UPDATE * * UPDATE * * UPDATE * *;
; In this section you define the network topology, as well
; as the data set size, and the expected precision

inump	=	5        ; number of patterns
istps	=	8        ; number of steps for each value
iisz	=	1        ; size of input
ihsz	=	32       ; size of hidden layer
iosz	=	1        ; size of output layer
;* * UPDATE * * UPDATE * * UPDATE * * UPDATE * * UPDATE * *;

ierng	=	.99/istps/2

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

;Uncomment this line to know exact needed size for zak space
;	print	i_end                      

	igoto	perf
neural:

;weight initializations------------------------------------
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

;new iteration---------------------------------------------
iter	=	iter+1
	if (iter<imaxit) igoto newitr

;----------------------------------------------------------;
;                     C O N V E R G E                      ;
;----------------------------------------------------------;

done:	

;while testing the instrument, you may uncomment the 
;following print, to keep track of average number of
;iterations needed. If you start seeing high values 
;then the instrument is not running efficiently

;	print iter

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

;* * ENCODING * * ENCODING * * ENCODING * * ENCODING * *
;Here, you must gather the data from whatever the training
;material will be, and encode it appropriately, to the range
;0.0 to 1.0 (or maybe -x to +x, with a small x)
;This could mean opening a soundfile, extracting some 
;values, and scaling them down to the 0.0 to 1.0 range

;* * WRITING * * WRITING * * WRITING * * WRITING * *
;Here you must write the encoded patterns to the input and
;output arrays in zak space. The input patterns start being
;written at position i_in, while output patterns start at
;position i_out.
;The stimulus pattern (to test the net) is
;placed in the input area, after all the training patterns,
;thus it starts at position i_in+inump*iisz

;----------------------------------------------------------;
	reinit	neural
;----------------------------------------------------------;

;* * READING * * READING * * READING * * READING * *
;Since at this point, the net has been trained, and the
;response from the stimulus pattern has been calculated,
;all you have to do is read the response pattern from its
;position, after all output patterns, thus starting at 
;position i_out+inump*iosz

;* * DECODING * * DECODING * * DECODING * * DECODING * *
;And then perform the reverse of the encoding method, 
;restoring the net value to the original range, and, 
;if it was an audio value, outputing it

	endin
