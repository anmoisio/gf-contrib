
concrete CogsRestrictedEng of CogsRestricted = CogsEng ** open ResEng, ParadigmsEng, Prelude  in {
    
    lincat
        AdverbNP = {s : NPCase => Str ; a : Agr} ;
        AdvForVerb = {s : Str} ;
        VerbPrep = {
            s : Str ;       -- "with", "ago"
            isPre : Bool ;  -- whether it's pre- or postposition: "with"=True, "ago"=False
            } ;
    lin

        PredVPadv np vp = mkClause (np.s ! npNom) np.a vp ;
        ComplSlashadv vp np =
        let vp' = case vp.gapInMiddle of {
                    True  => insertObjPre (\\_ => vp.c2 ++ np.s ! NPAcc) vp ;
                    False => insertObj    (\\_ => vp.c2 ++ np.s ! NPAcc) vp } ;

            -- IL 24/04/2018
            -- If the missing argument is not an adverbial, make previous object
            -- agree with the argument of ComplSlash.
            -- Example: "you help /me/ like /myself/", not "*you help me like yourself".
            -- Different order of ReflVP and ComplSlash produces "you /yourself/ help me like me".
                f = case vp.missingAdv of {
                    True => id VP ;
                    False => objAgr np } ;
        in f vp' ;
        Slash3V3adv  v np =
            insertObjc (\\_ => v.c3 ++ np.s ! NPAcc) (predVc v) ;
        
        PrepNPadv prep np = {s = preOrPost prep.isPre prep.s (np.s ! NPAcc)} ;


        AdvNPnew np adv = {
        s = \\c => np.s ! c ++ adv.s ;
        a = np.a
        } ;


        AdvVPnew vp adv = insertObj (\\_ => adv.s) vp ;
        PrepNPforverb prep np = {s = preOrPost prep.isPre prep.s (np.s ! NPAcc)} ;
        by8agent_VerbPrep = mkPrep "by" ;
} ;
