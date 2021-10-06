sr             =         44100
kr             =         4410
ksmps          =         10
nchnls         =         2

ga1            init      0
ga2            init      0

               instr     1
    icps       cpsmidi
    iamp       ampmidi   20000, 100
    iscale1    =         iamp * .25
    isem       =         .059463094
    kpbend     pchbend   2*isem*icps
    kctl10    midictrl  	10
    kctl10     =         kctl10/127
    kctl7     midictrl  	7
    kctl7      =         kctl7/127
    kmodw     midictrl  	1
    aeg1       linenr    iscale1, .8, .2, .2
    a4         oscil     aeg1, icps*.999 + kpbend + kmodw, 1
    a3         oscil     aeg1, icps*.997 + kpbend + kmodw, 1
    a2         oscil     aeg1, icps*1.003 + kpbend + kmodw, 1
    a1         oscil     aeg1, icps + kpbend + kmodw, 1
    a1         =         a1 + a2 + a3 + a4 
               outs      a1*kctl7*kctl10, a1*kctl7*(1-kctl10)
endin

instr          2
    icps       cpsmidi
    iamp       ampmidi   20000, 100
    iscale2    =         iamp * 0.333
    kctl7     midictrl  7
    kctl7      =         kctl7/127
    a3         pluck     iscale2, icps*1.002, icps*1.002, 0, 1
    a2         pluck     iscale2, icps, icps, 0, 1 
    a1         pluck     iscale2, icps*.998, icps*.998, 0, 1
    a1         =         a1 + a2 + a3
    aoutl      =         a1 * 0.5
    aoutr      =         a1 * 0.5
    ga2        =         aoutl * 0.1
    ga1        =         aoutr * 0.1
               outs      aoutl*kctl7, aoutr*kctl7
endin

instr 3
    icps       cpsmidi
    iamp       ampmidi   15000, 100
    iscale1    =         iamp * .25
    isem       =         .059463094
    kpbend     pchbend   2*isem*icps
    kctl10    midictrl  10
    kctl10     =         kctl10/127
    kctl7     midictrl  7
    kctl7      =         kctl7/127
    kmodw     midictrl  1
    aeg1       linenr    iscale1, .8, .2, .2
    a4         oscil     aeg1, icps*.999 + kpbend + kmodw, 1
    a3         oscil     aeg1, icps*.997 + kpbend + kmodw, 1
    a2         oscil     aeg1, icps*1.003 + kpbend + kmodw, 1
    a1         oscil     aeg1, icps + kpbend + kmodw, 1
    a1         =         a1 + a2 + a3 + a4 
    a1         =         a1 + a2 + a3 + a4 
               outs      a1*kctl7*kctl10, a1*kctl7*(1-kctl10)
endin

instr          4
    icps       cpsmidi
    iamp       ampmidi   5000, 100
    kctl1     midictrl  1
    kctl1      =         kctl1/127
    kctl4     midictrl  4
    kctl4      =         kctl4/127
    kctl7     midictrl  7
    kctl7      =         kctl7/127
    keg        linenr    5000, 0.8, 0.8, 0.01
    aoscm      oscil     1000*kctl1, icps/5, 2
    aosc       oscil     keg, icps+aoscm, 2
               outs      aosc*kctl7, aosc*kctl7
endin

instr 5
     a1        soundin   "55.aif", 0, 4
     aoutl     =         a1 * 0.5
     aoutr     =         a1 * 0.5
     ga2       =         aoutl * 0.4
     ga1       =         aoutr * 0.4
               outs      aoutl, aoutr
endin

instr 6
     a1        soundin   "66.aif", 0, 4
     aoutl     =         a1 * 0.5
     aoutr     =         a1 * 0.5
     ga2       =         aoutl * 0.4
     ga1       =         aoutr * 0.4
               outs      aoutl, aoutr
endin

instr 7
     a1        soundin   "77.aif", 0, 4
     aoutl     =         a1 * 0.5
    aoutr      =         a1 * 0.5
    ga2        =         aoutl * 0.4
    ga1        =         aoutr * 0.4
               outs      aoutl, aoutr
endin

instr          9
     a1        soundin   "99.aif", 0, 4
     aoutl     =         a1 * 0.5
     aoutr     =         a1 * 0.5
     ga2       =         aoutl * 0.4
     ga1       =         aoutr * 0.4
               outs      aoutl, aoutr
endin


instr 8                 
     kctl7    midictrl  7
     kctl7     =         kctl7/127
     ilowpass  =         9000
     idel1     =         1237.000/sr
     idel2     =         1381.000/sr
     idel3     =         1607.000/sr
     idel4     =         1777.000/sr
     idel5     =         1949.000/sr
     idel6     =         2063.000/sr
     idel7     =         307.000/sr
     idel8     =         97.000/sr
     idel9     =         71.000/sr
     idel10    =         53.000/sr
     idel11    =         47.000/sr
     idel12    =         37.000/sr
     idel13    =         31.000/sr
     icsc1     =         .822 * 3
     icsc2     =         .802 * 3
     icsc3     =         .773 * 3
     icsc4     =         .753 * 3
     icsc5     =         .753 * 3
     icsc6     =         .753 * 3
     icsc7     =         .7 * 3
     acomb1    comb      ga1, icsc1, idel1
     acomb2    comb      ga1, icsc2, idel2
     acomb3    comb      ga1, icsc3, idel3
     acomb4    comb      ga1, icsc4, idel4
     acomb5    comb      ga1, icsc5, idel5
     acomb6    comb      ga1, icsc6, idel6
     acomball  =         acomb1 + acomb2 + acomb3 + acomb4 + acomb5 + acomb6
     allp1     alpass    acomball, icsc7, idel7
     allp2     alpass    allp1, icsc7, idel8
     allp3     alpass    allp2, icsc7, idel9
     alow      tone      allp3, ilowpass
     allp4     alpass    alow, icsc7, idel10
     allp5     alpass    allp4, icsc7, idel12
     arevout1  =         allp5 * 1
     acomb1    comb      ga2, icsc1, idel1
     acomb2    comb      ga2, icsc2, idel2
     acomb3    comb      ga2, icsc3, idel3
     acomb4    comb      ga2, icsc4, idel4
     acomb5    comb      ga2, icsc5, idel5
     acomb6    comb      ga2, icsc6, idel6
     acomball  =         acomb1 + acomb2 + acomb3 + acomb4 + acomb5 + acomb6
     allp1     alpass    acomball, icsc7, idel7
     allp2     alpass    allp1, icsc7, idel8
     allp3     alpass    allp2, icsc7, idel9
     alow      tone      allp3, ilowpass
     allp4     alpass    alow, icsc7, idel10
     allp6     alpass    allp4,icsc7, idel13
     arevout2  =         allp6 * 1
               outs      arevout1*kctl7, arevout2*kctl7
     ga1       =         0
     ga2       =         0
endin



