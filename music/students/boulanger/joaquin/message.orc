
;    MESSAGE FROM ANOTHER PLANET  (SPRING 1999)
;
;    COMPOSED BY  JACOB JOAQUIN
;    YOU CAN CONTACT ME VIA E-MAIL @ jake.ke@ix.netcom.com
;
;
;

;
;    TO SEARCH FOR EXTRATERRESTRIAL INTELLIGENCE FROM YOUR HOME COMPUTER VISIT
;    http://www.seti.org/setiathome.html




sr        =         44100
kr        =         4410
ksmps     =         10
nchnls    =         2

          instr 2
ipch      =         cpspch(p5)

imult     =         ((p6+1) / p6) * .5
iseed     =         (rnd(100)+100)/200

k2        expseg    .0625, 15, .0625, 113, 3.75, 113, .03125, 15, .0625
k3        linseg    1, 240, 1, 16, 0
k1        phasor    p7 * k2
k1        tablei    256 * k1 , 100, 0, 0, 1
krand     randi     30000, p7 * 5, iseed
krand     =         (krand + 30000) / 60000
a1        oscil     p4 * imult * k1 * k3, ipch * p6, 1
          outs      a1 * sqrt(krand), a1 * (sqrt(1-krand))

          endin

