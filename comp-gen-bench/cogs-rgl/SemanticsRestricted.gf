abstract SemanticsRestricted = Semantics - [
    iS
    ,iPP
    ,iVP
    ,iAdv
] ** {

flags startcat = Wrapper ;

-- A sentence is a proposition.
fun iS : S -> Prop ;
def
    iS (UseCl (TTAnt t ant) p (PredVP np vp)) = ExistE (iTense t (iAnt ant (iNP np (iPol p (iVP vp))))) ;
    iS (UseCl (TTAnt t ant) p (PredVPadv np vp)) = ExistE (iTense t (iAnt ant (iNPadv np (iPol p (iVP vp))))) ; -- for restricting PP scope


fun iNPadv : AdverbNP -> (Ind -> Event -> Prop) -> Event -> Prop ;  -- for restricting PP scope
def iNPadv (AdvNPnew np pp)  = iPP pp (iNP np) ;  -- for restricting PP scope


-- Same as iAdv, but prepositional phrases modifying a noun phrase.
fun iPP : Adv -> ((Ind -> Event -> Prop) -> Event -> Prop) ->
                  (Ind -> Event -> Prop) -> Event -> Prop ;
def iPP (PrepNP prep np) npf vpf = npf (\x,e -> iNP np (\y,e -> And (vpf x e) (iPrep prep x y)) e) ;
    iPP (PrepNPadv prep np) npf vpf = npf (\x,e -> iNPadv np (\y,e -> And (vpf x e) (iPrep prep x y)) e) ; -- for restricting PP scope


-- A verb phrase is a function that takes an individual and returns a proposition about an event.
-- Other individuals are introduced by calling iNP inside iVP.
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
    iVP (ComplSlashadv (Slash3V3 v3 arg2) arg1) = \subj -> iNPadv arg1 (\x1 -> iNP arg2 (\x2 -> iV3 v3 subj x1 x2)) ; -- for restricting PP scope

    -- passive voice
    iVP (PassVPSlash (SlashV2a v2))      = iV2Pass v2 ;
    iVP (PassVPSlash (Slash3V3 v3 arg2)) = \x1 -> iNP arg2 (\x2 -> iV3Pass v3 x1 x2) ;
    -- iVP (AdvVP vp adv)                    = iAdv adv (iVP vp) ;
    iVP (AdvVPnew vp adv)                    = iAdv adv (iVP vp) ; -- for restricting PP scope

    -- sentence as complement
    iVP (ComplVS vs (UseCl (TTAnt t ant) p (PredVP np vp))) =
        iVS vs (iTense t (iAnt ant (iNP np (iPol p (iVP vp))))) ;
    iVP (ComplVS vs (UseCl (TTAnt t ant) p (PredVPadv np vp))) = -- for restricting PP scope
        iVS vs (iTense t (iAnt ant (iNPadv np (iPol p (iVP vp))))) ;

    -- verb as complement
    iVP (ComplVV vv vp) = iVV vv (iVP vp) ;

-- Adverbs modify verb phrases.
-- In COGS the only adverb that modifies a verb phrase is "by" with an agent NP.
-- To extend COGS, other adverbs could be added here.
-- fun iAdv : Adv -> (Ind -> Event -> Prop) -> Ind -> Event -> Prop ;
-- def iAdv (PrepNP by8agent_Prep np) vpf = \i -> iNP np (\y,e -> And (vpf i e) (Agent y e)) ;
fun iAdv : AdvForVerb -> (Ind -> Event -> Prop) -> Ind -> Event -> Prop ; -- for restricting PP scope
def iAdv (PrepNPforverb by8agent_Prep np) vpf = \i -> iNP np (\y,e -> And (vpf i e) (Agent y e)) ; -- for restricting PP scope

}
