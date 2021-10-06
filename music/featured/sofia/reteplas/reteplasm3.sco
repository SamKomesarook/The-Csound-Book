;Reteplas.sco /Third Movement

;========================================================================;
;Reteplas Microtonality Composition by Sal Sofia (c)1997                 ;
;========================================================================;
   
	; Sine Wave 
f1 0 1024 9 1 1 0 1 1 .05

	; ADSR Trumpet Envelope 
f2 0 513 7 0 85.33 1 85.33 .75 85.33 .65 170.66 .50 85.33 0

	; Exponential decaying envelope for bell-like timbres 
f5 0 513 5 1 12 1024 500 1 ;percussive

	  
;========================================================================;
;inst st dur amp carFreq modFreq Index1 Index2 CarEG ModEg Attack        ;
;========================================================================;
;=======================< instr.8,9,10,11,12 >===========================;
;========================================================================;

t0 70

;Measure 1, time sig.2/4.  
i8 2 2 5000 110.00  55.00 .1 5 2 2 0.009 ;alleluia; 
i. + . 6000 147.45  73.70 .1 5 2 2 0.009  
i. . . 4000 147.45  73.70 .1 5 2 2 0.009  
i. . 4 6000 122.10  61.05 .1 5 2 2 0.009 

;M.2, Tsig.4/4.  
i12 4 1 7000 147.45  73.70 0 0 5 2 0.009  
i. + .  <    187.00  93.50 0 0 5 2 0.009  
i. . .  <    136.40  68.20 0 0 5 2 0.009  
i. . .  7500 110.00  55.00 0 0 5 2 0.009  

;M.3, Tsig. 4/4.
i10 8 .5714 5500 147.40  73.70 0 0 5 2 0.009  ;laudate; 
i. + .5714 <     110.00  55.00 0 0 5 2 0.009  
i. . .5714 <     187.00  93.50 0 0 5 2 0.009  
i. . .5714 <     118.80  59.40 0 0 5 2 0.009  
i. . .5714 <     220.00 110.00 0 0 5 2 0.009  
i. . .5714 <     182.60  91.30 0 0 5 2 0.009  
i. . .5714  7500 122.10  61.05 0 0 5 2 0.009  

;M.4, Tsig. 4/4.        
i10 12 .2857 6000 118.80  59.40 0 0 5 2 0.009  ;dominum; 
i. +  .2857  <     79.75  79.75 0 0 5 2 0.009  
i. .  .2857  <    151.80  75.90 0 0 5 2 0.009  
i. .  .2857  6500  68.20  68.20 0 0 5 2 0.009  
i. .  .2857  <    155.10  77.55 0 0 5 2 0.009  
i. .  .2857  7000 187.00  93.50 0 0 5 2 0.009  
i. .  .2857  <     75.90  75.90 0 0 5 2 0.009  
i. 14 .75     8700 68.20  68.20 0 0 5 2 0.009  ;in; 
i. + 1.25    10000 77.55  77.55 0 0 5 2 0.009 
 
;M.5, Tsig. 4/4. 
i8 16 .1429  4000  89.10  89.10 0 5 2 2 0.009  ;sanctis; 
i. +  .1429 <     110.00  55.00 0 5 2 2 0.009  
i. .  .1429 <     155.10  77.55 0 5 2 2 0.009  
i. .  .1429 <     231.00 115.50 0 5 2 2 0.009  
i. .  .1429 <     182.60  91.30 0 5 2 2 0.009  
i. .  .1429 <     136.40  68.20 0 5 2 2 0.009  
i. .  .1429  9000 178.20  89.10 0 5 2 2 0.009 
i8 17 .75    8000 122.10  61.05 0 5 2 2 0.009  ;eius;
i. +  .75   <     136.40  68.20 0 5 2 2 0.009  
i. .  .75   <      93.50  93.50 0 5 2 2 0.009  
i. .  .75    9000  89.10  89.10 0 5 2 2 0.009
;M.5, Tsig. 4/4  
i8 16 .1429  4000  92.10  92.10 0 5 2 2 0.009   
i. +  .1429 <     113.00  58.00 0 5 2 2 0.009  
i. .  .1429 <     158.10  80.55 0 5 2 2 0.009  
i. .  .1429 <     234.00 118.50 0 5 2 2 0.009  
i. .  .1429 <     185.60  94.30 0 5 2 2 0.009  
i. .  .1429 <     139.40  71.20 0 5 2 2 0.009  
i. .  .1429  9000 181.20  92.10 0 5 2 2 0.009 
i10 17 .75    8000 125.10  64.05 0 0 5 2 0.009   
i. +  .75   <     139.40  71.20 0 0 5 2 0.009  
i. .  .75   <      96.50  96.50 0 0 5 2 0.009  
i. .  .75    9000  92.10  92.10 0 0 5 2 0.009  
i10 17 .75    8000 122.10  61.05 0 0 5 2 0.009   
i10 +  .75   <     136.40  68.20 0 0 5 2 0.009  
i. .  .75   <      93.50  93.50 0 0 5 2 0.009  
i. .  .75    9000  89.10  89.10 0 0 5 2 0.009  

;M.6, Tsig. 4/4. 
i8 20 .2857  5000 294.80 147.40 .1 5 2 2 0.009  ;laudate; 
i. +  .2857 <     220.00 110.00 .1 5 2 2 0.009  
i. .  .2857 <     374.00 187.00 .1 5 2 2 0.009  
i. .  .2857  7000 237.60 118.80 .1 5 2 2 0.009  
i. .  .2857  5000 220.00 110.00 .1 5 2 2 0.009  
i. .  .2857 <     182.60  91.30 .1 5 2 2 0.009  
i. .  .2857 <     244.20 122.10 .1 5 2 2 0.009  
i8 22 .3333  7000 244.20 122.10 .1 5 2 2 0.009  ;eum;
i. +  .3333 .     187.00  93.50 .1 5 2 2 0.009  
i. .  .3333 .     151.80  75.90 .1 5 2 2 0.009  
i8 23 .5    .     136.40  68.20 .1 5 2 2 0.009  ;in; 
i. +  .5     5500 155.10  77.55 .1 5 2 2 0.009  
;M.6, Tsig. 4/4.    
i10 20 .2857 5000 592.60 297.80 .1 5 2 2 0.009   
i. +  .2857 .     443.00 223.00 .1 5 2 2 0.009  
i. .  .2857 .     751.00 377.00 .1 5 2 2 0.009  
i. .  .2857  7000 478.20 240.60 .1 5 2 2 0.009  
i. .  .2857  5000 443.00 223.00 .1 5 2 2 0.009  
i. .  .2857 .     368.20 185.60 .1 5 2 2 0.009  
i. .  .2857 .     491.40 247.20 .1 5 2 2 0.009  
i10 22 .3333 5500 491.40 247.20 .1 5 2 2 0.009  
i. +  .3333 .     377.00 190.00 .1 5 2 2 0.009  
i. .  .3333 .     306.60 154.80 .1 5 2 2 0.009  
i10 23 .5    <    275.80 139.40 .1 5 2 2 0.009   
i. +  .5     6000 313.20 158.10 .1 5 2 2 0.009  

