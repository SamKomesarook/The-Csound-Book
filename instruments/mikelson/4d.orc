; ORCHESTRA
; TERRAIN MAPPING
; CODED BY HANS MIKELSON FEBRUARY 13, 1998

sr        =         44100
kr        =         4410 
ksmps     =         10
nchnls    =         2

          zakinit   50, 50

; 4D
; w       =         sin^2*(sqrt(x^2+y^2+z^2))
          instr     4

idur      =         p3
iamp      =         p4
ifqc      =         cpspch(p5)

kdclick   linseg    0, .002, iamp, idur-.004, iamp, .002, 0
krminor   linseg    .5, idur/2, 5, idur/2, .5
krmajor   =         krminor+1

asin1     oscil     krminor, ifqc, 1
acos1     oscil     krminor, ifqc, 1, .25
asin2     oscil     krmajor, ifqc/4, 1
acos2     oscil     krmajor, ifqc/4, 1, .25

ax        =         asin1+acos2
ay        =         acos1
az        =         asin2

az1       =         sin(sqrt(ax*ax+ay*ay+az*az))   ; Compute the surface
az        =         az1*az1-.5

          outs      az*kdclick, az*kdclick

          endin

; 4D
; w       =         sin^2*(sqrt(x^2+y^2+z^2))
          instr     5

idur      =         p3
iamp      =         p4
ifqc      =         cpspch(p5)
ioutch1   =         p6
ioutch2   =         p7
ioutch3   =         p8
ioutch4   =         p9

kdclick   linseg    0, .002, iamp, idur-.004, iamp, .002, 0
krminor   linseg    .5, idur/2, 5, idur/2, .5
krmajor   =         krminor+1

asin1     oscil     krminor, ifqc, 1
acos1     oscil     krminor, ifqc, 1, .25
asin2     oscil     krmajor, ifqc/4, 1
acos2     oscil     krmajor, ifqc/4, 1, .25

ax        =         asin1+acos2
ay        =         acos1
az        =         asin2

aw1       =         sin(sqrt(ax*ax+ay*ay+az*az))   ; Compute the surface
aw        =         aw1*aw1-.5

          zaw       ax*kdclick, ioutch1
          zaw       ay*kdclick, ioutch2
          zaw       az*kdclick, ioutch3
          zaw       aw*kdclick*10, ioutch4

          endin

; 3 SPACE PLANAR ROTATIONS
          instr 50

ifqc      =         p4
iphase    =         p5
iplane    =         p6
inx       =         p7
iny       =         p8
inz       =         p9
ioutx     =         p10
iouty     =         p11
ioutz     =         p12

kcost     oscil     1, ifqc,   1, .25+iphase
ksint     oscil     1, ifqc,   1, iphase

ax        zar       inx
ay        zar       iny
az        zar       inz

; ROTATION IN X-Y PLANE
          if        (iplane!=1) goto next1
axr       =         ax*kcost + ay*ksint
ayr       =         -ax*ksint + ay*kcost
azr       =         az
          goto      next3

; ROTATION IN X-Z PLANE
next1:
          if        (iplane!=2) goto next2
axr       =         ax*kcost + az*ksint
ayr       =         ay
azr       =         -ax*ksint + az*kcost
          goto      next 3

; ROTATION IN Y-Z PLANE
next2:
axr       =         ax
ayr       =         ay*kcost + az*ksint
azr       =         -ay*ksint + az*kcost

next3:
          zaw       axr, ioutx
          zaw       ayr, iouty
          zaw       azr, ioutz

          endin

; 4 SPACE PLANAR ROTATIONS
          instr 51
     
ifqc      =         p4
iphase    =         p5
iplane    =         p6
inx       =         p7
iny       =         p8
inz       =         p9
inw       =         p10
ioutx     =         p11
iouty     =         p12
ioutz     =         p13
ioutw     =         p14

kcost     oscil     1, ifqc,   1, .25+iphase
ksint     oscil     1, ifqc,   1, iphase

ax        zar       inx
ay        zar       iny
az        zar       inz
aw        zar       inw

; ROTATION IN X-Y PLANE
          if        (iplane!=1) goto next1
axr       =         ax*kcost + ay*ksint
ayr       =         -ax*ksint + ay*kcost
azr       =         az
awr       =         aw
          goto      nextend

; ROTATION IN X-Z PLANE
next1:
          if        (iplane!=2) goto next2
axr       =         ax*kcost + az*ksint
ayr       =         ay
azr       =         -ax*ksint + az*kcost
awr       =         aw
          goto      nextend

; ROTATION IN Y-Z PLANE
next2:
          if        (iplane!=3) goto next3
axr       =         ax
ayr       =         ay*kcost + az*ksint
azr       =         -ay*ksint + az*kcost
awr       =         aw
          goto           nextend

; ROTATION IN X-W PLANE
next3:
          if        (iplane!=4) goto next4
axr       =         ax*kcost + aw*ksint
ayr       =         ay
azr       =         az
awr       =         -ax*ksint + aw*kcost
          goto      nextend

; ROTATION IN Y-W PLANE
next4:
          if    (iplane!=5) goto next5
axr       =         ax
ayr       =         ay*kcost + az*ksint
azr       =         az
awr       =         -ay*ksint + aw*kcost
          goto      nextend

; ROTATION IN Z-W PLANE
next5:
          if        (iplane!=6) goto nextend
axr       =         ax
ayr       =         ay
azr       =         az*kcost + aw*ksint
awr       =         -az*ksint + aw*kcost

nextend:
          zaw       axr, ioutx
          zaw       ayr, iouty
          zaw       azr, ioutz
          zaw       awr, ioutw

endin

;---------------------------------------------------------------------------
; MIXER SECTION
;---------------------------------------------------------------------------
          instr 100

idur      =         p3
iamp      =         p4
inch1     =         p5
inch2     =         p6

ain1      zar       inch1
ain2      zar       inch2

          outs      ain1*iamp, ain2*iamp

          endin

;---------------------------------------------------------------------------
; CLEAR AUDIO & CONTROL CHANNELS
;---------------------------------------------------------------------------
          instr 110

          zacl      0, 50                    ; CLEAR AUDIO CHANNELS 0 TO 30
          zkcl      0, 50                    ; CLEAR CONTROL CHANNELS 0 TO 30
                                             
          endin
