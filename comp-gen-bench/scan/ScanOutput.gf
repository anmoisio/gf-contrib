
concrete ScanOutput of Scan = {

    lincat Utt, ConjImp, Imp, VP, Adv, Verb, VD, V = {s : Str};

    lin
        UseConjImp imp = imp ;
        UseImp     imp = imp ;

        CoordImp    imp1 imp2 = {s = imp1.s ++ imp2.s} ;
        CoordImpInv imp1 imp2 = {s = imp2.s ++ imp1.s} ;
        
        ImpVP  vp = vp ;
        Twice  vp = {s = vp.s ++ vp.s} ;
        Thrice vp = {s = vp.s ++ vp.s ++ vp.s} ;

        UseV        v   = v ;
        DirVP       v adv = {s = adv.s ++ v.s} ;
        OppositeVP  v adv = {s = adv.s ++ adv.s ++ v.s} ;
        AroundVP    v adv = {s = adv.s ++ v.s ++
                                 adv.s ++ v.s ++
                                 adv.s ++ v.s ++
                                 adv.s ++ v.s} ;

        VVerb  v  = v ;
        VDVerb _  = {s = []} ;

        left_Adv  = {s = "I_TURN_LEFT"} ;
        right_Adv = {s = "I_TURN_RIGHT"} ;
        turn_VD   = {s = ""} ;
        walk_V    = {s = "I_WALK"} ;
        run_V     = {s = "I_RUN"} ;
        jump_V    = {s = "I_JUMP"} ;
        look_V    = {s = "I_LOOK"} ;
}