;M.7, Tsig. 4/4. 
i8 24 .4  6000  125.40  62.70 .1 5 2 2 0.009  ;firmamento; 
i. +  .4 <      136.40  68.20 .1 5 2 2 0.009  
i. .  .4 <      172.70  86.35 .1 5 2 2 0.009  
i. .  .4 <      151.80  75.90 .1 5 2 2 0.009  
i. .  .4  7000  110.00  55.00 .1 5 2 2 0.009  
i9 26 .2  6000  151.80  75.90 0 0 5 2 0.009  
i. +  .2 <      244.20 122.10 0 0 5 2 0.009  
i. .  .2 <      155.10  77.55 0 0 5 2 0.009  
i. .  .2 <      365.20 182.60 0 0 5 2 0.009  
i. .  .2  7000  159.50  79.75 0 0 5 2 0.009 
i. 27 1   4000  385.00 192.50 0 0 5 2 0.009  ;virtutis; 
i12 27 .1 6000  303.60 151.80 0 0 5 2 0.009  
i. +  .1 <      488.40 244.20 0 0 5 2 0.009  
i. .  .1 <      310.20 155.10 0 0 5 2 0.009  
i. .  .1 <      730.40 365.20 0 0 5 2 0.009  
i. .  .1  9000  319.00 159.50 0 0 5 2 0.009
i. .  .1  6000  306.60 154.80 0 0 5 2 0.009  
i. .  .1 <      451.40 247.20 0 0 5 2 0.009  
i. .  .1 <      313.20 158.10 0 0 5 2 0.009  
i. .  .1 <      733.40 368.20 0 0 5 2 0.009  
i. .  .1  9000  322.00 162.50 0 0 5 2 0.009

;M.8, Tsig. 4/4. 
i10 28      1     5000  272.80 136.40 0 0 5 2 0.009
i12 28.083  .1667 3600  692.91 346.45 0 0 5 2 0.009  
i. 28.16    .1667 5000  879.99 439.99 0 0 5 2 0.009  
i. 28.24    .1667 6000 1117.58 558.79 0 0 5 2 0.009    
i10 29      1     4000  172.70  86.35 0 0 5 2 0.009
i12 29.083  .1667 4000  438.65 219.32 0 0 5 2 0.009  
i. 29.16    .1667 5000  557.09 278.54 0 0 5 2 0.009  
i. 29.24    .1667 6000  707.51 353.75 0 0 5 2 0.009  
i10 30      1     4000  182.60  91.30 0 0 5 2 0.009
i12 30.083  .1667 4000  463.80 231.90 0 0 5 2 0.009  
i. 30.16    .1667 5000  589.02 294.51 0 0 5 2 0.009  
i. 30.24    .1667 6000  744.24 372.12 0 0 5 2 0.009  
i10 31      .25   6000  374.00 187.00 0 0 5 2 0.009
i10 +       .25   6750  182.60  91.30 0 0 5 2 0.009  
i10 .       .25   7050  136.40  68.20 0 0 5 2 0.009  
i10 .       .25   7800   89.10  89.10 0 0 5 2 0.009 
;M.8, Tsig. 4/4. 
i10 28      1     5000  272.80 136.40 0 0 5 2 0.009
i12 28.083  .1667 2000  692.91 346.45 0 0 5 2 0.009  
i. 28.16    .1667 5000  879.99 439.99 0 0 5 2 0.009  
i. 28.24    .1667 6000 1117.58 558.79 0 0 5 2 0.009    
i10 29      1     4250  172.70  86.35 0 0 5 2 0.009
i12 29.083  .1667 4000  438.65 219.32 0 0 5 2 0.009  
i. 29.16    .1667 5000  557.09 278.54 0 0 5 2 0.009  
i. 29.24    .1667 6000  707.51 353.75 0 0 5 2 0.009  
i10 30      1     4000  182.60  91.30 0 0 5 2 0.009
i12 30.083  .1667 4000  463.80 231.90 0 0 5 2 0.009  
i. 30.16    .1667 5000  589.02 294.51 0 0 5 2 0.009  
i. 30.24    .1667 6000  744.24 372.12 0 0 5 2 0.009  
i10 31      .25   4250  374.00 187.00 0 0 5 2 0.009
i10 +       .25   6750  182.60  91.30 0 0 5 2 0.009  
i10 .       .25   5750  136.40  68.20 0 0 5 2 0.009  
i10 .       .25   6000   89.10  89.10 0 0 5 2 0.009 
;M.8, Tsig. 4/4. 
i10 28   1   6000  272.80 136.40 0 0 5 2 0.009  
i. +     1  .      172.70  86.35 0 0 5 2 0.009  
i. .     1  .      182.60  91.30 0 0 5 2 0.009  
i12 31  .25  6000  374.00 187.00 0 0 5 2 0.009  
i. +    .25 .      182.60  91.30 0 0 5 2 0.009  
i. .    .25 .      136.40  68.20 0 0 5 2 0.009  
i. .    .25  8500   89.10  89.10 0 0 5 2 0.009 

;M.9, Tsig. 4/4. 
i8 32 .75  6000 122.10  61.05 .1 5 2 2 0.009  ;eius; 
i. +  .75 <     136.40  68.20 .1 5 2 2 0.009  
i. .  .75 <     187.00  93.50 .1 5 2 2 0.009  
i. . 1.75  7000  89.10  89.10 .1 5 2 2 0.009
;M.9, Tsig. 4/4. 
i10 32 .75  6000 122.10  61.05 0 0 5 2 0.009   
i.  +  .75 <     136.40  68.20 0 0 5 2 0.009  
i.  .  .75 <     187.00  93.50 0 0 5 2 0.009  
i.  . 1.75  7000  89.10  89.10 0 0 5 2 0.009

;M.10, Tsig. 4/4.   
i9 36 2  5000  589.60 294.80 0 0 5 2 0.009   
i. .  .  5000  880.00 440.00 0 0 5 2 0.009  
i. .  .  5000  748.00 374.00 0 0 5 2 0.009  
i. .  .  5000  950.40 475.20 0 0 5 2 0.009  
i. .  .  5350  440.00 220.00 0 0 5 2 0.009  
i. .  .  5500  365.20 182.60 0 0 5 2 0.009  
i. .  .  5000  488.40 244.20 0 0 5 2 0.009  
i. 38 1  5000  488.40 244.20 0 0 5 2 0.009  
i. .  .  5500  748.00 374.00 0 0 5 2 0.009  
i. .  .  6000 1214.40 607.20 0 0 5 2 0.009  
i. 39 1  5000 1091.20 545.60 0 0 5 2 0.009  
i. .  .  5000 1240.80 620.40 0 0 5 2 0.009 
;M.10, Tsig. 4/4. 
i10 36 .2857  5500 589.60 294.80 0 0 5 2 0.009  ;laudate;
i.  +  .2857 <     880.00 440.00 0 0 5 2 0.009  
i.  .  .2857 <     748.00 374.00 0 0 5 2 0.009  
i.  .  .2857 <     950.40 475.20 0 0 5 2 0.009  
i.  .  .2857 <     440.00 220.00 0 0 5 2 0.009  
i.  .  .2857 <     365.20 182.60 0 0 5 2 0.009  
i.  .  .2857  7500 488.40 244.20 0 0 5 2 0.009  
i.  38 .3333  6000 488.40 244.20 0 0 5 2 0.009 ;eum; 
i.  +  .3333 <     748.00 374.00 0 0 5 2 0.009  
i.  .  .3333 <    1214.40 607.20 0 0 5 2 0.009  
i.  39 .75   <    1091.20 545.60 0 0 5 2 0.009 ;in; 
i.  +  .5    7500 1240.80 620.40 0 0 5 2 0.009 

;M.11, Tsig. 5/4.
i9 40  5  6000 1240.80 620.40 0 0 5 2 0.009
i. .  .   5000  770.00 385.00 0 0 5 2 0.009 ;virtutibus; 
i. .   .  6000  545.60 272.80 0 0 5 2 0.009  
i. .   .  5000  690.80 345.40 0 0 5 2 0.009  
i. .   .  5000  365.20 182.60 0 0 5 2 0.009  
i. .   .  6500  748.00 374.00 0 0 5 2 0.009  
;M.11, Tsig. 5/4.
i12 40 .5   7000 1240.80 620.40 0 0 5 2 0.009
i.  41 .8   7000  770.00 385.00 0 0 5 2 0.009 ;virtutibus; 
i.  +  .8  <      545.60 272.80 0 0 5 2 0.009  
i.  .  .8  <      690.80 345.40 0 0 5 2 0.009  
i.  .  .8  <      365.20 182.60 0 0 5 2 0.009  
i.  .  .8   8500  748.00 374.00 0 0 5 2 0.009  

