concrete SemanticsLF of Semantics = CogsLexiconLF ** open Prelude in {

    param
        IsEmpty = Empty | NonEmpty ;

    lincat

        Prop = {
            s : Str ;
            events : [Event] ;
            inds : [Ind] ;
            presups : [Presup] ;
            asserts : [Assert] ;
            property : Str
        } ;

        -- GF book section 8.7 and blog post https://inariksit.github.io/gf/2021/02/22/lists.html
        Assert, Presup, Ind, Event           = {s : Str ; isEmpty : IsEmpty} ;
        [Assert], [Presup], [Ind], [Event]   = {s : Str ; isEmpty : IsEmpty } ;

        Utt, Adv, S, Verb, V, V2, V3, VS, A, N, PN, Tense, Ant  = {s : Str} ;

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
            events = BaseEvent ;
            inds = BaseInd}
            )
            ;

    lin

        BasePresup = {s = "" ; isEmpty = Empty} ;
        ConsPresup = mkListLin ";" ;

        BaseAssert = {s = "" ; isEmpty = Empty} ;
        ConsAssert = mkListLin "∧" ;

        BaseEvent = {s = "" ; isEmpty = Empty} ;
        ConsEvent = mkListLin "∃" ;

        BaseInd = {s = "" ; isEmpty = Empty} ;
        ConsInd = mkListLin "∃" ;

        -- Wrapper combines the quantifiers, assertions and presuppositions into the s field of Prop
        Wrapper prop = {
            s = "(" ++ "∃" ++ prop.events.s ++ "∃" ++ prop.inds.s ++ ")" ++ "(" ++ (mkListLin ";" prop.presups prop.asserts).s ++ ")" ;
            asserts = BaseAssert ; presups = BasePresup ; events = BaseEvent ;
            inds = BaseInd ;
            property = ""} ;

        -- This is where the bound variables $0 are combined
        ExistE f = {
            s = "" ;
            events = ConsEvent {s = f.$0 ; isEmpty = NonEmpty} (ConsEvent f.events BaseEvent) ;
            asserts = f.asserts ;
            presups = f.presups ;
            property = "" ;
            inds = f.inds
        } ;

        Exist f = {
            s = "" ;
            events = f.events ;
            inds = ConsInd {s = f.$0 ; isEmpty = NonEmpty} (ConsInd f.inds BaseInd) ;
            asserts = f.asserts ;
            presups = f.presups ;
            property = ""
        } ;

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
            events = BaseEvent ;
            inds = BaseInd -- should this include x?
        } ;

        
        -- V  -> Event  -> Prop ;
        VEvent v e = {
            s = "" ;
            asserts = ConsAssert {s = v.s ++ "( " ++ e.s ++ " )" ; isEmpty = NonEmpty} BaseAssert ;
            presups = BasePresup ;
            property = "" ;
            events = BaseEvent ;
            inds = BaseInd
            } ;
        V2Event = VEvent ;
        V3Event = VEvent ;
        VSEvent = VEvent ;

        -- Dot notation predicates
        Agent       = mkDotLin "Agent" ;
        Theme       = mkDotLin "Theme" ;
        Recipient   = mkDotLin "Recipient" ;
        Ccomp       = mkDotLin "Ccomp" ;

        -- Time predicate
        Time t e = {
            s = "" ;
            asserts = ConsAssert {s = "Time ( " ++ e.s ++ " , " ++ t.s ++ " )"; isEmpty = NonEmpty} BaseAssert ;
            presups = BasePresup ;
            property = "" ;
            events = BaseEvent ;
            inds = BaseInd
            } ;
        Anteriority t e = {
            s = "" ;
            asserts = ConsAssert {s = "Anteriority ( " ++ e.s ++ " , " ++ t.s ++ " )"; isEmpty = NonEmpty} BaseAssert ;
            presups = BasePresup ;
            property = "" ;
            events = BaseEvent ;
            inds = BaseInd
            } ;

        -- Tense
        TPres = {s = "Pres"} ;
        TPast = {s = "Past"} ;
        TFut  = {s = "Fut"} ;
        TCond = {s = "Cond"} ;
        ASimul = {s = "Simul"} ;
        AAnter = {s = "Anter"} ;

        -- Nouns
        iN n i = {
            s = "" ;
            asserts = ConsAssert {s = n.s ++ "(" ++ i.s ++ ")"; isEmpty = NonEmpty} BaseAssert ;
            presups = BasePresup ;
            property = n.s ;
            events = BaseEvent ;
            inds = BaseEvent --ConsInd {s = i.s ; isEmpty = NonEmpty} BaseInd
            } ;

        -- Flat conjunction with AND - combines presuppositions and assertions
        And p q = {
            s = "" ;
            asserts = ConsAssert p.asserts (ConsAssert q.asserts BaseAssert) ;
            presups = ConsPresup p.presups (ConsPresup q.presups BasePresup) ;
            events = ConsEvent p.events (ConsEvent q.events BaseEvent) ;
            inds = ConsInd p.inds (ConsInd q.inds BaseInd) ;
            property = ""
            } ;
        
        -- negation for propositions, enclose the assertions in NOT(...)
        Not p = {
            s = "" ;
            asserts = ConsAssert {s = "NOT ( " ++ p.asserts.s ++ " )" ; isEmpty = NonEmpty} BaseAssert ;
            presups = p.presups ;
            property = "" ;
            events = p.events ;
            inds = p.inds
            } ;

        -- If p q = { } ;
        
        Equals x y = {
            s = "" ;
            asserts = ConsAssert {s = x.s ++ " == " ++ y.s ; isEmpty = NonEmpty} BaseAssert ;
            presups = BasePresup ;
            property = "" ;
            events = BaseEvent ;
            inds = BaseInd
            } ;


        -- Conjunction for propositions - same as And but for interpretation functions
        -- iConj conj p q = And p q ;

}
