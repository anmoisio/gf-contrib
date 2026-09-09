
concrete LangEng of Lang = {
    lincat S, VP, NP, V2, V1, V, N, Det = Str ;
    lin
        Sentence    np  vp  = np ++ vp ;
        Verb2phrase v2  np  = v2 ++ np ;
        Verb1phrase v1      = v1 ;
        Nounphrase  det n   = det ++ n ;
        V2Verb      v       = v ;
        V1Verb      v       = v ;
        drink_V             = "drinks" ;
        a_Det               = "a" ;
        the_Det             = "the" ;
        man_N               = "man" ;
        coffee_N            = "coffee" ;
}