;M.12, Tsig. 4/4.   
i9 46  1   5000 730.40 365.20 0 0 5 2 0.009  
i. .   .  .     545.60 272.80 0 0 5 2 0.009  
i. .   .  .     453.20 226.60 0 0 5 2 0.009  
i. .   .  .     374.00 187.00 0 0 5 2 0.009  
i. .   .  .     712.80 356.40 0 0 5 2 0.009   
i9 47  3   5500 488.40 244.20 0 0 5 2 0.009 ;eius; 
i. .   .  .     545.60 272.80 0 0 5 2 0.009  
i. .   .  .     748.00 374.00 0 0 5 2 0.009  
i. .   .   6000 356.40 178.20 0 0 5 2 0.009 
;M.12, Tsig. 4/4.   
i12 46 .2   7000 730.40 365.20 0 0 5 2 0.009  
i.  +  .2  <     545.60 272.80 0 0 5 2 0.009  
i.  .  .2  <     453.20 226.60 0 0 5 2 0.009  
i.  .  .2  <     374.00 187.00 0 0 5 2 0.009  
i.  .  .2  <     712.80 356.40 0 0 5 2 0.009   
i12 47 .75  8500 488.40 244.20 0 0 5 2 0.009 ;eius; 
i.  +  .75 <     545.60 272.80 0 0 5 2 0.009  
i.  .  .75 <     748.00 374.00 0 0 5 2 0.009  
i.  .  .75  9000 356.40 178.20 0 0 5 2 0.009 

;M.13, Tsig. 4/4. 
i9 50  2  5500 589.30 589.30 0 0 5 2 0.009 
i. .   .  5000 880.00 440.00 0 0 5 2 0.009  
i. .   .  5000 748.00 374.00 0 0 5 2 0.009  
i. .   .  5000 950.40 475.20 0 0 5 2 0.009  
i. .   .  5000 880.00 440.00 0 0 5 2 0.009  
i. .   .  5500 730.40 365.20 0 0 5 2 0.009  
i9 .   2  5500 976.80 488.40 0 0 5 2 0.009 
i9 52  1  6000 976.80 488.40 0 0 5 2 0.009  
i. .   .  5500 748.00 374.00 0 0 5 2 0.009  
i. .   .  5500 607.20 303.60 0 0 5 2 0.009  
i9 53  1  5500 712.80 356.40 0 0 5 2 0.009 
;M.13, Tsig. 4/4. 
i12 50 .2857  8500 589.30 589.30 0 0 5 2 0.009 ;laudate; 
i.  +  .2857 .     880.00 440.00 0 0 5 2 0.009  
i.  .  .2857 <     748.00 374.00 0 0 5 2 0.009  
i.  .  .2857 .     950.40 475.20 0 0 5 2 0.009  
i.  .  .2857 <     880.00 440.00 0 0 5 2 0.009  
i.  .  .2857 .     730.40 365.20 0 0 5 2 0.009  
i.  .  .2857  9700 976.80 488.40 0 0 5 2 0.009 
i12 52 .3333 10000 976.80 488.40 0 0 5 2 0.04 ;eum; 
i.  +  .3333  9200 748.00 374.00 0 0 5 2 0.04  
i.  .  .3333  8500 607.20 303.60 0 0 5 2 0.04  
i12 53 2      7500 712.80 356.40 0 0 5 2 0.04 ;secundum; 

;M.14, Tsig. 4/4.
i9 55 1    5000 488.40 244.20 0 0 5 2 0.009  
i. .  1   .     620.26 310.13 0 0 5 2 0.009
i. .  1   .     787.73 393.86 0 0 5 2 0.009
i. .  1   .    1000.41 500.20 0 0 5 2 0.009
i9 56 1   6000  924.00 462.00 0 0 5 2 0.009
i. .  1   .     586.74 293.37 0 0 5 2 0.009
i. .  1   500  1173.48 586.74 0 0 5 2 0.009
i. .  1   .     372.57 186.29 0 0 5 2 0.009  
i9 57 2   6000  748.00 374.00 0 0 5 2 0.009
i. .  2   .     949.96 474.98 0 0 5 2 0.009
i. .  2   .     903.22 301.61 0 0 5 2 0.009
i. .  2   5500  383.04 191.52 0 0 5 2 0.009  
;M.14, Tsig. 4/4.
i12 55 1   9000 488.40 244.20 0 0 5 2 0.009  
i.  +  1 .      924.00 462.00 0 0 5 2 0.009  
i.  .  2  7500  748.00 374.00 0 0 5 2 0.009

;M.15, Tsig. 4/4.
i12 59 1    7500 620.40 310.20 0 0 5 2 0.009  
i.  +  1   .     475.20 237.60 0 0 5 2 0.009  
i.  .  1   .     374.00 187.00 0 0 5 2 0.009  
i.  .  .75  8000 303.60 151.80 0 0 5 2 0.009
i.  .  .25  9000 607.20 303.60 0 0 5 2 0.009
;M.15, Tsig. 4/4.
i12 59 1    7500 623.40 313.20 0 0 5 2 0.009  
i.  +  1   .     478.20 240.60 0 0 5 2 0.009  
i.  .  1   .     377.00 190.00 0 0 5 2 0.009  
i.  .  .75  8000 306.60 154.80 0 0 5 2 0.009
i.  .  .25  9000 610.20 306.60 0 0 5 2 0.009    

;M.16, Tsig. 4/4.
i8 63 .75  7000 303.60 151.80 .1 5 2 2 0.009 ;multitudinem; 
i. +  .75 <     748.00 374.00 .1 5 2 2 0.009  
i. .  .75 <    1179.20 589.60 .1 5 2 2 0.009  
i. .  .75 <     730.40 365.20 .1 5 2 2 0.009  
i. .  .75 <    1091.20 545.60 .1 5 2 2 0.009  
i. .  .25 10000 730.40 365.20 .1 5 2 2 0.009  
i12 63  1   6500 374.00 187.00 0 0 5 2 0.009  
i.  +   1   6800 475.20 237.60 0 0 5 2 0.009  
i12 65 .5   7000 272.80 136.40 0 0 5 2 0.009  
i.  +  .5  <     310.20 155.10 0 0 5 2 0.009  
i.  .  .5  <     244.64 122.10 0 0 5 2 0.009  
i.  .  .5   8500 303.60 151.80 0 0 5 2 0.009  

;M.17, Tsig. 4/4.
i8 67 .25  6500 374.00 187.00 .1 5 2 2 0.009  
i. +  .75 .     475.20 237.60 .1 5 2 2 0.009  
i. .  .75 .     272.80 136.40 .1 5 2 2 0.009  
i. .  .75 .     310.20 155.10 .1 5 2 2 0.009  
i. .  .75 .     244.64 122.10 .1 5 2 2 0.009  
i. .  .75  8500 303.60 151.80 .1 5 2 2 0.009  
i12 67 1    6500 303.60 151.80 0 0 5 2 0.009  
i.  +  .   .     244.64 122.10 0 0 5 2 0.009  
i.  .  .5  .     310.20 155.10 0 0 5 2 0.009  
i.  .  .5  .     272.80 136.40 0 0 5 2 0.009  
i.  .  .5  .     475.20 237.60 0 0 5 2 0.009  
i.  .  .5   8500 374.00 187.00 0 0 5 2 0.009

