
concrete ScanInput of Scan = {

    lincat Utt, ConjImp, Imp, VP, Adv, Verb, VD, V = {s : Str};

    lin
        UseConjImp imp = imp ;
        UseImp     imp = imp ;

        CoordImp    imp1 imp2   = {s = imp1.s ++ "and" ++ imp2.s} ;
        CoordImpInv imp1 imp2   = {s = imp1.s ++ "after" ++ imp2.s} ;
        
        ImpVP  vp = vp ;
        Twice  vp = {s = vp.s ++ "twice"} ;
        Thrice vp = {s = vp.s ++ "thrice"} ;
        
        UseV       v     = v ;
        DirVP      v adv = {s = v.s ++ adv.s} ;
        OppositeVP v adv = {s = v.s ++ "opposite" ++ adv.s} ;
        AroundVP   v adv = {s = v.s ++ "around" ++ adv.s} ;

        VVerb  v = v ;
        VDVerb v = v ;

        left_Adv  = {s = "left"} ;
        right_Adv = {s = "right"} ;
        turn_VD   = {s = "turn"} ;
        walk_V    = {s = "walk"} ;
        run_V     = {s = "run"} ;
        jump_V    = {s = "jump"} ;
        look_V    = {s = "look"} ;
}
