<CsoundSynthesizer>
<CsOptions>

; normal realtime operation: (for DirectCSound, edit if necessary)
;-+O -m0 -d -+X1 -+K -b140

;====================================================================================
; ALGOCOMP.CSD
; A sample instrument for realtime algorithmic composition in CSound
; Written by Peter Neubaecker <peter@neubaecker.de>
;------------------------------------------------------------------------------------
; 
; The purpose of this instrument is to generate algorithmic compositions
; by Csound directly. There is one event-generating instrument and one
; or more sound-generating instruments. There are multiple instances of the 
; sound-generating instruments allocated and indexed. The number of instances
; correponds to the intended polyphony - but they can be allocated generously
; as an inactive instance is very inexpensive in time. The event-generating
; instrument knows these instances by index and communicates with them over
; global table space. Each time the event-generating instrument assigns a new
; duration to an instance, that instance initialises itself, reads its individual
; parameters from the communication table, then runs and becomes inactive after 
; the given duration.
; In this example, the event-generating instrument only writes initialisation
; values for each sound-generating instance that are used by that instruments
; like usual p-fields. But the event-generating instrument could also update  
; the individal parameters continuously.
; 
;------------------------------------------------------------------------------------

</CsOptions>
<CsScore>


;====================================================================================
; SCORE
;------------------------------------------------------------------------------------

f 1 0 1024 -10 1 0.5 0.1 0.2 0.3

f 0 60        ; run for ... seconds

i 1 0 1       ; start realtime composing instrument

i 2.01 0 1    ; some instances of sound instruments
i 2.02 0 1    ; allocate sufficient instances
i 2.03 0 1    ; for overlapping notes
i 2.04 0 1
i 2.05 0 1    ; cave: fractional part of instrument number
i 2.06 0 1    ; is necessary for allocation 
i 2.07 0 1    ; of multiple instances with ihold
i 2.08 0 1
i 2.09 0 1
i 2.10 0 1
i 2.11 0 1
i 2.12 0 1

e
;------------------------------------------------------------------------------------

</CsScore>
<CsInstruments>

;====================================================================================
; ORCHESTRA
;------------------------------------------------------------------------------------

;====================================================================================
; Initialisaton
;------------------------------------------------------------------------------------
sr          =    44100                         ;
kr          =    441                           ;
ksmps       =    100                           ;
nchnls      =    2                             ;
                                               ;
gindex      init 0                             ; Index for instrument instances
zakinit     1,   300                           ; Create zak table space
giampoffs   =    100                           ; zak table offsets for parameters
gicpsoffs   =    200                           ;
giwave      =    1                             ;
                                               ;
;------------------------------------------------------------------------------------



;====================================================================================
instr 1          ; example event generating instrument: a simple fractal loop
;------------------------------------------------------------------------------------
ihold                                          ; Run forever
                                               ;
icnt     =       12                            ; No. of instances allocated in score
kindx    init    0.5                           ;
kx1      init    0                             ;
kx2      init    0                             ;
                                               ;
idur     =       1.5                           ;
ispeed   =       6                             ;
                                               ;
ktime    phasor  ispeed                        ; Timer for event generation
ktrig    trigger ktime, 0.5, 0                 ;
if (ktrig<0.5)   goto noevent                  ;
                                               ;
kx1      =       kx1 * kx1 - 1.74              ; Some simple fractal
kx2      =       kx2 * kx2 - 1.7499            ; parameter generation
kamp     =       0.05 + (kx2+2) / 4 * 0.9      ;
kcps     =       200 + 100 * kx1 / 2           ;
                                               ;
         zkw     idur, kindx                   ; Write duration as start trigger
         zkw     kamp, giampoffs + kindx       ; and parameters for new note
         zkw     kcps, gicpsoffs + kindx       ; to zak table
                                               ;
kindx    =       kindx + 1                     ; Cycle through available 
kindx    =       (kindx > icnt ? 0.5 : kindx)  ; instrument instances
                                               ; as allocated in score
noevent:                                       ;
                                               ;
endin                                          ;
;------------------------------------------------------------------------------------



;====================================================================================
instr 2           ; sound generating instrument
;------------------------------------------------------------------------------------
ihold                                          ; Run forever
index    =        gindex + 0.5                 ; Assign unique instance index
gindex   =        gindex + 1                   ; for individual parameter reading
kamp0    init     -1                           ;
knewdur  init     -1                           ;
         igoto    inactive                     ; Don't init before being called
                                               ;
if (kamp0<0) goto inactive                     ;
                                               ;
newinit:                                       ; NEW INIT AT EACH CALL
idur     init     i(knewdur)                   ; Get duration from zak table value
         ziw      -1, index                    ; and reset start trigger in zak table
kamp0    init     1                            ; kamp0 will inactivate instrument
kamp0    linseg   1, idur-0.02, 1, 0.02, 0     ; after given duration when kamp0 < 0
                                               ; (HAS TO BE ramped down at end!)
                                               ;
;--------------------------------------------- ; Usual initialisation and
                                               ; sound generating code goes here...
kamp1    zkr      giampoffs + index            ; Get parameters from zak table
kcps     zkr      gicpsoffs + index            ; instead of p-fields
                                               ;
kenv     expon    1, 1, 0.01                   ;
kamp     =        20000*kamp0*kamp1*kenv       ;
aamp     interp   kamp                         ;
asig     oscili   aamp, kcps, giwave           ;
         outs     asig, asig                   ;
                                               ;
;--------------------------------------------- ;
                                               ;
inactive:                                      ;
knewdur  zkr      index                        ; Check for new start
if (knewdur <= 0) goto continue                ;
reinit   newinit                               ; and reinitialize if new
continue:                                      ;
                                               ;
endin                                          ;
;------------------------------------------------------------------------------------


</CsInstruments>
</CsoundSynthesizer>