;M.18, Tsig. 4/4.
i9 71 4  7000 607.20 303.60  0 0 5 2 0.009 ;magnitudinis; 
i. 72 .  7100 310.20 155.10  0 0 5 2 0.009  
i. 73 .  7200 748.00 374.00  0 0 5 2 0.009  
i. 74 .  7300 310.20 155.10  0 0 5 2 0.009  
;M.18, Tsig. 4/4.
i8 71 .3333  7000 607.20 303.60 .1 5 2 2 0.009  
i. +  .3333 .     440.00 220.00 .1 5 2 2 0.009  
i. .  .3333  9000 514.80 257.40 .1 5 2 2 0.009  
i8 72 .3333  7100 310.20 155.10 .1 5 2 2 0.009  
i. +  .3333 .     272.80 136.40 .1 5 2 2 0.009  
i. .  .3333  9100 365.20 182.60 .1 5 2 2 0.009  
i8 73 .3333  7200 748.00 374.00 .1 5 2 2 0.009  
i. +  .3333 .     475.20 237.60 .1 5 2 2 0.009  
i. .  .3333  9200 545.60 272.80 .1 5 2 2 0.009  
i8 74 .3333  7300 310.20 155.10 .1 5 2 2 0.009  
i. +  .3333 .     272.80 136.40 .1 5 2 2 0.009  
i. .  .3333  9300 356.40 178.20 .1 5 2 2 0.009 

;M.19, Tsig. 4/4. 
i9 75 .25    6500 244.20 122.10  0 0 5 2 0.009 ;eius;
i. +  .25   .     272.80 136.40  0 0 5 2 0.009  
i. .  .25   .     374.00 187.00  0 0 5 2 0.009  
i. .  .25   11000 356.40 178.20  0 0 5 2 0.009  
i9 76 .25    6500 327.22 163.61  0 0 5 2 0.009  
i. +  .25   .     272.80 136.40  0 0 5 2 0.009  
i. .  .25   .     374.00 187.00  0 0 5 2 0.009  
i. .  .25   11000 356.40 178.20  0 0 5 2 0.009
i9 77 .1667  6500 438.47 219.23  0 0 5 2 0.009  
i. +  .1667 .     272.80 136.40  0 0 5 2 0.009  
i. .  .1667 .     374.00 187.00  0 0 5 2 0.009  
i. .  .1667 11000 356.40 178.20  0 0 5 2 0.009     
i. .  .1667  6500 587.54 293.77  0 0 5 2 0.009  
i. .  .1667  9500 272.80 136.40  0 0 5 2 0.009  
i9 78 .5    10000 374.00 187.00  0 0 5 2 0.009  
i. +  .5    11000 356.40 178.20  0 0 5 2 0.009  

;M.20, Tsig. 4/4.
i9 79  2 5000 294.80 147.40 0 0 5 2 0.009 ;laudate; 
i. .   . 5000 440.00 220.00 0 0 5 2 0.009  
i. .   . 5000 374.00 187.00 0 0 5 2 0.009 
i. .   . 5000 475.20 237.60 0 0 5 2 0.009  
i. .   . 5000 880.00 440.00 0 0 5 2 0.009  
i. .   . 5000 730.40 365.20 0 0 5 2 0.009  
i. .   . 5000 976.80 488.40 0 0 5 2 0.009  
i8 81  2 5000 976.80 488.40 0 0 5 2 0.009 ;eum;
i. .   . 4000 748.00 374.00 0 0 5 2 0.009  
i. .   . 6000 607.20 303.60 0 0 5 2 0.009  
;M.20, Tsig. 4/4.
i12 79 .2857  7000 294.80 147.40 0 0 5 2 0.009 
i.  +  .2857  7200 440.00 220.00 0 0 5 2 0.009  
i.  .  .2857  7350 374.00 187.00 0 0 5 2 0.009 
i.  .  .2857  7800 475.20 237.60 0 0 5 2 0.009  
i.  .  .2857  8000 880.00 440.00 0 0 5 2 0.009  
i.  .  .2857  8500 730.40 365.20 0 0 5 2 0.009  
i.  .  .2857  9000 976.80 488.40 0 0 5 2 0.009  
i12 81 .6667 10000 976.80 488.40 0 0 5 2 0.009 
i.  +  .6667  8700 748.00 374.00 0 0 5 2 0.009  
i.  .  .6667  7800 607.20 303.60 0 0 5 2 0.009  

;M.21, Tsig. 4/4.
i9 83  1   9800  545.60 272.80 0 0 5 2 0.009   
i9 84  1   6000  712.80 356.40 0 0 5 2 0.009 
i9 85  1   7500  730.40 365.20 0 0 5 2 0.009  
i9 86  1   8700  976.80 488.40 0 0 5 2 0.009  
;M.21, Tsig. 4/4.
i12 83    .75  9800 545.60 272.80 0 0 5 2 0.009 ;in; 
i12 83.75 .75  7500 620.40 310.20 0 0 5 2 0.009  
i12 84.50 .25  6000 712.80 356.40 0 0 5 2 0.009 ;sono; 
i12 84.75 .25  6250 630.00 319.00 0 0 5 2 0.009  
i12 85    .25  7500 620.40 310.20 0 0 5 2 0.009  
i12 85.25 .75  7000 630.00 319.00 0 0 5 2 0.009  
i12 86    .2   7500 730.40 365.20 0 0 5 2 0.009 ;tubae; 
i.  +     .2   7600 748.00 374.00 0 0 5 2 0.009  
i.  .     .2   8000 906.40 453.20 0 0 5 2 0.009  
i.  .     .2   8500 880.00 440.00 0 0 5 2 0.009 
i.  .     .2   8700 976.80 488.40 0 0 5 2 0.009  

;M.22, Tsig. 4/4.
i9 87 .2857  7400 294.80 147.40 0 0 5 2 0.009 ;laudate; 
i. +  .2857  7450 440.00 220.00 0 0 5 2 0.009  
i. .  .2857  7600 374.00 187.00 0 0 5 2 0.009 
i. .  .2857  7400 475.20 237.60 0 0 5 2 0.009  
i. .  .2857  7700 880.00 440.00 0 0 5 2 0.009  
i. .  .2857  7900 730.40 365.20 0 0 5 2 0.009  
i. .  .2857  8000 976.80 488.40 0 0 5 2 0.009  
i9 89 .6667  9500 976.80 488.40 0 0 5 2 0.009 ;eum;
i. +  .6667  9550 748.00 374.00 0 0 5 2 0.009  
i. .  .6667  9600 607.20 303.60 0 0 5 2 0.009  
;M.22, Tsig. 4/4.
i8 87 .2857  4000 294.80 147.40 .1 5 2 2 0.009  
i. +  .2857  4300 440.00 220.00 .1 5 2 2 0.009  
i. .  .2857  4400 374.00 187.00 .1 5 2 2 0.009 
i. .  .2857  4500 475.20 237.60 .1 5 2 2 0.009  
i. .  .2857  4600 880.00 440.00 .1 5 2 2 0.009  
i. .  .2857  4700 730.40 365.20 .1 5 2 2 0.009  
i. .  .2857  4800 976.80 488.40 .1 5 2 2 0.009  
i8 89 .6667  5000 976.80 488.40 .1 5 2 2 0.009  
i8 +  .6667  5250 748.00 374.00 .1 5 2 2 0.009  
i8 +  .6667  5500 607.20 303.60 .1 5 2 2 0.009  

;M.23, Tsig. 3/4.
i9 91  .1667  4000 545.60 272.80 0 0 5 2 0.009 ;in; 
i9 +   .1667  5000 620.40 310.20 0 0 5 2 0.009
i9 +   .1667  6000 545.60 272.80 0 0 5 2 0.009  
i9 +   .1667  7000 620.40 310.20 0 0 5 2 0.009  
i9 +   .1667  4000 545.60 272.80 0 0 5 2 0.009  
i9 +   .1667  5000 620.40 310.20 0 0 5 2 0.009  
i9 92  .1667  6000 545.60 272.80 0 0 5 2 0.009 
i9 +   .1667  7000 620.40 310.20 0 0 5 2 0.009  
i9 +   .1667  4000 545.60 272.80 0 0 5 2 0.009 
i9 +   .1667  5000 620.40 310.20 0 0 5 2 0.009  
i9 +   .1667  6000 545.60 272.80 0 0 5 2 0.009  
i9 +   .1667  7000 620.40 310.20 0 0 5 2 0.009  
i9 93  .75    8000 545.60 272.80 0 0 5 2 0.009  
i9 +   .25    6000 620.40 310.20 0 0 5 2 0.009  
;M.23, Tsig. 3/4.
i8 91   1.5  5000 545.60 272.80 .1 5 2 2 0.009 
i8 92.5 1.5  6000 620.40 310.20 .1 5 2 2 0.009  

