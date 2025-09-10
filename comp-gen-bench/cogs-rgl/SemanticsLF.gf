concrete SemanticsLF of Semantics = CogsLexiconLF ** open Prelude in {

    param
        IsEmpty = Empty | NonEmpty ;

    lincat

        Prop = {
            s : Str ;
            events : [Events] ;
            inds : [Inds] ;
            presups : [Presup] ;
            asserts : [Assert] ;
            property : Str
        } ;

        -- GF book section 8.7 and blog post https://inariksit.github.io/gf/2021/02/22/lists.html
        Assert, Presup, Inds, Events           = {s : Str ; isEmpty : IsEmpty} ;
        [Assert], [Presup], [Inds], [Events]   = {s : Str ; isEmpty : IsEmpty } ;

        S, Adv, Verb, V, V2, V3, VV, VS, A, N, PN, Prep, Tense, Ant, Ind, Event = {s : Str} ;
        VUnerg, VUnacc = {s : Str} ;

    oper
        mkListLin : Str -> (f,fs : {s : Str ; isEmpty : IsEmpty}) -> {s : Str ; isEmpty : IsEmpty} =
            \separ,f,fs ->
            lin Assert (
            let
                sep : Str = case <f.isEmpty,fs.isEmpty> of {
                                <_,Empty> => "" ;
                                <Empty,_> => "" ;
                                <_,_> => separ } ;
                emptiness : IsEmpty = case <f.isEmpty,fs.isEmpty> of {
                                <Empty,Empty> => Empty ;
                                <_,_> => NonEmpty } ;
            in  {s = f.s ++ sep ++ fs.s ; isEmpty = emptiness}
            )
            ;
        
        mkDotLin : Str -> (i,e : {s : Str}) -> Prop = \dotstr,i,e ->
            lin Prop ( 
            {s = "" ;
            asserts = ConsAssert {
                    s = dotstr ++ "( " ++ e.s ++ " , " ++ i.s ++ " )" ;
                    isEmpty = NonEmpty}
                BaseAssert ;
            presups = BasePresup ;
            property = "" ;
            events = BaseEvents ;
            inds = BaseInds}
            )
            ;

    lin

        BasePresup = {s = "" ; isEmpty = Empty} ;
        ConsPresup = mkListLin ";" ;

        BaseAssert = {s = "" ; isEmpty = Empty} ;
        ConsAssert = mkListLin "∧" ;

        BaseEvents = {s = "" ; isEmpty = Empty} ;
        ConsEvents = mkListLin "," ;

        BaseInds = {s = "" ; isEmpty = Empty} ;
        ConsInds = mkListLin "," ;

        -- Wrapper combines the quantifiers, assertions and presuppositions into the s field of Prop
        -- Prop -> Prop
        Wrapper prop = {
            s = "(" ++ "∃" ++ prop.events.s ++ "∃" ++ prop.inds.s ++ ")" ++ "(" ++ (mkListLin ";" prop.presups prop.asserts).s ++ ")" ;
            asserts = BaseAssert ;
            presups = BasePresup ;
            events = BaseEvents ;
            inds = BaseInds ;
            property = ""
        } ;

        -- This is where the bound variables $0 are combined
        -- (Event -> Prop) -> Prop
        ExistE f = {
            s = "" ;
            events = ConsEvents {s = f.$0 ; isEmpty = NonEmpty} f.events ;
            asserts = f.asserts ;
            presups = f.presups ;
            property = "" ;
            inds = f.inds
        } ;

        -- (Ind -> Prop) -> Prop
        Exist f = {
            s = "" ;
            events = f.events ;
            inds = ConsInds {s = f.$0 ; isEmpty = NonEmpty} f.inds ;
            asserts = f.asserts ;
            presups = f.presups ;
            property = ""
        } ;

        -- -- (Ind -> Prop) -> Prop
        -- All f = {
        --     s = "" ;
        --     asserts = ConsAssert {s = "( ForAll" ++ f.$0 ++ ")" ++ "(" ++ f.s ++ ")" ; isEmpty = NonEmpty} BaseAssert ;
        --     presups = f.presups ; property = ""
        -- } ;

        -- Uniqueness operator - generates presupposition
        -- (Ind -> Prop) -> Ind -> Prop
        Unique n x = {
            s = "" ;
            asserts = BaseAssert ;
            presups = ConsPresup {s = "*" ++ n.property ++ "(" ++ x.s ++ ")" ; isEmpty = NonEmpty} BaseAssert ;
            property = "" ;
            events = BaseEvents ;
            inds = BaseInds -- should this include x?
        } ;

        
        -- V  -> Event  -> Prop ;
        VUnergEvent v e = {
            s = "" ;
            asserts = ConsAssert {s = v.s ++ "( " ++ e.s ++ " )" ; isEmpty = NonEmpty} BaseAssert ;
            presups = BasePresup ;
            property = "" ;
            events = BaseEvents ;
            inds = BaseInds
            } ;
        VUnaccEvent = VUnergEvent ;
        V2Event = VUnergEvent ;
        V3Event = VUnergEvent ;
        VSEvent = VUnergEvent ;
        VVEvent = VUnergEvent ;

        -- Dot notation predicates
        -- Ind   -> Event -> Prop
        -- TODO: change the order of arguments (Event -> Ind -> Prop in the abstract syntax)
        Agent       = mkDotLin "Agent" ;
        Theme       = mkDotLin "Theme" ;
        Recipient   = mkDotLin "Recipient" ;
        -- Event -> Event -> Prop
        Ccomp       = mkDotLin "Ccomp" ;
        Xcomp       = mkDotLin "Xcomp" ;

        -- Prep -> Ind -> Ind -> Prop ;
        Nmod prep a_cat on_a_mat = mkDotLin ("Nmod" ++ "." ++ prep.s) on_a_mat a_cat ;

        -- Time predicate
        -- Tense -> Event -> Prop
        Time t e = {
            s = "" ;
            asserts = ConsAssert {s = "Time ( " ++ e.s ++ " , " ++ t.s ++ " )"; isEmpty = NonEmpty} BaseAssert ;
            presups = BasePresup ;
            property = "" ;
            events = BaseEvents ;
            inds = BaseInds
            } ;
        -- Ant -> Event -> Prop
        Anteriority t e = {
            s = "" ;
            asserts = ConsAssert {s = "Anteriority ( " ++ e.s ++ " , " ++ t.s ++ " )"; isEmpty = NonEmpty} BaseAssert ;
            presups = BasePresup ;
            property = "" ;
            events = BaseEvents ;
            inds = BaseInds
            } ;

        -- Tense
        TPres = {s = "Pres"} ;
        TPast = {s = "Past"} ;
        TFut  = {s = "Fut"} ;
        TCond = {s = "Cond"} ;
        ASimul = {s = "Simul"} ;
        AAnter = {s = "Anter"} ;

        -- Nouns
        -- N -> Ind -> Prop
        iN n i = {
            s = "" ;
            asserts = ConsAssert {s = n.s ++ "(" ++ i.s ++ ")"; isEmpty = NonEmpty} BaseAssert ;
            presups = BasePresup ;
            property = n.s ;
            events = BaseEvents ;
            inds = BaseInds --ConsInds {s = i.s ; isEmpty = NonEmpty} BaseInds
            } ;
        
        -- PN -> Ind ;
        PNInd pn = {s = pn.s} ;

        -- Flat conjunction with AND - combines presuppositions and assertions
        -- Prop -> Prop -> Prop
        And p q = {
            s = "" ;
            asserts = ConsAssert p.asserts q.asserts ;
            presups = ConsPresup p.presups q.presups ;
            events = ConsEvents p.events q.events ;
            inds = ConsInds p.inds q.inds ;
            property = ""
            } ;
        
        -- negation for propositions, enclose the assertions in NOT(...)
        -- Prop -> Prop
        Not p = {
            s = "" ;
            asserts = ConsAssert {s = "¬( " ++ p.asserts.s ++ " )" ; isEmpty = NonEmpty} BaseAssert ;
            presups = p.presups ;
            property = "" ;
            events = p.events ;
            inds = p.inds
            } ;

        -- If p q = { } ;
        -- Or p q = { } ;

        -- Ind -> Ind -> Prop
        Equals x y = {
            s = "" ;
            asserts = ConsAssert {s = x.s ++ " == " ++ y.s ; isEmpty = NonEmpty} BaseAssert ;
            presups = BasePresup ;
            property = "" ;
            events = BaseEvents ;
            inds = BaseInds
            } ;


        -- Conjunction for propositions - same as And but for interpretation functions
        -- iConj conj p q = And p q ;

}
