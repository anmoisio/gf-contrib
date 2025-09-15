concrete SemanticsCogsLF of SemanticsCogs = CogsLexiconLF ** open ResLF, Prelude in {

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

    lin

        BasePresup = {s = "" ; isEmpty = Empty} ;
        ConsPresup = mkListLin ";" ;

        BaseAssert = {s = "" ; isEmpty = Empty} ;
        ConsAssert = mkListLin "AND" ;

        BaseEvents = {s = "" ; isEmpty = Empty} ;
        ConsEvents = mkListLin "," ;

        BaseInds = {s = "" ; isEmpty = Empty} ;
        ConsInds = mkListLin "," ;

        -- Wrapper combines the quantifiers, assertions and presuppositions into the s field of Prop
        -- Prop -> Prop
        Wrapper prop = {
            s = "(" ++ "∃" ++ prop.events.s ++ "∃" ++ prop.inds.s ++ ")" ++ "(" ++ (mkListLin ";" prop.presups prop.asserts).s ++ ")" ;
            asserts = prop.asserts ;
            presups = prop.presups ;
            events = prop.events ;
            inds = prop.inds ;
            property = prop.property
        } ;

        -- This is where the bound variables $0 are combined (events in ExistE, inds in Exist)
        -- (Event -> Prop) -> Prop
        ExistE f = {
            s = f.s ;
            events = ConsEvents {s = f.$0 ; isEmpty = NonEmpty} f.events ;
            asserts = f.asserts ;
            presups = f.presups ;
            property = f.property ;
            inds = f.inds
        } ;
        -- (Ind -> Prop) -> Prop
        Exist f = {
            s = f.s ;
            events = f.events ;
            inds = ConsInds {s = f.$0 ; isEmpty = NonEmpty} f.inds ;
            asserts = f.asserts ;
            presups = f.presups ;
            property = f.property
        } ;

        -- Uniqueness operator generates a presupposition
        -- (Ind -> Prop) -> Ind -> Prop
        Unique n x = {
            s = "" ;
            asserts = BaseAssert ;
            -- equal to "ConsPresup newPresup BasePresup"
            presups = lin ListPresup ({s = "*" ++ n.property ++ "(" ++ x.s ++ ")" ; isEmpty = NonEmpty}) ;
            property = "" ;
            events = BaseEvents ;
            inds = BaseInds
        } ;

        VUnergVerb v = v ;
        VUnaccVerb v = v ;
        V2Verb v = v ;
        V3Verb v = v ;
        VSVerb v = v ;
        VVVerb v = v ;

        -- V -> Ind -> Event -> Prop
        Agent v i e = {
            asserts = lin ListAssert ({s = v.s ++ "." ++ "agent" ++ "( " ++ e.s ++ " , " ++ i.s ++ " )" ; isEmpty = NonEmpty}) ;
            s = "" ; presups = BasePresup ; property = "" ; events = BaseEvents ; inds = BaseInds } ;
        Theme v i e = {
            asserts = lin ListAssert ({s = v.s ++ "." ++ "theme" ++ "( " ++ e.s ++ " , " ++ i.s ++ " )" ; isEmpty = NonEmpty}) ;
            s = "" ; presups = BasePresup ; property = "" ; events = BaseEvents ; inds = BaseInds } ;
        Recipient v i e = {
            asserts = lin ListAssert ({s = v.s ++ "." ++ "recipient" ++ "( " ++ e.s ++ " , " ++ i.s ++ " )" ; isEmpty = NonEmpty}) ;
            s = "" ; presups = BasePresup ; property = "" ; events = BaseEvents ; inds = BaseInds } ;
        -- V -> Event -> Event -> Prop
        Ccomp v e1 e2 = {
            asserts = lin ListAssert ({s = v.s ++ "." ++ "ccomp" ++ "( " ++ e1.s ++ " , " ++ e2.s ++ " )" ; isEmpty = NonEmpty}) ;
            s = "" ; presups = BasePresup ; property = "" ; events = BaseEvents ; inds = BaseInds } ;
        Xcomp v e1 e2 = {
            asserts = lin ListAssert ({s = v.s ++ "." ++ "xcomp" ++ "( " ++ e1.s ++ " , " ++ e2.s ++ " )" ; isEmpty = NonEmpty}) ;
            s = "" ; presups = BasePresup ; property = "" ; events = BaseEvents ; inds = BaseInds } ;
        -- Prep -> Ind -> Ind -> Prop
        iPrep n prep i_cat i_obj = {
            asserts = lin ListAssert (
                {s = n.s ++ ". nmod ." ++ prep.s ++ "( " ++ i_obj.s ++ " , " ++ i_cat.s ++ " )" ; isEmpty = NonEmpty}) ;
            s = "" ; presups = BasePresup ; property = "" ; events = BaseEvents ; inds = BaseInds } ;

        -- Tense -> Event -> Prop
        Time t e = {
            s = "" ;
            asserts = lin ListAssert ({s = "Time ( " ++ e.s ++ " , " ++ t.s ++ " )"; isEmpty = NonEmpty}) ;
            presups = BasePresup ;
            property = "" ;
            events = BaseEvents ;
            inds = BaseInds
            } ;
        -- Ant -> Event -> Prop
        Anteriority t e = {
            s = "" ;
            asserts = lin ListAssert ({s = "Anteriority ( " ++ e.s ++ " , " ++ t.s ++ " )"; isEmpty = NonEmpty}) ;
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
            asserts = lin ListAssert ({s = n.s ++ "(" ++ i.s ++ ")"; isEmpty = NonEmpty}) ;
            presups = BasePresup ;
            property = n.s ;
            events = BaseEvents ;
            inds = BaseInds
            } ;
        
        -- PN -> Ind ;
        PNInd pn = pn ;

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
            s = p.s ;
            asserts = lin ListAssert ({s = "¬( " ++ p.asserts.s ++ " )" ; isEmpty = NonEmpty}) ;
            presups = p.presups ;
            property = p.property ;
            events = p.events ;
            inds = p.inds
            } ;

        -- If p q = { } ;
        -- Or p q = { } ;

        -- Ind -> Ind -> Prop
        Equals x y = {
            s = "" ;
            asserts = lin ListAssert ({s = x.s ++ " == " ++ y.s ; isEmpty = NonEmpty}) ;
            presups = BasePresup ;
            property = "" ;
            events = BaseEvents ;
            inds = BaseInds
            } ;


        -- Conjunction for propositions - same as And but for interpretation functions
        -- iConj conj p q = And p q ;

}
