concrete SemanticsLF of Semantics = CogsLexiconLF ** open Prelude in {

    param
        IsEmpty = Empty | NonEmpty ;

    lincat

        Prop = {s : Str ; asserts : [Assert] ; presups : [Presup] ; property : Str} ;

        -- GF book section 8.7 and blog post https://inariksit.github.io/gf/2021/02/22/lists.html
        Assert, Presup      = {s : Str ; isEmpty : IsEmpty} ;
        [Assert], [Presup]  = {s : Str ; isEmpty : IsEmpty } ;

        Event, Utt, Adv, S, Ind, Verb, V, V2, V3, VS, A, N, PN, Tense, Ant  = {s : Str} ;

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
            property = ""}
            )
            ;

    lin

        BasePresup = {s = "" ; isEmpty = Empty} ;
        ConsPresup = mkListLin ";" ;

        BaseAssert = {s = "" ; isEmpty = Empty} ;
        ConsAssert = mkListLin "AND" ;

        -- todo: the startcategory should combine the events into the s field of Prop
        -- ExistE f = {
        --     s = "(" ++ "∃" ++ f.$0 ++ ")" ++ "(" ++ (mkListLin ";" f.presups f.asserts).s ++ ")" ;
        --     asserts = BaseAssert ; presups = BasePresup ; property = ""} ;
        ExistE f = {
            s = "(" ++ "∃" ++ f.$0 ++ ")" ++ "(" ++ (mkListLin ";" f.presups f.asserts).s ++ ")" ;
            asserts = f.asserts ; presups = f.presups ; property = ""} ;
        Exist f = {s = "" ; asserts = f.asserts ; presups = f.presups ; property = ""} ;
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
            property = ""
        } ;

        
        -- V  -> Event  -> Prop ;
        VEvent v e = {
            s = "" ;
            asserts = ConsAssert {s = v.s ++ "( " ++ e.s ++ " )" ; isEmpty = NonEmpty} BaseAssert ;
            presups = BasePresup ;
            property = "" ;
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
        Time e t = {
            s = "" ;
            asserts = ConsAssert {s = "Time ( " ++ e.s ++ " , " ++ t.s ++ " )"; isEmpty = NonEmpty} BaseAssert ;
            presups = BasePresup ;
            property = "" ;
            } ;
        Anteriority e t = {
            s = "" ;
            asserts = ConsAssert {s = "Anteriority ( " ++ e.s ++ " , " ++ t.s ++ " )"; isEmpty = NonEmpty} BaseAssert ;
            presups = BasePresup ;
            property = "" ;
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
            property = n.s
            } ;

        -- Flat conjunction with AND - combines presuppositions and assertions
        And p q = {
            s = "" ;
            asserts = ConsAssert p.asserts (ConsAssert q.asserts BaseAssert) ;
            presups = ConsPresup p.presups (ConsPresup q.presups BasePresup) ;
            property = "" ;
            } ;
        
        -- negation for propositions, enclose the assertions in NOT(...)
        Not p = {
            s = "" ;
            asserts = ConsAssert {s = "NOT ( " ++ p.asserts.s ++ " )" ; isEmpty = NonEmpty} BaseAssert ;
            presups = p.presups ;
            property = "" ;
            } ;

        -- If p q = { } ;
        
        Equals x y = {
            s = "" ;
            asserts = ConsAssert {s = x.s ++ " == " ++ y.s ; isEmpty = NonEmpty} BaseAssert ;
            presups = BasePresup ;
            property = "" ;
            } ;


        -- Conjunction for propositions - same as And but for interpretation functions
        -- iConj conj p q = And p q ;


        -- Variable assignments with indexing
        -- Inds num = {s = "x _ " ++ num.s} ;
        -- Events num = {s = "x _ " ++ num.s} ;
        -- One = {s = "1"} ;
        -- Two = {s = "2"} ;
        -- Three = {s = "3"} ;
        -- Four = {s = "4"} ;
        -- Five = {s = "5"} ;

}