;M.24, Tsig. 4/4.
i8 94  4  5000 327.80 163.90  .1 5 2 2 0.009  
;M.24, Tsig. 4/4.
i9 94 .4444 7500 327.80 163.90 0 0 5 2 0.009 ;psalterio; 
i. +  .4444 7650 356.40 178.20 0 0 5 2 0.009  
i. +  .4444 7850 440.00 220.00 0 0 5 2 0.009  
i. +  .4444 8000 294.80 147.40 0 0 5 2 0.009  
i. +  .4444 8050 365.20 182.60 0 0 5 2 0.009  
i. +  .4444 7850 488.40 244.20 0 0 5 2 0.009  
i. +  .4444 6000 690.80 345.40 0 0 5 2 0.009  
i. +  .4444 7000 545.60 272.80 0 0 5 2 0.009  
i. .  .4444 7800 319.00 159.50 0 0 5 2 0.009  

;M.25, Tsig. 4/4.
i9 100  2    5500 453.20 226.60  0 0 5 2 0.009 ;et; 
i9 100  2    6500 365.20 182.60  0 0 5 2 0.009
i9 102  2    7500 453.20 226.60  0 0 5 2 0.009  
i9 102  2    6500 730.40 365.20  0 0 5 2 0.009
;M.25, Tsig. 4/4.
i12 100  1.5     7500 453.20 226.60 0 0 5 2 0.009  
i12 +    1.5     8900 730.40 365.20 0 0 5 2 0.009
i12 +     .1429 10000 432.00 231.00 0 0 5 2 0.009 ;cithara;
i12 +     .1429  9000 545.60 272.80 0 0 5 2 0.009
i12 +     .1429  8000 365.20 182.60 0 0 5 2 0.009
i12 +     .1429  7000 266.20 133.10 0 0 5 2 0.009
i12 +     .1429  7500 220.00 110.00 0 0 5 2 0.009
i12 +     .1429  7800 345.40 172.70 0 0 5 2 0.009
i12 .     .1429  9000 440.00 220.00 0 0 5 2 0.009

;M.26, Tsig. 4/4.   
i10 104 .2857  9500 147.40  73.70 0 0 5 2 0.009 ;laudate; 
i.  +   .2857 .     220.00 110.00 0 0 5 2 0.009  
i.  .   .2857 .     187.00  93.50 0 0 5 2 0.009 
i.  .   .2857 .     237.60 118.80 0 0 5 2 0.009  
i.  .   .2857 .     440.00 220.00 0 0 5 2 0.009  
i.  .   .2857  7600 365.20 182.60 0 0 5 2 0.009  
i.  .   .2857 10000 488.40 244.20 0 0 5 2 0.009  
i10 105 .6667  7500 488.40 244.20 0 0 5 2 0.009 ;eum; 
i.  +   .6667 .     374.00 187.00 0 0 5 2 0.009  
i.  .   .6667  9500 303.60 151.80 0 0 5 2 0.009  

;M.27, Tsig. 3/4.
i11 107 1.5  8500 272.80 136.40 .1 2 2 2 0.009 ;in; 
i.  +   1.5  9500 310.20 155.10 .1 2 2 2 0.009  

;M.28, Tsig. 4/4.  
i11 110  2 5000 185.60  91.30 0 0 5 2 0.009  
i.  .    2 5500 212.00 104.50 0 0 5 2 0.009  
i.  .    2 5700 154.80  75.90 0 0 5 2 0.009  
i.  .    2 6000 166.90  81.95 0 0 5 2 0.009  
i.  .    2 5750 223.00 110.00 0 0 5 2 0.009  
i.  .    2 5500 313.20 155.10 0 0 5 2 0.009  
i.  .    2 5750 322.00 159.50 0 0 5 2 0.009  
i12 112  1 5900 247.20 122.10 0 0 5 2 0.009  
i12 112  1 5250 185.60  91.30 0 0 5 2 0.009  
i8  113  1 4000 234.00 115.50 0 0 5 2 0.009  
i.  .    1 5000 136.10  66.55 0 0 5 2 0.009  
i.  .    1 5000 162.50  79.75 0 0 5 2 0.009  
i.  .    1 5000 175.70  86.35 0 0 5 2 0.009  
i.  .    1 6000 162.50  79.75 0 0 5 2 0.009  
;M.28, Tsig. 4/4.  
i10 110 .2857  7800  182.60  91.30 0 0 5 2 0.009 ;tympano; 
i.  +   .2857  7855  209.00 104.50 0 0 5 2 0.009  
i.  +   .2857  7900  151.80  75.90 0 0 5 2 0.009  
i.  +   .2857  8000  163.90  81.95 0 0 5 2 0.009  
i.  +   .2857  8250  220.00 110.00 0 0 5 2 0.009  
i.  +   .2857  8500  310.20 155.10 0 0 5 2 0.009  
i.  +   .2857  8700  319.00 159.50 0 0 5 2 0.009  
i.  112 .5     8900  244.20 122.10 0 0 5 2 0.009 ;et; 
i.  +   .1667  7900 1182.60  91.30 0 0 5 2 0.009
i.  +   .1667  8900 1244.20 122.10 0 0 5 2 0.009  
i.  +   .1667  8100 1182.60  91.30 0 0 5 2 0.009  
i.  113 .1     7800  231.00 115.50 0 0 5 2 0.009 ;choro; 
i.  +   .1     8400  133.10  66.55 0 0 5 2 0.009  
i.  +   .1     8800  159.50  79.75 0 0 5 2 0.009  
i.  +   .1     9200  172.70  86.35 0 0 5 2 0.009  
i.  +   .1     9800  159.50  79.75 0 0 5 2 0.009  
i.  +   .1     9800  159.50  79.75 0 0 5 2 0.009
i.  +   .1     9200  172.70  86.35 0 0 5 2 0.009
i.  +   .1     8800  159.50  79.75 0 0 5 2 0.009  
i.  +   .1     8300  133.10  66.55 0 0 5 2 0.009
i.  +   .1     7800  231.00 115.50 0 0 5 2 0.009 

;M.29, Tsig. 4/4.  
i8 114 .2857  7800 147.40  73.70 .1 5 2 2 0.009 ;laudate; 
i. +   .2857 .     220.00 110.00 .1 5 2 2 0.009  
i. .   .2857 .     187.00  93.50 .1 5 2 2 0.009 
i. .   .2857 .     237.60 118.80 .1 5 2 2 0.009  
i. .   .2857 .     440.00 220.00 .1 5 2 2 0.009  
i. .   .2857 .     365.20 182.60 .1 5 2 2 0.009  
i. .   .2857  9600 488.40 244.20 .1 5 2 2 0.009  
i. 116 .6667  6000 488.40 244.20 .1 5 2 2 0.009 ;eum; 
i. +   .6667 .     374.00 187.00 .1 5 2 2 0.009  
i. .   .6667  9000 303.60 151.80 .1 5 2 2 0.009  
;M.29, Tsig. 4/4.  
i11 114  2  5800 150.40  73.70 .1 2 2 2 0.009 
i.  .    . .     223.00 110.00 .1 2 2 2 0.009  
i.  .    . .     190.00  93.50 .1 2 2 2 0.009 
i.  .    . .     240.60 118.80 .1 2 2 2 0.009  
i.  .    . .     443.00 220.00 .1 2 2 2 0.009  
i.  .    . .     368.20 182.60 .1 2 2 2 0.009  
i.  .    .  5600 451.40 244.20 .1 2 2 2 0.009  
i.  116  2  6000 491.40 244.20 .1 2 2 2 0.009 
i.  .    . .     377.00 187.00 .1 2 2 2 0.009  
i.  .    .  5000 306.60 151.80 .1 2 2 2 0.009 
 
