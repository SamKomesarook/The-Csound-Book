f1	0 	4096 	10 	1					; SINE
f2  	0 	2048 	1  	"BellFunc.float" 0 6 0	; BELLFUNCTION
f3  	0 	512 	5  	1 512 .0009765625			; EXPON CURVE - ENDLESS GLISS DN
f4	0 	512  	7  	1 512 0 				; DIAGONAL LINE (TOP LEFT - BOTTOM RIGHT)
f5	0 	512  	7  	0 512 1				; DIAGONAL LINE (TOP RIGHT - BOTTOM LEFT)
f6	0 	512  	5  	.001 512 1			; EXPON CURVE (ENDING @ TOP RIGHT)
f7	0	 512  	5  	1 512 .001			; EXPON CURVE (SRT @ TOP LEFT)
f8	0 	512  	7  	1 128 0 128 1 128 .5 128	; ODD SHAPE 
f9	0 	512  	20 	6					; HANNING
f10 	0 	512 	5  	.0009765625 512 1 			; EXPON CURVE - ENDLESS GLISS UP

;i1 		= 	grain gliss
;i2 		= 	single grain = pan
;i3 		= 	single grain 'line'
;i4 		= 	single grain 'expon'
;i5 		= 	single grain 'linen'
;i6 		= 	single grain 'amp oscil'
;i7 		= 	single grain 'freq oscil'
;i8 		= 	single grain 'linseg'
;i9 		= 	Risset's endless gliss down
;i10		= 	single gliss down
;i11		= 	single gliss up
;i12		= 	Risset's endless gliss up
;i13		= 	Risset's endless/grain gliss up/down
;i99		= 	reverb

;instr	strt		dur		rvbtime	hfdif
i99		0		240	 	.5		.1

;		str		dur		amp		rvb		pan
i9		0		33		72		.1		.5
i3		15		8.5		75		.1		.001
i4		15		20		75		.1		1
i12		26		35		70		.3		.5
i3		28		10.5		75		.1		1
i7		37		15		77		.1		.001
i6		45		3		67		.8		1
i9		45		15		69		.35		.5
i6		48		3		67		.8		.001
i4		55		20		75		.5		.001
i6		60		1		71		.3		.001
i6		61.5		1		71		.3		1
i6		64		3.5		68		.6		.5
i6		72		.5		68		.3		.001
i6		72.5		.5		68		.3		1
i6		74		1.5		66		.9		.5
i12		75		35		75		.4		.5
i4		80		20		67		.7		1
i3		90		17		80		.5		.001
i5		100		34		83		.3		.5
i13		110		90		76		.2		.5
i13		120		80		70		.7		.5
e

;total rendering time 185.3 sec on G3
