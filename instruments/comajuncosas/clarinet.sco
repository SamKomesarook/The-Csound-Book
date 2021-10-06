f1 0 8192 10 1
; TUNING TABLE CALIBRATED FROM 55 HZ UP TO 2640 HZ
; THIS TABLE GOES FROM DC TO 0.08*SR ONLY !
f2 0 8193 -27 0 1 128 1.0784 256 1.0784 512 1.1340 1024 1.2754 1536 1.3924 2048 1.4915 4096 2.1027 5120 2.4472 6144 2.8758 8192 3.478 

; NOTE THE CLARINET IS STILL TERRIBLY OUT OF TUNE
; DATA USED FOR THIS TABLE :
; EXPECTED FREQ.   -> CORR. FACTOR (MULTIPLY EXPECTED FREQ. BY THIS)
;55   =  0.001*sr ->  * 1.0784 (at  0.015th of the table length):point 128
;110  =  0.0025*sr->  * 1.0784 (at  0.031th of the table length):point 256
;220  =  0.005*sr ->  * 1.1340 (at  0.0625th of the table length):point 512
;440  =  0.01*sr  ->  * 1.2754 (id. at  0.125):point 1024
;660  =  0.015*sr ->  * 1.3924 :point 1536
;880  =  0.02*sr  ->  * 1.4915 (id. at  0.25):point 2048
;1320 =  0.03*sr  ->  * 1.8308 :point 3072
;1760 =  0.04*sr  ->  * 2.1027 (id. at 0.5):point 4096
;1980 =  0.045*sr ->  * 2.2423 :point 4096
;2200 =  0.05*sr  ->  * 2.4472 :point 5120
;2640 =  0.06*sr  ->  * 2.8758 :point 6144
;3520 =  0.08*sr  ->  * 3.478  (id. at 1):point 8192

t  0 90
; I1: INSTRUMENT NUMBER
; PARAMETER 2: START TIME OF NOTE EVENT
; PARAMETER 3: DURATION OF NOTE EVENT

f0 50
i2 0 50 1500
e 