;M.30, Tsig. 3/4.
i11 118 1.5   6500 272.80 136.40  0 0 5 2 0.009 ;in; 
i. +    1.5   7500 310.20 155.10 .1 5 2 2 0.009  
;M.30, Tsig. 3/4.
i12 118 .25 6500 545.60 272.80 0 0 5 2 0.009 ;chordis; 
i.  +   .  .     266.20 133.10 0 0 5 2 0.009  
i.  .   .  .     319.00 159.50 0 0 5 2 0.009  
i.  .   .   7000 620.40 310.20 0 0 5 2 0.009  
i.  .   .  .     237.60 118.80 0 0 5 2 0.009  
i.  .   .  .     272.80 136.40 0 0 5 2 0.009  
i.  .   .   7500 545.60 272.80 0 0 5 2 0.009  
i.  .   .  .     115.50  57.75 0 0 5 2 0.009  
i.  .   .  .     266.20 133.10 0 0 5 2 0.009  
i.  .   .   7800 620.40 310.20 0 0 5 2 0.009  
i.  .   .  .     172.70  86.35 0 0 5 2 0.009  
i.  .   .   8000 237.60 118.80 0 0 5 2 0.009  

;M.31, Tsig. 2/4. 
i8  121 .2857   7500 115.50  57.75 .1 5 2 2 0.009 
i.  +   .2857  .     266.20 133.10 .1 5 2 2 0.009  
i.  .   .2857   7000 319.00 159.50 .1 5 2 2 0.009  
i.  .   .2857  .     172.70  86.35 .1 5 2 2 0.009  
i.  .   .2857   7500 237.60 118.80 .1 5 2 2 0.009  
i.  .   .2857  .     272.80 136.40 .1 5 2 2 0.009  
i.  .   .2857   7500 356.40 178.20 .1 5 2 2 0.009  
i10 121 .5     5000  976.80 488.40 0 0 5 2 0.009  
i.  .   .      5000 1460.80 730.40 0 0 5 2 0.009  
i.  .   .      5000  244.20 122.10 0 0 5 2 0.009  
i.  .   .      5000  182.60  91.30 0 0 5 2 0.009 

;M.32, Tsig. 2/4.
i10 123 1     8000 488.40 244.20 0 0 5 2 0.009 ;et; 
i.  +   1     8200 365.20 182.60 0 0 5 2 0.009  
;M.32, Tsig. 2/4.
i8 123 1     8000 244.20 122.10 .1 5 2 2 0.009  
i. +   1     8200 182.60  91.30 .1 5 2 2 0.009  

;M.33, Tsig. 2/4.
i8 125 .3333  7000 159.50  79.75 .1 5 2 2 0.009 ;organo; 
i. +   .3333 .     172.70  86.35 .1 5 2 2 0.009  
i. .   .3333  8000 257.40 128.70 .1 5 2 2 0.009  
i. .   .3333  7200 220.00 110.00 .1 5 2 2 0.009  
i. .   .3333 .     310.20 155.10 .1 5 2 2 0.009  
i. .   .3333  9200 159.50  79.75 .1 5 2 2 0.009  
;M.33, Tsig. 2/4.
i10 125 .3333  5000 159.50  79.75 0 0 5 2 0.009  
i.  .   .3333 .     172.70  86.35 0 0 5 2 0.009  
i.  .   .3333  6000 257.40 128.70 0 0 5 2 0.009  
i.  126 .3333  6200 220.00 110.00 0 0 5 2 0.009  
i.  .   .3333 .     310.20 155.10 0 0 5 2 0.009  
i.  .   .3333  5200 159.50  79.75 0 0 5 2 0.009  

;M.34, Tsig. 4/4.  
i11 127 .2857  3000 150.40  76.70 .1 2 2 2 0.009 ;laudate; 
i. +    .2857 .     223.00 113.00 .1 2 2 2 0.009  
i. .    .2857 .     190.00  96.50 .1 2 2 2 0.009 
i. .    .2857  5000 240.60 121.80 .1 2 2 2 0.009  
i. .    .2857 .     443.00 223.00 .1 2 2 2 0.009  
i. .    .2857  5500 368.20 185.60 .1 2 2 2 0.009  
i. .    .2857 .     491.40 247.20 .1 2 2 2 0.009  
i. 129  .6667  5900 488.40 244.20 .1 2 2 2 0.009 ;eum; 
i. +    .6667 .     377.00 190.00 .1 2 2 2 0.009  
i. .    .6667  6500 306.60 154.80 .1 2 2 2 0.009    
;M.34, Tsig. 4/4.  
i8 127 .2857  3000 147.40  73.70 .1 5 2 2 0.009  
i. +   .2857 .     220.00 110.00 .1 5 2 2 0.009  
i. .   .2857 .     187.00  93.50 .1 5 2 2 0.009 
i. .   .2857  5200 237.60 118.80 .1 5 2 2 0.009  
i. .   .2857 .     440.00 220.00 .1 5 2 2 0.009  
i. .   .2857  5800 365.20 182.60 .1 5 2 2 0.009  
i. .   .2857 .     488.40 244.20 .1 5 2 2 0.009  
i. 129 .6667  5900 488.40 244.20 .1 5 2 2 0.009 
i. +   .6667 .     374.00 187.00 .1 5 2 2 0.009
i. .   .6667  6500 303.60 151.80 .1 5 2 2 0.009    
;M.34, Tsig. 4/4.  
i13 127 .6667  7900 488.40 244.20  0 0 5 2 0.009 
i.  +   .6667 .     374.00 187.00  0 0 5 2 0.009  
i.  .   .6667  8500 303.60 151.80  0 0 5 2 0.009  
i10 129 2      6500 147.40  73.70  0 0 5 2 0.009

;M.35, Tsig. 3/4.
i8 131 1.5 7600 272.80 136.40 .1 5 2 2 0.009 ;in; 
i. +   1.5 7900 310.20 155.10 .1 5 2 2 0.009  
;M.35, Tsig. 3/4.
i10 131 1.5 7600 272.80 136.40  0 0 5 2 0.009  
i.  +   1.5 7900 310.20 155.10  0 0 5 2 0.009  

