
;***********************************   AN AUDITORY ILLUSION   ************************************
; PRESENTING CERTAIN TONE SEQUENCES TO BOTH EARS PRODUCES SOME INTERESTING AUDITORY ILLUSIONS, IN-
; CLUDING THE ONE DEMONSTRATION, DESCRIBED BY DEUTSCH (1975).
; TONES OF 400 AND 800HZ ALTERNATE IN BOTH EARS IN OPPOSITE PHASE; THAT IS, WHEN THE LEFT EAR RE-
; CEIVES 400HZ, THE RIGHT EAR RECEIVES 800HZ. ABOUT 99% OF LISTENERS HEAR A SINGLE LOW-FREQUENCY 
; TONE IN ONE EAR AND A HIGH-FREQUENCY TONE IN THE OTHER EAR. QUITE REMARKABLY, WHEN THE HEAD-
; PHONES ARE REVERSED, MOST LISTENERS HEAR THE HIGH TONE AND THE LOW TONE IN THE SAME EARS AS BE-
; FORE (DEUTSCH, 1974).
; RIGHT-HANDED SUBJECTS USUALLY HEAR THE HIGH TONE IN THEIR RIGHT EAR AND THE LOW TONE IN THEIR
; LEFT EAR, REGARDLESS OF HOW THE HEADPHONES ARE ORIENTED. LEFT-HANDED SUBJECTS, ON THE OTHER HAND
; ARE JUST AS LIKELY TO HEAR THE HIGH TONE IN THE RIGHT EAR AS IN THE LEFT. THIS IS BECAUSE IN 
; RIGHT-HANDED PEOPLE, THE LEFT HEMISPHERE IS DOMINANT (AND ITS PRIMARY AUDITORY INPUT IS FROM
; THE RIGHT EAR), WHEREAS IN LEFT-HANDED PEOPLE, EITHER HEMISPHERE MAY BE DOMINANT. HIGH TONES ARE
; PERCEIVED AS BEING HEARD AT THE EAR THAT FEEDS THE DOMINANT HEMISPHERE (DEUTSCH, 1975).              
;*****************************************   HEADER   ********************************************           

sr             =         44100
kr             =         4410
ksmps          =         10
nchnls         =         2

 instr         1

 iamp          =         ampdb(p4)                ;P4 = AMPLITUDE IN DB 
 ifreq         =         p5                       ;P5 = FREQUENCY
                                                  ;P6 = PANNING FUNCTION FOR SIGNAL

 k1            linen     iamp,.05,p3,.05         
 a1            oscili    k1,ifreq,1             
 k2            oscili    1,p3,p6
 kleft         =         sqrt (k2)
 kright        =         sqrt (1-k2)
 aleft         =         a1 * kleft
 aright        =         a1 * kright
               outs      aleft,aright 
 endin  


              

