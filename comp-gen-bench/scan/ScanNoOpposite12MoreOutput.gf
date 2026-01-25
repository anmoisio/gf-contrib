
concrete ScanStructGen12MoreOutput of ScanStructGen12More = ScanOutput ** {

    lincat VPopp = {s : Str};

    lin
        UseVPopp vpopp = vpopp ;

        ThreeQuartersVP v adv = {s = adv.s ++ adv.s ++ adv.s ++ v.s} ;
        FiveQuartersVP  v adv = {s = adv.s ++ adv.s ++ adv.s ++ adv.s ++ adv.s ++ v.s} ;
        OneAndHalfVP    v adv = {s = adv.s ++ adv.s ++ adv.s ++ adv.s ++ adv.s ++ adv.s ++ v.s} ;
        MuchVP          v adv = {s = adv.s ++ v.s ++ v.s} ;
        MucherVP        v adv = {s = adv.s ++ v.s ++ v.s ++ v.s} ;

        VerbVerbAdv     v adv = {s = v.s ++ v.s ++ adv.s} ;
        VerbAdvVerb     v adv = {s = v.s ++ adv.s ++ v.s} ;
        AdvVerbAdv      v adv = {s = adv.s ++ v.s ++ adv.s} ;
        AdvVerbVerbAdv  v adv = {s = adv.s ++ v.s ++ v.s ++ adv.s} ;
        VerbAdvVerbAdv  v adv = {s = v.s ++ adv.s ++ v.s ++ adv.s} ;
        AdvAdvVerbVerb  v adv = {s = adv.s ++ adv.s ++ v.s ++ v.s} ;
        VerbVerbAdvAdv  v adv = {s = v.s ++ v.s ++ adv.s ++ adv.s} ;
}