;M.36, Tsig. 4/4.
i10 133 .25    5800 115.50  57.75 0 0 5 2 0.009 ;cymbalis;
i.  +   .25   .     209.00 104.50 0 0 5 2 0.009  
i.  .   .25   .     151.80  75.90 0 0 5 2 0.009  
i.  .   .25   .     113.30  56.65 0 0 5 2 0.009  
i.  .   .25   .     220.00 110.00 .1 2 5 2 0.009  
i.  .   .125  .     147.45  73.70 .1 2 5 2 0.009  
i.  .   .125  .     136.40  68.20  0 0 5 2 0.009  
i.  .   .5    .     178.20  89.10 .1 2 2 2 0.009  
i. 135  .2857  6000 226.60 113.30 .1 5 2 2 0.009 ;benesonantibus; 
i. +    .2857  7000 244.20 122.10 .1 5 2 2 0.009  
i. .    .2857 .     155.10  77.55 .1 5 2 2 0.009  
i. .    .2857 .     122.10  61.05 .1 5 2 2 0.009  
i. .    .2857  7000  89.10  89.10 .1 5 2 2 0.009  
i. .    .2857 .     159.50  79.75 .1 5 2 2 0.009  
i. .    .2857 .     310.20 155.10 .1 5 2 2 0.009  
i. .    .2857 .     220.00 110.00 .1 5 2 2 0.009  
i. .    .2857 .     155.10  77.55 .1 5 2 2 0.009  
i. .    .2857 .     182.60  91.30 .1 5 2 2 0.009  
i. .    .2857 .     136.40  68.20 .1 5 2 2 0.009  
i. .    .2857 .     113.30  56.65 .1 5 2 2 0.009  
i. .    .2857 .      93.50  93.50 .1 5 2 2 0.009  
i. .    .2857  7200 178.20  89.10 .1 5 2 2 0.009  
;M.36, Tsig. 4/4.
i8 133 .125   5000 115.50  57.75 0 0 5 2 0.009  
i. +   .125  .     209.00 104.50 0 0 5 2 0.009  
i. .   .125  .     151.80  75.90 0 0 5 2 0.009  
i. .   .125  .     113.30  56.65 0 0 5 2 0.009  
i. .   .125  .     220.00 110.00 0 0 5 2 0.009  
i. .   .125  .     147.45  73.70 0 0 5 2 0.009  
i. .   .125  .     136.40  68.20 0 0 5 2 0.009  
i. .   .125  .     178.20  89.10 0 0 5 2 0.009  
i. .   .125   5000 115.50  57.75 0 0 5 2 0.009  
i. .   .125  .     209.00 104.50 0 0 5 2 0.009  
i. .   .125  .     151.80  75.90 0 0 5 2 0.009  
i. .   .125  .     113.30  56.65 0 0 5 2 0.009  
i. .   .125  .     220.00 110.00 0 0 5 2 0.009  
i. .   .125  .     147.45  73.70 0 0 5 2 0.009  
i. .   .125  .     136.40  68.20 0 0 5 2 0.009  
i. .   .125  .     178.20  89.10 0 0 5 2 0.009  
i. 135 .2857  7000 226.60 113.30 0 0 5 2 0.009  
i. +   .2857  7000 244.20 122.10 0 0 5 2 0.009  
i. .   .2857 .     155.10  77.55 0 0 5 2 0.009  
i. .   .2857 .     122.10  61.05 0 0 5 2 0.009  
i. .   .2857  7200  89.10  89.10 0 0 5 2 0.009  
i. .   .2857 .     159.50  79.75 0 0 5 2 0.009  
i. .   .2857 .     310.20 155.10 0 0 5 2 0.009  
i. .   .2857 .     220.00 110.00 0 0 5 2 0.009  
i. .   .2857 .     155.10  77.55 0 0 5 2 0.009  
i. .   .2857 .     182.60  91.30 0 0 5 2 0.009  
i. .   .2857 .     136.40  68.20 0 0 5 2 0.009  
i. .   .2857 .     113.30  56.65 0 0 5 2 0.009  
i. .   .2857 .      93.50  93.50 0 0 5 2 0.009  
i. .   .2857  7000 178.20  89.10 0 0 5 2 0.009  

;M.37, Tsig. 4/4.
i12 139 .2857  3000 294.80 147.40 0 0 5 2 0.009 ;laudate; 
i.  +   .2857 .     440.00 220.00 0 0 5 2 0.009  
i.  .   .2857 .     374.00 187.00 0 0 5 2 0.009 
i.  .   .2857 .     475.20 237.60 0 0 5 2 0.009  
i.  .   .2857 .     880.00 440.00 0 0 5 2 0.009  
i.  .   .2857 .     730.40 365.20 0 0 5 2 0.009  
i.  .   .2857 .     976.80 488.40 0 0 5 2 0.009  
i.  141 .6667  6000 976.80 488.40 0 0 5 2 0.009 ;eum; 
i.  +   .6667 .     748.00 374.00 0 0 5 2 0.009  
i.  .   .6667  6000 607.20 303.60 0 0 5 2 0.009  
;M.37, Tsig. 4/4.
i12 139 2  3000 294.80 147.40 0 0 5 2 0.009  
i.  .   . .     440.00 220.00 0 0 5 2 0.009  
i.  .   . .     374.00 187.00 0 0 5 2 0.009 
i.  .   . .     475.20 237.60 0 0 5 2 0.009  
i.  .   . .     880.00 440.00 0 0 5 2 0.009  
i.  .   . .     730.40 365.20 0 0 5 2 0.009  
i.  .   .  5000 976.80 488.40 0 0 5 2 0.009  
i12 141 2  6000 976.80 488.40 0 0 5 2 0.009 
i.  .   . .     748.00 374.00 0 0 5 2 0.009  
i.  .   .  5000 607.20 303.60 0 0 5 2 0.009  

;M.38, Tsig. 3/4.
i11 143 .5     7500 545.60 272.80 .1 5 2 2 0.009 ;in; 
i.  +   .5    .     620.40 310.20 .1 5 2 2 0.009  
i.  144 .25    8200 924.00 462.00 .1 5 2 2 0.009 ;cymbalis; 
i.  +   .25   .     836.00 418.00 .1 5 2 2 0.009  
i.  .   .25   .     607.20 303.60 .1 5 2 2 0.009  
i.  .   .25   .     453.20 226.60 .1 5 2 2 0.009  
i.  .   .25   .     880.00 440.00 .1 5 2 2 0.009  
i.  .   .25   .     589.60 294.80 .1 5 2 2 0.009  
i.  .   .25   .     545.60 272.80 .1 5 2 2 0.009  
i.  .   .25    9500 712.80 356.40 .1 5 2 2 0.009  

;M.39, Tsig. 4/4.
i12 146 1  5000 1120.60 561.80 0 0 5 2 0.009 ;jubilationis; 
i.  147 1  .     548.60 275.80 0 0 5 2 0.009  
i.  148 1  .     368.20 185.60 0 0 5 2 0.009  
i.  149 1  7000  313.20 158.10 0 0 5 2 0.009  
;M.39, Tsig. 4/4.
i11 146 1 6000 1117.60 558.80 .1 2 2 2 0.009  
i. .   .  5000  748.00 374.00 .1 2 2 2 0.009  
i. .   .  5000  906.40 453.20 .1 2 2 2 0.009  
i. 147 1  6000  545.60 272.80 .1 2 2 2 0.009  
i. .   .  5000  589.60 294.80 .1 2 2 2 0.009  
i. .   .  5000  440.00 220.00 .1 2 2 2 0.009  
i. 148 1  6000  365.20 182.60 .1 2 2 2 0.009  
i. .   .  5000  272.80 136.40 .1 2 2 2 0.009  
i. .   .  8000  319.00 159.50 .1 2 2 2 0.009  
i. 149 1  6000  310.20 155.10 .1 2 2 2 0.009  
i. .   .  5000  272.80 136.40 .1 2 2 2 0.009  
i. .   .  8000  356.40 178.20 .1 2 2 2 0.009  
;M.39, Tsig. 4/4.
i12 146 .3333  6700 1117.60 558.80 0 0 5 2 0.009  
i.  +   .3333 .      748.00 374.00 0 0 5 2 0.009  
i.  .   .3333  8700  906.40 453.20 0 0 5 2 0.009  
i.  147 .3333  6750  545.60 272.80 0 0 5 2 0.009  
i.  +   .3333 .      589.60 294.80 0 0 5 2 0.009  
i.  .   .3333  8750  440.00 220.00 0 0 5 2 0.009  
i.  148 .3333  6780  365.20 182.60 0 0 5 2 0.009  
i.  +   .3333 .      272.80 136.40 0 0 5 2 0.009  
i.  .   .3333  8800  319.00 159.50 0 0 5 2 0.009  
i.  149 .3333  6790  310.20 155.10 0 0 5 2 0.009  
i.  +   .3333 .      272.80 136.40 0 0 5 2 0.009  
i.  .   .3333  8900  356.40 178.20 0 0 5 2 0.009  

