
t 0.00	135.00	/* tempo */

i 90	0.0000	12.000		/* output instrument */

i 1	0.0000	0.4000	33	127
i 1	1.0000	0.4000	33	127
i 1	2.0000	0.4000	33	127
i 1	3.0000	0.4000	33	127
i 1	4.0000	0.4000	33	127
i 1	5.0000	0.4000	33	127
i 1	6.0000	0.4000	33	127
i 1	7.0000	0.4000	33	127

/* ------------------------------------------------------------------------- */

f 40 0 32 -2	1000.0		/* volume				*/
		135		/* tempo				*/

		0.05		/* release time				*/

		5.3333		/* start frequency 1			*/
		20		/* freq. decay speed 1			*/
		0.5		/* start frequency 2			*/
		256		/* freq. decay speed 2			*/

		0.0		/* noise bandwidth offset (Hz)		*/
		0.25		/* noise bandwidth / osc. frequency	*/

		4.0		/* LP filter start frq. / osc. freq.	*/
		4.0		/* LP filter freq. decay speed		*/

		16.0		/* amp. envelope 1 start value		*/
		1024		/* amp. envelope 1 decay speed		*/
		1.0		/* amp. envelope 2 start value		*/
		4		/* amp. envelope 2 decay speed		*/

/* ------------------------------------------------------------------------- */

f 64 0 16 -2	24576		/* output gain				*/
		4.0		/* 1. max. level	limiter 1	*/
		0.02		/* 1. delay time			*/
		0.01		/* 1. decay speed (0..1)		*/
		0.0001		/* 1. attack speed			*/
		25		/* 1. LP filter freq.			*/
		1.0		/* 2. max. level	limiter	2	*/
		0.0025		/* 2. delay time			*/
		0.5		/* 2. decay speed (0..1)		*/
		0.0025		/* 2. attack speed			*/
		200		/* 2. LP filter freq.			*/

/* ------------------------------------------------------------------------- */

e	/* end of score */


