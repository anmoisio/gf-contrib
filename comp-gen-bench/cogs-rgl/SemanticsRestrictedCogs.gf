abstract SemanticsRestrictedCogs = CogsRestricted, Semantics - [
    iS
    ,iPP
    ,iVP
    ,iAdv
    ,iNP
    ,iPP
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


fun iS : S -> Prop ;
def
    iS (UseCl (TTAnt t ant) p (PredVP np vp)) = ExistE (iTense t (iAnt ant (iNP np (iPol p (iVP vp))))) ;
    iS (UseCl (TTAnt t ant) p (PredVPadv np vp)) = ExistE (iTense t (iAnt ant (iNPadv np (iPol p (iVP vp))))) ; -- for restricting PP scope


fun iNPadv : AdverbNP -> (Ind -> Event -> Prop) -> Event -> Prop ;  -- for restricting PP scope
def iNPadv (AdvNPnew np pp)  = iPP pp (iNP np) ;  -- for restricting PP scope


fun iVP : VP -> Ind -> Event -> Prop ;
def
    -- UseV applies the lexical verb's meaning directly.
    iVP (UseV v) = iV v ;

    -- The object NP takes the transitive verb as its scope.
    -- `i` is the subject, `y` will be the direct object variable, and z the oblique object.
    -- The result of `iNP np (...)` is the final Event -> Prop for the subject `i`.
    iVP (ComplSlash (SlashV2a v2) np) = \subj -> iNP np (\obj -> iV2 v2 subj obj) ;
    iVP (ComplSlashadv (SlashV2a v2) np) = \subj -> iNPadv np (\obj -> iV2 v2 subj obj) ; -- for restricting PP scope

    -- Slash2V3 and Slash3V3 are same but np_oo and np_do switch places; the have the same meaning
    -- DOC: "give a dog a bone" vs. the normal "give a bone to a dog" also switches the order of the arguments
    -- so there are 2x2 possibilities.
    -- If v3 is a DOC, then arg1 is the indirect object (oobj) and arg2 the direct object (dobj).
    -- iVP (ComplSlash (Slash2V3 v3 arg1) arg2) = \subj -> iNP arg1 (\x1 -> iNP arg2 (\x2 -> iV3 v3 subj x1 x2)) ;
    iVP (ComplSlash (Slash3V3 v3 arg2) arg1) = \subj -> iNP arg1 (\x1 -> iNP arg2 (\x2 -> iV3 v3 subj x1 x2)) ;
    iVP (ComplSlashadv (Slash3V3 v3 arg2) arg1) = \subj -> iNPadv arg1 (\x1 -> iNP arg2 (\x2 -> iV3 v3 subj x1 x2)) ; -- for restricting PP scope
    iVP (ComplSlash (Slash3V3adv v3 arg2) arg1) = \subj -> iNP arg1 (\x1 -> iNPadv arg2 (\x2 -> iV3 v3 subj x1 x2)) ; -- for restricting PP scope
    iVP (ComplSlashadv (Slash3V3adv v3 arg2) arg1) = \subj -> iNPadv arg1 (\x1 -> iNPadv arg2 (\x2 -> iV3 v3 subj x1 x2)) ; -- for restricting PP scope

    -- passive voice
    iVP (PassVPSlash (SlashV2a v2))      = iV2Pass v2 ;
    -- iVP (AdvVP (PassVPSlash (SlashV2a v2)) (PrepNP by8agent_Prep np)) = \obj -> iNP np (\subj,e -> And
    --                                                             (iV2Pass v2 obj e)
    --                                                             (Agent (V2Verb v2) subj e)) ;
    iVP (AdvVPnew (PassVPSlash (SlashV2a v2)) (PrepNPforverb by8agent_VerbPrep np)) = \obj -> iNP np (\subj,e -> And -- for restricting PP scope
                                                                (iV2Pass v2 obj e)
                                                                (Agent (V2Verb v2) subj e)) ;
    iVP (PassVPSlash (Slash3V3 v3 arg2)) = \x1 -> iNP arg2 (\x2 -> iV3Pass v3 x1 x2) ;
    iVP (PassVPSlash (Slash3V3adv v3 arg2)) = \x1 -> iNPadv arg2 (\x2 -> iV3Pass v3 x1 x2) ; -- for restricting PP scope
    -- iVP (AdvVP (PassVPSlash (Slash3V3 (V3docV3 v3) np_arg2)) (PrepNP by8agent_Prep np_subj)) =
    --     \x1 -> iNP np_subj (\subj,e -> And
    --         (iNP np_arg2 (\x2 -> iV3Pass (V3docV3 v3) x1 x2) e)
    --         (Agent (V3docVerb v3) subj e)) ;
    iVP (AdvVPnew (PassVPSlash (Slash3V3 (V3docV3 v3) np_arg2)) (PrepNPforverb by8agent_VerbPrep np_subj)) = -- for restricting PP scope
        \x1 -> iNP np_subj (\subj,e -> And
            (iNP np_arg2 (\x2 -> iV3Pass (V3docV3 v3) x1 x2) e)
            (Agent (V3docVerb v3) subj e)) ;
    iVP (AdvVPnew (PassVPSlash (Slash3V3adv (V3docV3 v3) np_arg2)) (PrepNPforverb by8agent_VerbPrep np_subj)) = -- for restricting PP scope
        \x1 -> iNP np_subj (\subj,e -> And
            (iNPadv np_arg2 (\x2 -> iV3Pass (V3docV3 v3) x1 x2) e)
            (Agent (V3docVerb v3) subj e)) ;
    -- iVP (AdvVP (PassVPSlash (Slash3V3 v3 np_arg2)) (PrepNP by8agent_Prep np_subj)) =
    --     \x1 -> iNP np_subj (\subj,e -> And
    --     (iNP np_arg2 (\x2 -> iV3Pass v3 x1 x2) e)
    --     (Agent (V3Verb v3) subj e)) ;
    iVP (AdvVPnew (PassVPSlash (Slash3V3 v3 np_arg2)) (PrepNPforverb by8agent_VerbPrep np_subj)) = -- for restricting PP scope
        \x1 -> iNP np_subj (\subj,e -> And
        (iNP np_arg2 (\x2 -> iV3Pass v3 x1 x2) e)
        (Agent (V3Verb v3) subj e)) ;
    iVP (AdvVPnew (PassVPSlash (Slash3V3adv v3 np_arg2)) (PrepNPforverb by8agent_VerbPrep np_subj)) = -- for restricting PP scope
        \x1 -> iNP np_subj (\subj,e -> And
        (iNPadv np_arg2 (\x2 -> iV3Pass v3 x1 x2) e)
        (Agent (V3Verb v3) subj e)) ;

    -- sentence as complement
    iVP (ComplVS vs (UseCl (TTAnt t ant) p (PredVP np vp))) =
        iVS vs (iTense t (iAnt ant (iNP np (iPol p (iVP vp))))) ;
    iVP (ComplVS vs (UseCl (TTAnt t ant) p (PredVP np vp))) =
        iVS vs (iTense t (iAnt ant (iNP np (iPol p (iVP vp))))) ; -- for restricting PP scope

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
-- so iNP is modified too
fun iNP : NP -> (Ind -> Event -> Prop) -> Event -> Prop ;
def
    iNP (DetCN det cn)                              vpf = iDet det (iCN cn) vpf ;
    iNP (UsePN pn)                                  vpf = iPN pn vpf ;
    iNP (AdvNP np pp) vpf = iPP pp (iNP np) vpf ;


fun iPP : Adv -> ((Ind -> Event -> Prop) -> Event -> Prop) ->
                  (Ind -> Event -> Prop) -> Event -> Prop ;
def iPP (PrepNP prep np) npf vpf =
        npf (\x,e -> iNP np (\y,e -> And (vpf x e) (iPrep prep (\a,b -> npf a b) x y)) e);
    iPP (PrepNPadv prep (AdvNPnew np adv)) npf vpf = -- for restricting PP scope
        npf (\x,e -> iNPadv (AdvNPnew np adv) (\y,e -> And (vpf x e) (iPrep prep (\a,b -> npf a b) x y)) e) ;
-- def iPP (PrepNPadv prep (UsePN pn)) npf vpf = -- for restricting PP scope
--     npf (\x,e -> iNPadv (UsePN pn) (\y,e -> And (vpf x e) (iPrepPN prep (PNInd pn) x y)) e) ;


fun
    iPrep : Prep -> ((Ind -> Event -> Prop) -> Event -> Prop) -> Ind -> Ind -> Prop ;

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

    -- iPrepCN       : Prep -> Prop -> Ind -> Ind -> Prop ;
    -- iPrepPN       : Prep -> Ind  -> Ind -> Ind -> Prop ;
}
