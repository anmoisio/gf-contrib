
concrete ScanOutput of Scan = {
    lincat Utt, ConjImp, Imp, VP, Adv, Verb, VD, V = {s : Str};

    oper linArg : {s : Str} -> {s : Str} = \arg -> {s = arg.s} ;

    lin
        UseConjImp  = linArg ;
        UseImp      = linArg ;

        CoordImp    imp1 imp2 = {s = imp1.s ++ imp2.s} ;
        CoordImpInv imp1 imp2 = {s = imp2.s ++ imp1.s} ;

        ImpVP = linArg ;
        Twice vp  = {s = vp.s ++ vp.s} ;
        Thrice vp = {s = vp.s ++ vp.s ++ vp.s} ;

        UseV = linArg ;
        DirVP       v d = {s =  d.s ++ v.s} ;
        OppositeVP  v d = {s =  d.s ++ d.s ++ v.s} ;
        AroundVP    v d = {s =  d.s ++ v.s ++
                                d.s ++ v.s ++
                                d.s ++ v.s ++
                                d.s ++ v.s} ;

        VVerb = linArg ;
        VDVerb _ = {s = []} ;

        left_Adv  = {s = "I_TURN_LEFT"} ;
        right_Adv = {s = "I_TURN_RIGHT"} ;
        turn_VD   = {s = ""} ;
        walk_V    = {s = "I_WALK"} ;
        run_V     = {s = "I_RUN"} ;
        jump_V    = {s = "I_JUMP"} ;
        look_V    = {s = "I_LOOK"} ;
}
