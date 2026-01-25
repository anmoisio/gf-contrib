
concrete ScanStructGen12MoreInput of ScanStructGen12More = ScanInput ** {

    lincat VPopp = {s : Str};

    lin
        UseVPopp vpopp = vpopp ;

        ThreeQuartersVP v adv = {s = v.s ++ "three_quarters" ++ adv.s} ;
        FiveQuartersVP  v adv = {s = v.s ++ "five_quarters" ++ adv.s} ;
        OneAndHalfVP    v adv = {s = v.s ++ "one_and_a_half" ++ adv.s} ;
        MuchVP          v adv = {s = v.s ++ "much" ++ adv.s} ;
        MucherVP        v adv = {s = v.s ++ "mucher" ++ adv.s} ;

        VerbVerbAdv     v adv = {s = v.s ++ "vva" ++ adv.s} ;
        VerbAdvVerb     v adv = {s = v.s ++ "vav" ++ adv.s} ;
        AdvVerbAdv      v adv = {s = v.s ++ "ava" ++ adv.s} ;
        AdvVerbVerbAdv  v adv = {s = v.s ++ "avva" ++ adv.s} ;
        VerbAdvVerbAdv  v adv = {s = v.s ++ "vava" ++ adv.s} ;
        AdvAdvVerbVerb  v adv = {s = v.s ++ "aavv" ++ adv.s} ;
        VerbVerbAdvAdv  v adv = {s = v.s ++ "vvaa" ++ adv.s} ;
}