;M.40, Tsig. 4/4.
i12 150 .1667  7500 294.80 147.00 0 0 5 2 0.009 
i.  +   .1667 .     220.00 110.00 0 0 5 2 0.009  
i.  .   .1667  8900 187.00  93.50 0 0 5 2 0.009  
i.  .   .1667  7600 237.60 118.80 0 0 5 2 0.009  
i.  .   .1667 .     122.10  61.05 0 0 5 2 0.009  
i.  .   .1667  9000 182.60  91.30 0 0 5 2 0.009  
i13 151 .1667  7700 365.20 182.60 0 0 5 2 0.009  
i.  +   .1667 .     244.20 122.10 0 0 5 2 0.009
i.  .   .1667  8900 475.20 237.60 0 0 5 2 0.009
i.  .   .1667  7750 374.00 187.00 0 0 5 2 0.009
i.  .   .1667 .     440.00 220.00 0 0 5 2 0.009
i.  .   .1667  9100 589.60 294.80 0 0 5 2 0.009
i10 152 .125   6500 475.20 237.60 0 0 5 2 0.009 
i.  152 .5    .     638.00 319.00 0 0 5 2 0.009  
i.  +   .5    .     303.60 151.80 0 0 5 2 0.009  
i.  .   .5    .     272.80 136.40 0 0 5 2 0.009  
i.  .   .5    .     310.20 155.10 0 0 5 2 0.009  
i.  .   .3333 .     374.00 187.00 0 0 5 2 0.009  
i.  .   .6667  8500 303.60 151.80 0 0 5 2 0.009  
;M.40, Tsig. 4/4.
i13 150 .4   7500 319.00 159.50 0 0 5 2 0.009 ;omnis; 
i.  +   .4  .     607.20 303.60 0 0 5 2 0.009  
i.  .   .4  .     310.00 155.10 0 0 5 2 0.009  
i.  .   .4   8000 272.80 136.40 0 0 5 2 0.009  
i.  .   .4  .     356.40 178.20 0 0 5 2 0.009  
i.  152 .25  7000 178.20  89.10 0 0 5 2 0.009 ;spiritus; 
i.  +   .25 .     327.80 163.90 0 0 5 2 0.009  
i.  .   .25 .     272.80 136.40 0 0 5 2 0.009  
i.  .   .25 .     172.70  86.35 0 0 5 2 0.009  
i.  .   .25 .     272.80 136.40 0 0 5 2 0.009  
i.  .   .25 .     365.20 182.60 0 0 5 2 0.009  
i.  .   .25 .     187.00  93.50 0 0 5 2 0.009  
i.  .   .25  9000 178.20  89.10 0 0 5 2 0.009  

;M.41, Tsig.4/4.
i12 154 .1667  7000 561.60 297.80 0 0 5 2 0.009 ;laudet; 
i.  +   .1667 .     443.00 223.00 0 0 5 2 0.009  
i.  .   .1667  8000 377.00 190.00 0 0 5 2 0.009  
i.  .   .1667  7000 478.20 240.60 0 0 5 2 0.009  
i.  .   .1667 .     247.20 125.10 0 0 5 2 0.009  
i.  .   .1667  9000 368.20 185.60 0 0 5 2 0.009  
i.  155 .1667  7000 365.20 182.60 0 0 5 2 0.009  
i.  +   .1667 .     247.20 125.10 0 0 5 2 0.009
i.  .   .1667  8000 478.20 240.60 0 0 5 2 0.009
i.  .   .1667  7050 377.00 190.00 0 0 5 2 0.009
i.  .   .1667 .     443.00 223.00 0 0 5 2 0.009
i.  .   .1667  9000 592.60 297.80 0 0 5 2 0.009
i.  156 .2857  6000 478.20 240.60 0 0 5 2 0.009 ;dominum; 
i.  +   .2857 .     641.00 322.00 0 0 5 2 0.009  
i.  .   .2857 .     306.60 154.80 0 0 5 2 0.009  
i.  .   .2857 .     276.80 139.40 0 0 5 2 0.009  
i.  .   .2857 .     313.20 158.10 0 0 5 2 0.009  
i.  .   .2857 .     377.00 190.00 0 0 5 2 0.009  
i.  .   .2857  8000 306.60 154.80 0 0 5 2 0.009  
;M.41, Tsig.4/4.
i12 154 .1667  7000 589.60 294.80 0 0 5 2 0.009  
i.  +   .1667 .     440.00 220.00 0 0 5 2 0.009  
i.  .   .1667  8000 374.00 187.00 0 0 5 2 0.009  
i.  .   .1667  7000 475.20 237.60 0 0 5 2 0.009  
i.  .   .1667 .     244.20 122.10 0 0 5 2 0.009  
i.  .   .1667  9000 365.20 182.60 0 0 5 2 0.009  
i.  155 .1667  7000 365.20 182.60 0 0 5 2 0.009  
i.  +   .1667 .     244.20 122.10 0 0 5 2 0.009
i.  .   .1667  8000 475.20 237.60 0 0 5 2 0.009
i.  .   .1667  7050 374.00 187.00 0 0 5 2 0.009
i.  .   .1667 .     440.00 220.00 0 0 5 2 0.009
i.  .   .1667  9000 589.60 294.80 0 0 5 2 0.009
i.  156 .2857  6000 475.20 237.60 0 0 5 2 0.009 
i.  +   .2857 .     638.00 319.00 0 0 5 2 0.009  
i.  .   .2857 .     303.60 151.80 0 0 5 2 0.009  
i.  .   .2857 .     272.80 136.40 0 0 5 2 0.009  
i.  .   .2857 .     310.20 155.10 0 0 5 2 0.009  
i.  .   .2857 .     374.00 187.00 0 0 5 2 0.009  
i.  .   .2857  8000 303.60 151.80 0 0 5 2 0.009  

;M.42, Tsig.4/4.
i8 158 .125  7500 220.00 110.00 .1 5 2 2 0.009 ;alleluia; 
i. +   .25  <     294.80 147.45 .1 5 2 2 0.009  
i. .   .25  <     589.60 294.80 .1 5 2 2 0.009 
i. .   .5   <     488.40 244.20 .1 5 2 2 0.009  
i. .   .75  <     589.60 294.80 .1 5 2 2 0.009  
i. .  1      7000 748.00 374.00 .1 5 2 2 0.009  
i. .  1.5   <     545.60 272.80 .1 5 2 2 0.009  
i. .  4      8500 440.00 220.00 .1 5 2 2 0.009
;M.42, Tsig.4/4.
i8 158 .125  7500 223.00 113.00 .1 5 2 2 0.009  
i. +   .25  <     297.80 150.45 .1 5 2 2 0.009  
i. .   .25  <     592.60 297.80 .1 5 2 2 0.009 
i. .   .5   <     491.40 247.20 .1 5 2 2 0.009  
i. .   .75  <     592.60 297.80 .1 5 2 2 0.009  
i. .  1      7000 751.00 377.00 .1 5 2 2 0.009  
i. .  1.5   <     548.60 275.80 .1 5 2 2 0.009  
i. .  4      8500 443.00 223.00 .1 5 2 2 0.009
;M.42, Tsig.4/4.
i12 158 .125  7500 220.00 110.00 0 0 5 2 0.009  
i.  +   .25  <     294.80 147.45 0 0 5 2 0.009  
i.  .   .25  <     589.60 294.80 0 0 5 2 0.009 
i.  .   .5   <     488.40 244.20 0 0 5 2 0.009  
i.  .   .75  <     589.60 294.80 0 0 5 2 0.009  
i.  .  1      7000 748.00 374.00 0 0 5 2 0.009  
i.  .  1.5   <     545.60 272.80 0 0 5 2 0.009  
i.  .  4      8500 440.00 220.00 0 0 5 2 0.009
;M.42, Tsig.4/4.
i12 158 .125  7500 223.00 113.00 0 0 5 2 0.009  
i.  +   .25  <     297.80 150.45 0 0 5 2 0.009  
i.  .   .25  <     592.60 297.80 0 0 5 2 0.009 
i.  .   .5   <     491.40 247.20 0 0 5 2 0.009  
i.  .   .75  <     592.60 297.80 0 0 5 2 0.009  
i.  .  1      7000 751.00 377.00 0 0 5 2 0.009  
i.  .  1.5   <     548.60 275.80 0 0 5 2 0.009  
i.  .  4      8500 443.00 223.00 0 0 5 2 0.009
e
;===============================< III >===============================;