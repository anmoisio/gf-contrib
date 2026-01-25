
concrete ScanStructGenMoreOutput of ScanStructGenMore = ScanOutput ** {

    lincat VPopp = {s : Str};

    lin
        UseVPopp vpopp = vpopp ;

        ThreeQuartersVP v adv = {s = adv.s ++ adv.s ++ adv.s ++ v.s} ;
        FiveQuartersVP  v adv = {s = adv.s ++ adv.s ++ adv.s ++ adv.s ++ adv.s ++ v.s} ;
        OneAndHalfVP    v adv = {s = adv.s ++ adv.s ++ adv.s ++ adv.s ++ adv.s ++ adv.s ++ v.s} ;
        MuchVP          v adv = {s = adv.s ++ v.s ++ v.s} ;
        MucherVP        v adv = {s = adv.s ++ v.s ++ v.s ++ v.s} ;
}
