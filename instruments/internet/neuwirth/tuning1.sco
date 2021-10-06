;Erich Neuwirth <neuwirth@smc.univie.ac.at>
;Computer Supported Didactics Working Group, Univ. Vienna
;Visit our SunSITE at http://sunsite.univie.ac.at
;tuning.sco                        

f1 0 4096 10 1                     ; use GEN10 to compute a sine wave
f4 0 1024 7 0 23 0.948 15 1.000 17 0.973 10 0.869 503 1.000 388 0.921 28 0.697 10 0.408 17 0.092 13 0 ; master envelope
f5 0 1024 7 0 23 0.948 15 1.000 17 0.973 10 0.869 0 0.0 959 0 ; attack
f6 0 1024 7 0.0  570 1.0 454 0.0  ; decay hump 
f7 0 1024 7 1.0 28 0.757 10 0.443 17 0.010 13 0 956 0 ; release shape
f8 0 1024 7 0.0 177 0.948 115 1.000 131 0.973 77 0.869 216 0.658 77 0.385 131 0.087 100 0  ; envelope for short notes


s
  i1      0    0.5   8000   264
  i1      0.5  0.5   8000   330
  i1      1    0.5   8000   396

  i1      1.5  1   8000   264
  i1      1.5  1   8000   330
  i1      1.5  1   8000   396

  i1      2.5  0.5 8000   792
  i1      3    1   8000   792
  i1      4    0.5 8000   660
  i1      4.5  1   8000   660
