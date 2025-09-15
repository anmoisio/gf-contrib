abstract SemanticsCogs = Semantics - [
    iVP
    ,iAdv
    ,iNP
    ,iPrep
    ,iVCaus
    ,iVIncho
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
    iVP (UseV (VUnergV v)) = iVCaus v ;
    iVP (UseV (VUnaccV v)) = iVIncho v ;

    -- The object NP takes the transitive verb as its scope.
    -- `i` is the subject, `y` will be the direct object variable, and z the oblique object.
    -- The result of `iNP np (...)` is the final Event -> Prop for the subject `i`.
    iVP (ComplSlash (SlashV2a v2) np) = \i -> iNP np (\y -> iV2 v2 y i) ;

    -- Slash2V3 and Slash3V3 are same but np_oo and np_do switch places; the have the same meaning
    iVP (ComplSlash (Slash2V3 v3 np_do) np_oo) = \i -> iNP np_oo (\z -> iNP np_do (\y -> iV3 v3 y z i)) ;
    iVP (ComplSlash (Slash3V3 v3 np_oo) np_do) = \i -> iNP np_oo (\z -> iNP np_do (\y -> iV3 v3 y z i)) ;

    -- passive voice
    iVP (PassVPSlash (SlashV2a v2))       = iV2Pass v2 ;
    iVP (PassVPSlash (Slash3V3 v3 np_oo)) = \i -> iNP np_oo (\z -> iV3Pass v3 z i) ;
    iVP (AdvVP (PassVPSlash (SlashV2a v2)) (PrepNP by8agent_Prep np)) = \i -> iNP np (\y,e -> And
                                                                (Agent (V2Verb v2) y e)
                                                                (iV2Pass v2 i e)) ;
    iVP (AdvVP (PassVPSlash (Slash3V3 v3 np_oo)) (PrepNP by8agent_Prep np)) = \i -> iNP np (\y,e -> And
                                                                (Agent (V3Verb v3) y e)
                                                                (iNP np_oo (\z -> iV3Pass v3 z i) e)) ;

    -- sentence as complement
    iVP (ComplVS vs (UseCl (TTAnt t ant) p (PredVP np vp))) =
        iVS vs (iTense t (iAnt ant (iNP np (iPol p (iVP vp))))) ;

    -- verb as complement
    iVP (ComplVV vv vp) = iVV vv (iVP vp) ;


-- A verb is combined with 1-3 individuals, an event, and sometimes a complement
fun
    iVCaus  : VUnerg -> Ind                         -> Event -> Prop ;
    iVIncho : VUnacc -> Ind                         -> Event -> Prop ;
    iV2     : V2 -> Ind -> Ind                      -> Event -> Prop ;
    iV3     : V3 -> Ind -> Ind -> Ind               -> Event -> Prop ;
    iV2Pass : V2 -> Ind                             -> Event -> Prop ;
    iV3Pass : V3 -> Ind -> Ind                      -> Event -> Prop ;
    iVV     : VV -> (Ind -> Event -> Prop) -> Ind   -> Event -> Prop ;
    iVS     : VS -> (Event -> Prop) -> Ind          -> Event -> Prop ;
def
    iVCaus  v i e            = Agent (VUnergVerb v) i e ;
    iVIncho v i e            = Theme (VUnaccVerb v) i e ;
    iV2 v obj subj e         = And (Agent (V2Verb v) subj e) (Theme (V2Verb v) obj e) ;
    iV3 v3 dobj oobj subj e  = And (And
        (Agent (V3Verb v3) subj e) (Theme (V3Verb v3) dobj e)) (Recipient v3 oobj e) ;
    iV2Pass v i e           = Theme (V2Verb v) i e ; -- same as iVIncho
    iV3Pass v3 oobj dobj e  = And (Theme (V3Verb v3) dobj e) (Recipient v3 oobj e) ;
    iVV vv vpf subj e       = ExistE (\e2 -> And (Xcomp vv e2 e) (vpf subj e2)) ;
    iVS vs eprop subj e     = And
        (Agent (VSVerb vs) subj e)
        (ExistE (\e2 -> And
            (Ccomp vs e2 e)
            (eprop e2)
        )) ;

-- nmod needs to include the noun "mat . nmod . on ( x , y )"
-- so iNP is modified too
fun iNP : NP -> (Ind -> Event -> Prop) -> Event -> Prop ;
def
    iNP (DetCN det cn)                              vpf = iDet det (iCN cn) vpf ;
    iNP (UsePN pn)                                  vpf = iPN pn vpf ;
    iNP (AdvNP (DetCN det cn) (PrepNP prep np_pp))  vpf
        = iNP (DetCN det cn) (\x,e -> iNP np_pp (\y,e -> And (vpf x e) (iPrepCN prep (iCN cn x) x y)) e) ;
    iNP (AdvNP (UsePN pn) (PrepNP prep np_pp))  vpf
        = iNP (UsePN pn) (\x,e -> iNP np_pp (\y,e -> And (vpf x e) (iPrepPN prep (PNInd pn) x y)) e) ;

cat
    Verb ;
fun
    VUnergVerb : VUnerg  -> Verb ;
    VUnaccVerb : VUnacc  -> Verb ;
    V2Verb : V2 -> Verb ;
    V3Verb : V3 -> Verb ;
    VSVerb : VS -> Verb ;
    VVVerb : VV -> Verb ;

    -- Thematic Role Predicates with the dot notation structure
    Agent       : Verb -> Ind   -> Event -> Prop ;  -- e.g. "paint . agent ( e , x )"
    Theme       : Verb -> Ind   -> Event -> Prop ;
    Recipient   : V3 -> Ind     -> Event -> Prop ;
    Ccomp       : VS -> Event   -> Event -> Prop ;  -- e_comp is first event arg
    Xcomp       : VV -> Event   -> Event -> Prop ;

    iPrepCN       : Prep -> Prop -> Ind -> Ind -> Prop ;
    iPrepPN       : Prep -> Ind  -> Ind -> Ind -> Prop ;
}
