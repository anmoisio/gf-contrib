concrete SemanticsReCogsLF of SemanticsReCogs = CogsLexiconLF ** open ResLF, Prelude in {

    lincat

        Prop = {
            s : Str ;
            events : [Events] ;
            inds : [Inds] ;
            presups : [Presup] ;
            asserts : [Assert] ;
            head : [Assert]
        } ;

        -- GF book section 8.7 and blog post https://inariksit.github.io/gf/2021/02/22/lists.html
        Assert, Presup, Inds, Events           = {s : Str ; isEmpty : IsEmpty} ;
        [Assert], [Presup], [Inds], [Events]   = {s : Str ; isEmpty : IsEmpty } ;

        S, Adv, Verb, V, V2, V3, VV, VS, A, N, PN, Prep, Tense, Ant, Ind, Event = {s : Str} ;
        VUnerg, VUnacc, V3doc = {s : Str} ;

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
            s = (mkListLin ";" prop.presups prop.asserts).s ;
            asserts = prop.asserts ;
            presups = prop.presups ;
            events = prop.events ;
            inds = prop.inds ;
            head = prop.head
        } ;

        -- This is where the bound variables $0 are combined (events in ExistE, inds in Exist)
        -- (Event -> Prop) -> Prop
        ExistE f = {
            s = f.s ;
            events = ConsEvents {s = f.$0 ; isEmpty = NonEmpty} f.events ;
            asserts = f.asserts ;
            presups = f.presups ;
            head = BaseAssert ;
            inds = f.inds
        } ;
        -- (Ind -> Prop) -> Prop
        Exist f = {
            s = f.s ;
            events = f.events ;
            inds = ConsInds {s = f.$0 ; isEmpty = NonEmpty} f.inds ;
            asserts = ConsAssert f.head f.asserts ;
            presups = f.presups ;
            head = BaseAssert
        } ;

        -- Uniqueness operator generates a presupposition
        -- (Ind -> Prop) -> Ind -> Prop
        Unique n x = {
            s = "" ;
            asserts = n.asserts ;
            presups = ConsPresup {s = "*" ++ n.head.s ; isEmpty = NonEmpty} n.presups ;
            head = BaseAssert ;
            events = BaseEvents ;
            inds = n.inds
        } ;

        -- V -> Event -> Prop ;
        VUnergEvent v e = {
            s = "" ;
            asserts = lin ListAssert ({s = v.s ++ "( " ++ e.s ++ " )" ; isEmpty = NonEmpty}) ;
            presups = BasePresup ;
            head = BaseAssert ;
            events = BaseEvents ;
            inds = BaseInds
            } ;
        VUnaccEvent = VUnergEvent ;
        V2Event = VUnergEvent ;
        V3Event = VUnergEvent ;
        VSEvent = VUnergEvent ;
        VVEvent = VUnergEvent ;
        V3docEvent = VUnergEvent ;
        

        -- Ind -> Event -> Prop
        Agent i e = {
            asserts = lin ListAssert ({s = "Agent" ++ "( " ++ e.s ++ " , " ++ i.s ++ " )" ; isEmpty = NonEmpty}) ;
            s = "" ; presups = BasePresup ; head = BaseAssert ; events = BaseEvents ; inds = BaseInds } ;
        Theme i e = {
            asserts = lin ListAssert ({s = "Theme" ++ "( " ++ e.s ++ " , " ++ i.s ++ " )" ; isEmpty = NonEmpty}) ;
            s = "" ; presups = BasePresup ; head = BaseAssert ; events = BaseEvents ; inds = BaseInds } ;
        Recipient i e = {
            asserts = lin ListAssert ({s = "Recipient" ++ "( " ++ e.s ++ " , " ++ i.s ++ " )" ; isEmpty = NonEmpty}) ;
            s = "" ; presups = BasePresup ; head = BaseAssert ; events = BaseEvents ; inds = BaseInds } ;
        -- Event -> Event -> Prop
        Ccomp e1 e2 = {
            asserts = lin ListAssert ({s = "Ccomp" ++ "( " ++ e1.s ++ " , " ++ e2.s ++ " )" ; isEmpty = NonEmpty}) ;
            s = "" ; presups = BasePresup ; head = BaseAssert ; events = BaseEvents ; inds = BaseInds } ;
        Xcomp e1 e2 = {
            asserts = lin ListAssert ({s = "Xcomp" ++ "( " ++ e1.s ++ " , " ++ e2.s ++ " )" ; isEmpty = NonEmpty}) ;
            s = "" ; presups = BasePresup ; head = BaseAssert ; events = BaseEvents ; inds = BaseInds } ;
        -- Prep -> Ind -> Ind -> Prop
        iPrep prep i_cat i_obj = {
            asserts = lin ListAssert (
                {s = "Nmod ." ++ prep.s ++ "( " ++ i_cat.s ++ " , " ++ i_obj.s ++ " )" ; isEmpty = NonEmpty}) ;
            s = "" ; presups = BasePresup ; head = BaseAssert ; events = BaseEvents ; inds = BaseInds } ;

        -- Tense -> Event -> Prop
        Time t e = {
            s = "" ;
            asserts = lin ListAssert ({s = "Time ( " ++ e.s ++ " , " ++ t.s ++ " )"; isEmpty = NonEmpty}) ;
            presups = BasePresup ;
            head = BaseAssert ;
            events = BaseEvents ;
            inds = BaseInds
            } ;
        -- Ant -> Event -> Prop
        Anteriority t e = {
            s = "" ;
            asserts = lin ListAssert ({s = "Anteriority ( " ++ e.s ++ " , " ++ t.s ++ " )"; isEmpty = NonEmpty}) ;
            presups = BasePresup ;
            head = BaseAssert ;
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
            -- the noun is not yet assertion nor presupposition -- only after Exist or Unique
            asserts = BaseAssert ;
            presups = BasePresup ;
            head = lin ListAssert ({s = n.s ++ "(" ++ i.s ++ ")" ; isEmpty = NonEmpty}) ;
            events = BaseEvents ;
            inds = BaseInds
            } ;

        -- A -> Ind -> Prop
        iA a i = {
            s = "" ;
            asserts = lin ListAssert ({s = a.s ++ "(" ++ i.s ++ ")"; isEmpty = NonEmpty}) ;
            presups = BasePresup ;
            head = lin ListAssert ({s = a.s ; isEmpty = NonEmpty}) ;
            events = BaseEvents ;
            inds = BaseInds
            } ;
        
        -- PN -> Ind -> Prop ;
        PNInd pn i = {
            s = "" ;
            -- the noun is not yet assertion nor presupposition -- only after Exist or Unique
            asserts = BaseAssert ;
            presups = lin ListPresup ({s = pn.s ++ "(" ++ i.s ++ ")" ; isEmpty = NonEmpty}) ;
            head = BaseAssert ;
            events = BaseEvents ;
            inds = BaseInds
            } ;

        -- QInd : Ind ;
        QInd = {s = "?"} ;

        -- Flat conjunction with AND - combines presuppositions and assertions
        -- Prop -> Prop -> Prop
        And p q = {
            s = "" ;
            asserts = ConsAssert p.asserts q.asserts ;
            presups = ConsPresup p.presups q.presups ;
            events = ConsEvents p.events q.events ;
            inds = ConsInds p.inds q.inds ;
            head = p.head ; -- head of the noun phrase
            } ;
        
        -- negation for propositions, enclose the assertions in NOT(...)
        -- Prop -> Prop
        Not p = {
            s = p.s ;
            asserts = lin ListAssert ({s = "¬( " ++ p.asserts.s ++ " )" ; isEmpty = NonEmpty}) ;
            presups = p.presups ;
            head = p.head ;
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
            head = BaseAssert ;
            events = BaseEvents ;
            inds = BaseInds
            } ;


        -- Conjunction for propositions - same as And but for interpretation functions
        -- iConj conj p q = And p q ;
    
    -- lindef
    --     Ind = \s -> {s = "x _" ++ s} ;

}
