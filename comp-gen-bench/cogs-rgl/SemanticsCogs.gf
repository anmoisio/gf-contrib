abstract SemanticsCogs = Semantics - [
    iVP
    ,iCN
    ,iAdvCN
    ,iPrep
    ,iV
    ,iV2
    ,iV3
    ,iV2Pass
    ,iV3Pass
    ,iVV
    ,iVS
    ,VUnergEvent
    ,Agent
    ,Theme
    ,Recipient
    ,Ccomp
    ,Xcomp
    ,Assert
    ,ListAssert
    ,BaseAssert
    ,ConsAssert
] ** {

flags startcat = Wrapper ;

cat
    Assert ;
    [Assert] {0} ;


-- Because of the not-so-compositional notation in COGS, adverbs need to know what
-- type of event they are modifying: "walk.agent(e,x)" instead of just
-- the normal "walk(e) ∧ agent(e,x)".
-- And because of this, AdvVP needs to be handled differently than in the typical
-- neo-davidsonian semantics.

fun iVP : VP -> Ind -> Event -> Prop ;
def
    -- UseV applies the lexical verb's meaning directly.
    iVP (UseV v) = iV v ;

    -- The object NP takes the transitive verb as its scope.
    -- `i` is the subject, `y` will be the direct object variable, and z the oblique object.
    -- The result of `iNP np (...)` is the final Event -> Prop for the subject `i`.
    iVP (ComplSlash (SlashV2a v2) np) = \subj -> iNP np (\obj -> iV2 v2 subj obj) ;

    -- Slash2V3 and Slash3V3 are same but np_oo and np_do switch places; the have the same meaning
    -- DOC: "give a dog a bone" vs. the normal "give a bone to a dog" also switches the order of the arguments
    -- so there are 2x2 possibilities.
    -- If v3 is a DOC, then arg1 is the indirect object (oobj) and arg2 the direct object (dobj).
    -- iVP (ComplSlash (Slash2V3 v3 arg1) arg2) = \subj -> iNP arg1 (\x1 -> iNP arg2 (\x2 -> iV3 v3 subj x1 x2)) ;
    iVP (ComplSlash (Slash3V3 v3 arg2) arg1) = \subj -> iNP arg1 (\x1 -> iNP arg2 (\x2 -> iV3 v3 subj x1 x2)) ;

    -- passive voice
    iVP (PassVPSlash (SlashV2a v2))      = iV2Pass v2 ;
    iVP (AdvVP (PassVPSlash (SlashV2a v2)) (PrepNP by8agent_Prep np)) = \obj -> iNP np (\subj,e -> And
                                                                (iV2Pass v2 obj e)
                                                                (Agent (V2Verb v2) subj e)) ;
    iVP (PassVPSlash (Slash3V3 v3 arg2)) = \x1 -> iNP arg2 (\x2 -> iV3Pass v3 x1 x2) ;
    iVP (AdvVP (PassVPSlash (Slash3V3 (V3docV3 v3) np_arg2)) (PrepNP by8agent_Prep np_subj)) =
        \x1 -> iNP np_subj (\subj,e -> And
            (iNP np_arg2 (\x2 -> iV3Pass (V3docV3 v3) x1 x2) e)
            (Agent (V3docVerb v3) subj e)) ;
    iVP (AdvVP (PassVPSlash (Slash3V3 v3 np_arg2)) (PrepNP by8agent_Prep np_subj)) =
        \x1 -> iNP np_subj (\subj,e -> And
        (iNP np_arg2 (\x2 -> iV3Pass v3 x1 x2) e)
        (Agent (V3Verb v3) subj e)) ;

    -- sentence as complement
    iVP (ComplVS vs (UseCl (TTAnt t ant) p (PredVP np vp))) =
        iVS vs (iTense t (iAnt ant (iNP np (iPol p (iVP vp))))) ;

    -- verb as complement
    iVP (ComplVV vv vp) = iVV vv (iVP vp) ;


-- A verb is combined with 1-3 individuals, an event, and sometimes a complement
fun
    iV      : V -> Ind                              -> Event -> Prop ;
    iV2     : V2 -> Ind -> Ind                      -> Event -> Prop ;
    iV3     : V3 -> Ind -> Ind -> Ind               -> Event -> Prop ;
    iV2Pass : V2 -> Ind                             -> Event -> Prop ;
    iV3Pass : V3 -> Ind -> Ind                      -> Event -> Prop ;
    iVV     : VV -> (Ind -> Event -> Prop) -> Ind   -> Event -> Prop ;
    iVS     : VS -> (Event -> Prop) -> Ind          -> Event -> Prop ;
def
    iV (VUnergV v) i e                  = Agent (VUnergVerb v) i e ;
    iV (VUnaccV v) i e                  = Theme (VUnaccVerb v) i e ;
    iV2 v subj obj e                    = And (Agent (V2Verb v) subj e) (Theme (V2Verb v) obj e) ;
    iV3 (V3docV3 v3) subj oobj dobj e   = And (And
                                            (Agent (V3docVerb v3) subj e)
                                            (Recipient (V3docVerb v3) oobj e))
                                            (Theme (V3docVerb v3) dobj e) ;
    iV3 v3 subj dobj oobj e             = And (And
                                            (Agent (V3Verb v3) subj e)
                                            (Theme (V3Verb v3) dobj e))
                                            (Recipient (V3Verb v3) oobj e) ;
    iV2Pass v i e                       = Theme (V2Verb v) i e ;
    iV3Pass (V3docV3 v3) oobj dobj e    = And (Recipient (V3docVerb v3) oobj e) (Theme (V3docVerb v3) dobj e) ;
    iV3Pass v3 dobj oobj e              = And (Theme (V3Verb v3) dobj e)    (Recipient (V3Verb v3) oobj e) ;
    iVV vv vpf subj e                   = ExistE (\e2 -> And (And
                                            (Agent (VVVerb vv) subj e)
                                            (Xcomp vv e e2))
                                            (vpf subj e2)) ;
    iVS vs eprop subj e                 = And
                                            (Agent (VSVerb vs) subj e)
                                            (ExistE (\e2 -> And
                                                (Ccomp vs e e2)
                                                (eprop e2)
                                            )) ;

-- nmod needs to include the noun "mat . nmod . on ( x , y )"
fun iCN : CN -> Ind -> Prop ;
def
    iCN (UseN n) = iN n ;
    iCN (AdvCN cn adv) = \x -> And (iCN cn x) (iAdvCN adv (iCN cn) x) ;
    iCN (AdjCN adj cn) = \x -> And (iCN cn x) (iAP adj x) ;

fun iAdvCN : Adv -> (Ind -> Prop) -> Ind -> Prop ;
-- def iAdvCN (PrepNP prep np)  = \x -> ExistE (\e -> iNP np (\y,e' -> iPrep prep (\a,b -> (iNP np) a b) x y) e) ;
def iAdvCN (PrepNP prep np) cnf = \x -> ExistE (\e -> iNP np (\y,e' -> iPrep prep cnf x y) e) ;

-- fun iPP : Adv -> ((Ind -> Event -> Prop) -> Event -> Prop) ->
--                   (Ind -> Event -> Prop) -> Event -> Prop ;
-- def iPP (PrepNP prep np) npf vpf =
--         npf (\x,e -> iNP np (\y,e -> And (vpf x e) (iPrep prep (\a,b -> npf a b) x y)) e) ;

cat
    Verb ;
fun
    VUnergVerb : VUnerg  -> Verb ;
    VUnaccVerb : VUnacc  -> Verb ;
    V2Verb : V2 -> Verb ;
    V3Verb : V3 -> Verb ;
    V3docVerb : V3doc -> Verb ;
    VSVerb : VS -> Verb ;
    VVVerb : VV -> Verb ;

    -- Thematic Role Predicates with the dot notation structure
    Agent       : Verb -> Ind   -> Event -> Prop ;  -- e.g. "paint . agent ( e , x )"
    Theme       : Verb -> Ind   -> Event -> Prop ;
    Recipient   : Verb -> Ind   -> Event -> Prop ;
    Ccomp       : VS -> Event   -> Event -> Prop ;  -- e_comp is first event arg
    Xcomp       : VV -> Event   -> Event -> Prop ;

    iPrep : Prep -> (Ind -> Prop) -> Ind -> Ind -> Prop ;
}