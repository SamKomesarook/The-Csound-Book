;=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=;
;    Testing the back-prop algo, with the XOR problem     ;
;                 by Pedro Batista, '98                   ;
;=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=;

sr	=	44100
kr	=	441
ksmps	=	100

;=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=;
	instr	1
;=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=;

ieta	=	.25      ;training coeficient
inump	=	4        ;number of patterns
imaxit	=	50000    ;maximum number of iterations

;=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=;
;The network structure
;
;   |i1|----(a1_1)
;       \  /      \
;        \/        \(a2_1)--|o1|
;        /\        /
;       /  \      /
;   |i2|----(a1_2)
;
;The connections on the input of cells a1_1 and a1_2
;have weights w1_11 (from i1 to a1_1), w1_12 (from i1
;to a1_2), w1_21 (from i2 to a1_1) and w1_22 (from i2
;to a1_2)
;
;The connections on the input of cell a2_1 have weights
;w2_11 (from a1_1 to a2_1) and w2_21 (from a1_2 to a2_1)
;
;The input pattern is placed in cells i1 and i2
;
;The target (desired output) pattern is placed in cell o1
;=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=;

;the activation array
i_a1_1  =	0
i_a1_2	=	0
i_a2_1	=	0

;the delta array
i_d1_1  =	0
i_d1_2	=	0
i_d2_1	=	0

;the weight array (initialized with random values)
i_w1_11	=	(rnd(99)+1)/100
i_w1_12	=	(rnd(99)+1)/100
i_w1_21	=	(rnd(99)+1)/100
i_w1_22	=	(rnd(99)+1)/100
i_w2_11	=	(rnd(99)+1)/100
i_w2_21	=	(rnd(99)+1)/100

;the input array
i_i1	=	0
i_i2	=	0

;the output array
i_o1	=	0

;=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=;
;iteration loop
iter	=	0
newitr:

ihit	=	1

ipat	=	0
newpat:

;load input/output patterns
	if (ipat>0) igoto skp0
i_i1	=	0
i_i2	=	0
i_o1	=	0
	igoto	skp3
skp0:
	if (ipat>1) igoto skp1
i_i1	=	0
i_i2	=	1
i_o1	=	1
	igoto	skp3
skp1:
	if (ipat>2) igoto skp2
i_i1	=	1
i_i2	=	0
i_o1	=	1
	igoto	skp3
skp2:
	if (ipat>3) igoto skp3
i_i1	=	1
i_i2	=	1
i_o1	=	0
skp3:
	
;=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=;
;propagate input

;activation of neuron 1 from layer 1
inet	=	i_i1*i_w1_11+i_i2*i_w1_21
i_a1_1	=	1/(1+exp(-inet))
;activation of neuron 2 from layer 1
inet	=	i_i1*i_w1_12+i_i2*i_w1_22
i_a1_2	=	1/(1+exp(-inet))
;activation of neuron 1 from layer 2
inet	=	i_a1_1*i_w2_11+i_a1_2*i_w2_21
i_a2_1	=	1/(1+exp(-inet))

;=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=;
;print output of the net

itims	=	100; every 100 times
if (frac(iter/itims)!=0) igoto prskp
print iter, ipat, i_i1, i_i2, i_a2_1
prskp:

;check if output within range

irange	=	.4
idst	=	abs(i_a2_1-i_o1)
if (idst<irange) igoto yes
ihit	=	0; no
yes:

if (ipat<3) igoto  sk1
if (ihit==1) igoto done
sk1:


;=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=;
;error signal determination

;find delta for output layer

i_d2_1	=       (i_o1-i_a2_1)*(i_a2_1*(1-i_a2_1))

;find delta for hidden layer

;delta for cell 1
ibp	=	i_d2_1*i_w2_11
i_d1_1	=	ibp*(i_a1_1*(1-i_a1_1))
;delta for cell 2
ibp	=	i_d2_1*i_w2_21
i_d1_2	=	ibp*(i_a1_2*(1-i_a1_2))

;=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=;
;weight correction

;layer 1 connections
i_w1_11	=	i_w1_11+ieta*i_d1_1*i_i1
i_w1_12	=	i_w1_12+ieta*i_d1_2*i_i1
i_w1_21	=	i_w1_21+ieta*i_d1_1*i_i2
i_w1_22	=	i_w1_22+ieta*i_d1_2*i_i2
;layer 2 connections
i_w2_11	=	i_w2_11+ieta*i_d2_1*i_a1_1
i_w2_21	=	i_w2_21+ieta*i_d2_1*i_a1_2

ipat	=	ipat+1
	if (ipat<inump) igoto newpat

iter	=	iter+1
	if (iter<imaxit) igoto newitr

;=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=;
done:

;print down results
print iter
print i_w1_11
print i_w1_12
print i_w1_21
print i_w1_22
print i_w2_11
print i_w2_21

	endin


