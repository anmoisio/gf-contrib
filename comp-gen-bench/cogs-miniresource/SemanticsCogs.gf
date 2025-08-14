concrete SemanticsCogs of SemanticsLang = open Prelude in {

    param
        IsEmpty = Empty | NonEmpty ;

    lincat

        Prop = {s : Str ; asserts : [Assert] ; presups : [Presup] ; name : Str} ;

        -- GF book section 8.7 and blog post https://inariksit.github.io/gf/2021/02/22/lists.html
        Assert, Presup      = {s : Str ; isEmpty : IsEmpty} ;
        [Assert], [Presup]  = {s : Str ; isEmpty : IsEmpty } ;

        Event, Utt, Adv, S, Ind, IndNum, V, V2, V3, VS, A, N, PN, Tense  = {s : Str} ;

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
        
        mkDotLin : Str -> (v,i,e : {s : Str}) -> Prop = \dotstr,v,i,e ->
            lin Prop ( 
            {s = "" ;
            asserts = ConsAssert {
                s = v.s  ++ " . " ++ dotstr ++ "( " ++ e.s ++ " , " ++ i.s ++ " )" ;
                isEmpty = NonEmpty}
                BaseAssert ;
            presups = BasePresup ;
            name = ""}
            )
            ;

    lin

        BasePresup = {s = "" ; isEmpty = Empty} ;
        ConsPresup = mkListLin ";" ;

        BaseAssert = {s = "" ; isEmpty = Empty} ;
        ConsAssert = mkListLin "AND" ;

        ExistE f    = {s = "" ; asserts = f.asserts ; presups = f.presups ; name = ""} ;
        Exist f     = {s = "" ; asserts = f.asserts ; presups = f.presups ; name = ""} ;
        All f = {
            s = "" ;
            asserts = ConsAssert {s = "( ForAll" ++ f.$0 ++ ")" ++ "(" ++ f.s ++ ")" ; isEmpty = NonEmpty} BaseAssert ;
            presups = f.presups ; name = ""
        } ;

        -- Uniqueness operator - generates presupposition
        -- (Ind -> Prop) -> Ind -> Prop
        Unique n x = {
            s = "" ;
            asserts = BaseAssert ;
            presups = ConsPresup {s = "*" ++ n.name ++ "(" ++ x.s ++ ")" ; isEmpty = NonEmpty} BaseAssert ;
            name = n.s
        } ;

        
        -- Dot notation predicates
        DotAgent        = mkDotLin "agent" ;
        DotAgentV2      = mkDotLin "agent" ;
        DotAgentV3      = mkDotLin "agent" ;
        DotAgentVS      = mkDotLin "agent" ;
        DotThemeV2      = mkDotLin "theme" ;
        DotThemeV3      = mkDotLin "theme" ;
        DotRecipient    = mkDotLin "recipient" ;
        DotCcomp        = mkDotLin "ccomp" ;

        -- Time predicate
        Time e t = {
            s = "" ;
            asserts = ConsAssert {s = "time ( " ++ e.s ++ " , " ++ t.s ++ " )"; isEmpty = NonEmpty} BaseAssert ;
            presups = BasePresup ;
            name = ""
            } ;

        -- Tense
        Pres = {s = "pres"} ;
        Imp = {s = "imp"} ;
        Perf = {s = "perf"} ;

        -- Nouns
        -- N -> Ind -> Prop
        iN n i = {
            s = "" ;
            asserts = ConsAssert {s = n.s ++ "(" ++ i.s ++ ")"; isEmpty = NonEmpty} BaseAssert ;
            presups = BasePresup ;
            name = n.s
            } ;

        -- Flat conjunction with AND - combines presuppositions and assertions
        And p q = {
            s = "" ;
            asserts = ConsAssert p.asserts (ConsAssert q.asserts BaseAssert) ;
            presups = ConsPresup p.presups (ConsPresup q.presups BasePresup) ;
            name = ""
            } ;
        
        -- If p q = {
        --     s = p.s ++ " => " ++ q.s ;
        --     presup = combinePresuppositions p.presup q.presup
        -- } ;
        
        Equals x y = {
            s = "" ;
            asserts = ConsAssert {s = x.s ++ " == " ++ y.s ; isEmpty = NonEmpty} BaseAssert ;
            presups = BasePresup ;
            name = ""
            } ;


        -- Conjunction for propositions - same as And but for interpretation functions
        -- iConj conj p q = And p q ;


        -- Variable assignments with indexing
        Inds num = {s = "x _ " ++ num.s} ;
        Events num = {s = "x _ " ++ num.s} ;
        One = {s = "1"} ;
        Two = {s = "2"} ;
        Three = {s = "3"} ;
        Four = {s = "4"} ;
        Five = {s = "5"} ;

}
