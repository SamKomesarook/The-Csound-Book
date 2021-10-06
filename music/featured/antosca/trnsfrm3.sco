; TRANSFORM3.SCO

f1 0 2048 10 1										; Sine
f2 0 2048 10 1 .5 .3 .25 .2 .167 .14 .125 .111			; Sawtooth
f3 0 2048 10 1 0  .3	0   .2	0  .14	0   .111		; Square
f4 0 2048 10 1 1 1 1 .7 .5 .3 .1 						; Pulse

;p1		p2		p3		p4		p5		p6		p7		p8		p9		p10		p11		p12		p13
;------------------------------------------------------------------------------------------------------
;instr	strt	dur		amp		frq		atk		rel		vbrt	vbdp	vbdl	initwv	endwv	xfdtm
;------------------------------------------------------------------------------------------------------
i1		0		16 		60		8.2		.75		2		.2 		3		.5		4		3		2.5
i1		14.5	17		>		8.165	1		2.5		1 		4		.75		1		4		4
i1		29		13		>		8.2		2.5		1.5 	2		5		.85		2		1		3
i1		34		10		66		8.245	1.5		3 		4		7		.99		2		4		6

;p1		p2		p3		p4
;------------------------------------------------------
;instr	strt	dur		rvbtm
;------------------------------------------------------
i99	0	44	8
i99	14.5	29.5	8
i99	29	15	8
i99	33	11	8
e