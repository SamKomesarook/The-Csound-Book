;; Within.orc
;; Grant Chu Covell
;; gcovell@c-bridge.com
;; 1.0: 21 December 1997
;; 1.1: 15 March 1999


sr              = 44100
kr              = 44100
ksmps   = 1
nchnls  = 2


gasigl  init 0
gasigr  init 0
girvt           init 0
gistr           init 0


instr 29
        ;; CONSTANTS
        i44ftblnum              = 144
        i44ftbllen              = 44
        ivaltblfnum             = 128
        ivaltbllen              = 128   ;; idx to be 0 to 127
        ipchtblfnum             = 244
        inumpchs                = 44
        
        ;; INITS
        idurtotal               = p3
        iseed                   = p4
        iusenomeths             = p5
        
        seed                    iseed   
        ipchidx         = 0
        itt                     = 0
        iextend         = 0
        
        core:                   
                
                ;; HOW TO STOP
                if ipchidx < inumpchs goto continue
                        itimenow       times
                        iextend = idurtotal - itimenow
                        print   iseed, itimenow, iextend
                        turnoff
                
                ;; LABEL WHICH STARTS EVERYTHING
                continue:       

                ;; SELECT THE PITCH
                ipitch          table ipchidx, ipchtblfnum
                
                ;; SELECT FTABLE
                iidxftbl                unirand ( i44ftbllen )
                iidxftbl                = int ( iidxftbl )
                iftbl                   table iidxftbl, i44ftblnum
                
                ;; select optional ftable
                iftblopt                unirand ( 44 )
                iftblopt                = int ( iftblopt ) + 1
        
                ;; DEPLETE FTABLE (REMOVE SELECTED FTABLE)
                iidxold0                = iidxftbl                      
                centerloop0:    
                        ival0   table iidxold0 + 1, i44ftblnum
                        tableiw         ival0, iidxold0, i44ftblnum
                        iidxold0        = iidxold0 + 1
                                        
                        if iidxold0 < i44ftbllen goto centerloop0                       
                i44ftbllen              = i44ftbllen - 1

                ;; FOR TESTING THE FTABLE
                ;;iidxval0              = 0
                ;;testtable0:
                ;;      ival0    table iidxval0, i44ftblnum
                ;;      ;;print iidxval0, ival0, iidxftbl, iftbl
                ;;      iidxval0        = iidxval0 + 1
                ;;      if iidxval0 < i44ftbllen goto testtable0
                ;;
                
                ;; SELECT DURATION
                iidxdur         unirand ( ivaltbllen ) 
                iidxdur         = int ( iidxdur )       
                idurdur         table iidxdur, ivaltblfnum

                ;; DEPLETE VALUE TABLE (REMOVE SELECTED DURATION)
                iidxold1                = iidxdur                       
                centerloop1:    
                        ival1   table iidxold1 + 1, ivaltblfnum
                        tableiw         ival1, iidxold1, ivaltblfnum
                        iidxold1        = iidxold1 + 1
                                        
                        if iidxold1 < ivaltbllen goto centerloop1                       
                ivaltbllen              = ivaltbllen - 1

                ;; FOR TESTING THE VALUE TABLE
                ;;iidxval1              = 0
                ;;testtable1:
                ;;      ival1           table iidxval1, ivaltblfnum
                ;;      ;;print iidxval1, ival1, iidxdur, idurdur
                ;;      iidxval1        = iidxval1 + 1
                ;;      if iidxval1 < ivaltbllen goto testtable1
                ;;
                
                ;; SELECT SILENCE           
                iidxsil         unirand ( ivaltbllen ) 
                iidxsil         = int ( iidxsil )       
                idurint         table iidxsil, ivaltblfnum
                
                ;; DEPLETE VALUE TABLE (REMOVE SELECTED SILENCE)
                iidxold2                = iidxsil                               
                centerloop2:    
                        ival2   table iidxold2 + 1, ivaltblfnum
                        tableiw         ival2, iidxold2, ivaltblfnum
                        iidxold2        = iidxold2 + 1
                        
                        if iidxold2 < ivaltbllen goto centerloop2                                               
                ivaltbllen              = ivaltbllen - 1
                
                ;; FOR TESTING THE VALUE TABLE
                ;;iidxval2              = 0
                ;;testtable2:
                ;;      ival2   table iidxval2, ivaltblfnum
                ;;      ;;print iidxval2, ival2, iidxsil, idurint
                ;;      iidxval2        = iidxval2 + 1
                ;;      if iidxval2 < ivaltbllen goto testtable2
                ;;
                
                ;; SELECT A METHOD
                imeth                   unirand 11
                imeth                   = int ( imeth ) + 1
                
                ;; FUDGING, INCREMENTING                        
                ipchidx                 = ipchidx + 1                   
                inewdur         = idurdur * 2                   ;; **  PPC goes so fast that to get interrupt time
                inewint         = idurint * 1                   ;; **  make the 2 and 1 a 20 and 10 to slow down
                itt                     = itt + inewdur + inewint
        
                ;; STATUS LINES
                ;;print ipchidx
                ;;print ipchidx, ipitch, itt
                ;;print ipchidx, ipitch, inewdur, inewint, itt
                ;;print ipchidx, imeth, iftbl, iftblopt
                print   ipchidx, ipitch, imeth
                        
                        
                ;; EXTEND TO THE END?
                inewdur         = ( iextend = 0 ? inewdur : 0 )
                inewint         = ( iextend = 0 ? inewint : iextend )
                iplay                   = ( iextend = 0 ? 1 : 0 )
                ;;print         inewdur, inewint, iplay, iextend
                
                ;; PANNING
                ipans                   unirand 1
                ipane                   unirand 1
                irpans          unirand 1
                irpane          unirand 1
                ;;print         ipans, ipane
                
                ;; AMPL
                iampl                   unirand 3000
                iampl                   = iampl + 2000
                
                ;; REVERB
                girvt                   unirand .75
                gistr                   unirand .5
                gistr                   = gistr + .2
                irvboff         unirand 1.99
                irvboff         = int ( irvboff )
                ;;print         girvt, gistr, irvboff
                
                ;; SHAPING
                iline1          unirand 1
                iline2          unirand 1
                
                ;; THE TIMOUT LOOP      
                timout          0, inewdur + inewint, do
                        
        reinit core
        
        do:
                kshape          linseg  1, inewdur - .01, 1, .01, 0, inewint, 0
                kenv                    expseg  1, inewdur, .001, inewint, .001
                kline                   linseg  iline1, inewdur, iline2, inewint, 0     

                kplay                   line            iplay, inewdur + inewint, iplay
                kshape          =       kshape * kplay
                
                kpan                    line            ipans, inewdur + inewint, ipane
                krpan                   line            irpans, inewdur + inewint, irpane
                
                iftbl                   = ( iftbl = 0 ? 1 : iftbl )
                iftblopt                = ( iftblopt = 0 ? 1 : iftblopt )
                                
                ;; APPLY THE METHOD
                if iusenomeths = 0 goto methtwo
                if imeth = 1 goto methone
                if imeth = 2 goto methtwo
                if imeth = 3 goto meththr
                if imeth = 4 goto methfou
                if imeth = 5 goto methfiv
                if imeth = 6 goto methsix
                if imeth = 7 goto methsev
                if imeth = 8 goto metheig
                if imeth = 9 goto methnin
                if imeth = 10 goto methten
                if imeth = 11 goto methele
                
                methone:
                a1      pluck iampl, ipitch, ipitch * 5, 0, 3, .125
                a2      pluck   iampl * .7, ipitch, ipitch, 0, 1
                aa      = ( a1 + a2 ) * kenv
                        goto getout
                
                methtwo:
                iftbl   = ( iusenomeths = 0 ? 1 : iftbl )
                a1      oscili iampl, ipitch, iftbl
                aa      = a1
                        goto getout
                        
                meththr:
                a1      oscili iampl * .75, ipitch * .99, iftbl
                a2      oscili iampl * .75, ipitch * 1.01, iftbl
                a3      oscili iampl, ipitch, iftbl
                aa      = ( ( a1 + a2 ) * kline ) + a3
                        goto getout
                
                methfou:
                a1      oscili iampl * .5, ipitch + 10, iftbl
                a2      oscili iampl * .5, ipitch - 10, iftbl
                a3      oscili iampl, ipitch, iftbl
                aa      = ( ( a1 + a2 ) * kline ) + a3
                        goto getout
                                        
                methfiv:
                idegr1  unirand .02
                idegr2  unirand .02
                a1      oscili iampl * .5, ipitch * ( .49 + idegr1 ), iftbl
                a2      oscili iampl * .5, ipitch * ( .24 + idegr2 ), iftbl
                a3      oscili iampl, ipitch, iftbl
                aa              = ( ( a1 + a2 ) * kline ) + a3
                        goto getout

                methsix:
                a1      oscili iampl * .5, ipitch * .505, iftbl
                a2      oscili iampl, ipitch, iftbl
                aa      = ( a1 * kline ) + a2
                        goto getout

                methsev:
                idegr   = ipitch * .03
                ivibrs  unirand 3
                ivibre  unirand 3
                kvibr   linseg ivibrs, inewdur, ivibre, inewint, 0              
                k1      oscil   idegr, kvibr, 1
                kline   linseg .8, inewdur, .25, inewint, 0
                a1      oscil   iampl, ipitch + k1, iftbl
                a2      oscil   iampl, ipitch, iftbl
                aa      = ( a1 * kline ) + ( a2 * .6 )
                        goto getout

                metheig:
                idegr   unirand 10
                ivibrs  unirand 4
                ivibre  unirand 4
                kvibr   linseg ivibrs, inewdur, ivibre, inewint, 0
                k1      oscil   idegr, kvibr, iftblopt
                kline   linseg .8, inewdur, .25, inewint, 0
                a1      oscil   iampl, ipitch + k1, iftbl
                a2      oscil   iampl, ipitch, iftbl
                aa      = ( a1 * kline ) + ( a2 )
                        goto getout
                        
                methnin:
                aline   line iampl, inewdur + inewint, iampl
                k1      oscil 1, ipitch, iftblopt
                k2      oscil   1, ipitch, iftbl
                amult   = k1 * k2
                amult   balance amult, aline
                a1      oscili iampl, ipitch, iftbl
                aa      = ( a1 * .8 ) + ( amult * .5 )
                        goto getout
                        
                methten:
                k1      oscil   5, 5, 1
                a1      oscil   iampl, ipitch + k1, iftbl
                k2      oscil 1, ipitch, iftblopt
                k3      oscil   1, ipitch + k1, iftbl
                amult   = k2 * k3
                amult   balance amult, a1
                a1      oscili iampl, ipitch, iftbl
                aa      = ( a1 * .8 ) + ( amult * .5 )
                        goto getout
                        
                methele:
                iwdth   unirand 2
                iasig   unirand ipitch / 20
                a1      unirand iasig
                aflt    reson a1, ipitch - ( iwdth * 2 ), iwdth
                a2      oscili iampl, ipitch, iftbl
                aa      = aflt + ( a2 * .4 )
                irvboff = 0
                        goto getout
                        
                getout:
                outs    aa * kshape * kplay * kpan, aa * kshape * kplay * ( 1 - kpan )
                        gasigl = aa * kshape * kplay * irvboff * krpan
                        gasigr = aa * kshape * kplay * irvboff * ( 1 - krpan )
        rireturn
                
endin


;; reverb
instr 999
        al      reverb  gasigl, girvt
        ar      reverb  gasigr, girvt

        outs    al * gistr, ar * gistr

        gasigl = 0
        gasigr = 0

endin
