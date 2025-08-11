
concrete ScanInput of Scan = {
    lincat Utt, ConjImp, Imp, VP, Adv, Verb, VD, V = {s : Str};
    
    oper linArg : {s : Str} -> {s : Str} = \arg -> {s = arg.s} ;

    lin
        UseConjImp  = linArg ;
        UseImp      = linArg ;

        CoordImp    imp1 imp2   = {s = imp1.s ++ "and" ++ imp2.s} ;
        CoordImpInv imp1 imp2   = {s = imp1.s ++ "after" ++ imp2.s} ;
        
        ImpVP = linArg ;
        Twice vp  = {s = vp.s ++ "twice"} ;
        Thrice vp = {s = vp.s ++ "thrice"} ;
        
        UseV = linArg ;
        DirVP      v d = {s = v.s ++ d.s} ;
        OppositeVP v d = {s = v.s ++ "opposite" ++ d.s} ;
        AroundVP   v d = {s = v.s ++ "around" ++ d.s} ;

        VVerb = linArg ;
        VDVerb = linArg ;

        left_Adv  = {s = "left"} ;
        right_Adv = {s = "right"} ;
        turn_VD   = {s = "turn"} ;
        walk_V    = {s = "walk"} ;
        run_V     = {s = "run"} ;
        jump_V    = {s = "jump"} ;
        look_V    = {s = "look"} ;
}
