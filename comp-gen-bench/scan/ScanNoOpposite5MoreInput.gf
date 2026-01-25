
concrete ScanStructGenMoreInput of ScanStructGenMore = ScanInput ** {

    lincat VPopp = {s : Str};

    lin
        UseVPopp vpopp = vpopp ;

        ThreeQuartersVP v adv = {s = v.s ++ "three_quarters" ++ adv.s} ;
        FiveQuartersVP  v adv = {s = v.s ++ "five_quarters" ++ adv.s} ;
        OneAndHalfVP    v adv = {s = v.s ++ "one_and_a_half" ++ adv.s} ;
        MuchVP          v adv = {s = v.s ++ "much" ++ adv.s} ;
        MucherVP        v adv = {s = v.s ++ "mucher" ++ adv.s} ;
}
