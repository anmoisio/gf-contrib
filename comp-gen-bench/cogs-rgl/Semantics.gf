abstract Semantics = 
    Noun,
    Verb, 
    Adjective,
    Adverb,
    Numeral,
    Sentence, 
    Question,
    Relative,
    Conjunction,
    Phrase,
    Text,
    Structural,
    Idiom,
    Tense,
    Names,
    -- Transfer,

    -- not in Grammar.gf
    Extra,

    CogsLexicon,
    
    Logic ** {

flags startcat = Wrapper ;

cat
    Assert ; Presup ; Inds ; Events ;
    [Assert] {0} ;
    [Presup] {0} ;
    [Events] {0} ;
    [Inds] {0} ;

    Verb ;

-- needed in linearisation
fun Wrapper : Prop -> Prop ;

-- A sentence is a proposition.
fun iS : S -> Prop ;
def iS (UseCl (TTAnt t ant) p (PredVP np vp)) = ExistE (iTense t (iAnt ant (iNP np (iPol p (iVP vp))))) ;

-- After a noun phrase has combined with a verb phrase, the resulting
-- expression is a function that takes an event as its argument.
fun iNP : NP -> (Ind -> Event -> Prop) -> Event -> Prop ;
def
    iNP (DetCN det cn) = iDet det (iCN cn) ;
    iNP (UsePN pn)     = iPN pn ;
    iNP (AdvNP np pp)  = iPP pp (iNP np) ;

    -- NP conjunction creates a complex event property.                
    -- e.g., for "John and Mary ran", this yields                     
    -- \e -> And( (run(e) & Ag(e,j)), (run(e) & Ag(e,m)) )              
    -- which asserts a single event with two agents (or two events).  
    -- A simpler conjunction can also be defined.                     
    -- iNP (ConjNP conj x y) p = iConj_EP conj (iNP x p) (iNP y p) ;

-- A noun (a proposition about an individual) and a verb phrase (a proposition about
-- an individual and an event) combine into a proposition of event.
fun iDet : Det -> (Ind -> Prop) -> (Ind -> Event -> Prop) -> Event -> Prop ;
def
    iDet (DetQuant IndefArt NumSg) n vpf  = \e -> Exist (\x -> And (n x) (vpf x e)) ;
    -- iDet every_Det n vpf  = \e -> All   (\x -> If  (n x) (vpf x e)) ;
    iDet (DetQuant DefArt NumSg) n vpf    = \e -> Exist (\x -> And

            -- Russelian description:
            -- (n x)
            -- (And (All (\y -> If (n y) (Equals y x)))
            --      (vp x e)
            -- )

            -- Using uniqueness operator instead of Russelian description.
            -- (Unique n x) -- causes "index too large" error because it's not eta-expanded
            (Unique (\z -> n z) x)
            (vpf x e)
        ) ;

-- Proper nouns are individuals, and they combine with verb phrases,
-- similarly to nouns in iDet (only simpler).
fun PNInd : PN -> Ind ;
fun iPN : PN -> (Ind -> Event -> Prop) -> Event -> Prop ;
def iPN pn vpf = \e -> vpf (PNInd pn) e ;

-- Same as iAdv, but prepositional phrases modifying a noun phrase.
fun iPP : Adv -> ((Ind -> Event -> Prop) -> Event -> Prop) ->
                  (Ind -> Event -> Prop) -> Event -> Prop ;
def iPP (PrepNP prep np) npf vpf =
    npf (\x,e -> iNP np (\y,e -> And (vpf x e) (Nmod prep x y)) e) ;

-- Tense adds a temporal predicate to the event property. Same for Ant.
fun
    iTense : Tense -> (Event -> Prop) -> Event -> Prop ;
    iAnt : Ant -> (Event -> Prop) -> Event -> Prop ;
def
    iTense t p = \e -> And (p e) (Time t e) ;
    iAnt ant p = \e -> And (p e) (Anteriority ant e) ;

fun iPol : Pol   -> (Ind -> Event -> Prop) -> (Ind -> Event -> Prop) ;
def
    -- Polarity over subject-indexed event properties (used before iNP)
    iPol PPos F = F ;
    iPol PNeg F = \x,e -> Not (F x e) ;

-- Conjunction for propositions (S) and event properties (NP) 
fun iConj : Conj -> Prop -> Prop -> Prop ;
def
    iConj and_Conj a b = And a b ;
    iConj or_Conj  a b = Or a b ;

fun iConj_EP : Conj -> (Event -> Prop) -> (Event -> Prop) -> (Event -> Prop) ;
def
    iConj_EP and_Conj P Q = \e -> And (P e) (Q e) ;
    iConj_EP or_Conj  P Q = \e -> Or (P e) (Q e) ;


-- A verb phrase is a function that takes an individual and returns a proposition about an event.
-- Other individuals are introduced by calling iNP inside iVP.
fun iVP : VP -> Ind -> Event -> Prop ;
def
    -- UseV applies the lexical verb's meaning directly.
    iVP (UseV (VUnergV v)) i = iVCaus v i ;
    iVP (UseV (VUnaccV v)) i = iVIncho v i ;

    -- The object NP takes the transitive verb as its scope.
    -- `i` is the subject, `y` will be the direct object variable, and z the oblique object.
    -- The result of `iNP np (...)` is the final Event -> Prop for the subject `i`.
    iVP (ComplSlash (SlashV2a v2) np) i = iNP np (\y -> iV2 v2 y i) ;

    -- Slash2V3 and Slash3V3 are same but np_oo and np_do switch places; the have the same meaning
    iVP (ComplSlash (Slash2V3 v3 np_do) np_oo) i = iNP np_oo (\z -> iNP np_do (\y -> iV3 v3 y z i)) ;
    iVP (ComplSlash (Slash3V3 v3 np_oo) np_do) i = iNP np_oo (\z -> iNP np_do (\y -> iV3 v3 y z i)) ;

    -- passive voice
    iVP (PassVPSlash (SlashV2a v2)) i       = iV2Pass v2 i ;
    iVP (PassVPSlash (Slash3V3 v3 np_oo)) i = iNP np_oo (\z -> iV3Pass v3 z i) ;
    iVP (AdvVP vp adv) i                    = iAdv adv (iVP vp) i ;

    -- sentence as complement
    iVP (ComplVS vs (UseCl (TTAnt t ant) p (PredVP np vp))) i =
        iVS vs (iTense t (iAnt ant (iNP np (iPol p (iVP vp))))) i ;

    -- verb as complement
    -- iVP (ComplVV TODO)

-- Adverbs modify verb phrases.
-- In COGS the only adverb that modifies a verb phrase is "by" with an agent NP.
-- To extend COGS, other adverbs could be added here.
fun iAdv : Adv -> (Ind -> Event -> Prop) -> Ind -> Event -> Prop ;
def iAdv (PrepNP by8agent_Prep np) vpf i = iNP np (\y,e -> And (Agent y e) (vpf i e)) ;


-- A noun is a proposition about an individual.
-- (iCN is is kind of redundant when the only case is UseN.)
fun iCN : CN -> Ind -> Prop ;
def iCN (UseN n) = iN n ;


-- A verb is a proposition about 1-3 individuals and an event
fun
    iVCaus  : VUnerg -> Ind             -> Event -> Prop ;
    iVIncho : VUnacc -> Ind             -> Event -> Prop ;
    iV2     : V2 -> Ind -> Ind          -> Event -> Prop ;
    iV3     : V3 -> Ind -> Ind -> Ind   -> Event -> Prop ;
    iV2Pass : V2 -> Ind                 -> Event -> Prop ;
    iV3Pass : V3 -> Ind -> Ind          -> Event -> Prop ;
def
    -- iVCaus  v i e            = Agent (VVerb v) i e ;
    -- iVIncho v i e            = Theme (V2Verb v) i e ;
    -- iV2 v obj subj e         = And (Agent (V2Verb v) subj e) (Theme (V2Verb v) obj e) ;
    -- iV3 v3 dobj oobj subj e  = And (And
    --     (Agent (V3Verb v3) subj e) (Theme (V3Verb v3) dobj e)) (Recipient v3 oobj e) ;
    iVCaus  v i e            = And (VUnergEvent v e) (Agent i e) ;
    iVIncho v i e            = And (VUnaccEvent v e) (Theme i e) ;
    iV2 v obj subj e         = And (V2Event v e) (And (Agent subj e) (Theme obj e)) ;
    iV3 v3 dobj oobj subj e  = And (V3Event v3 e) (And (Agent subj e) (And
                                                       (Theme dobj e)
                                                       (Recipient oobj e))) ;
    iV2Pass v i e            = And (V2Event v e) (Theme i e) ; -- same as iVIncho
    iV3Pass v3 oobj dobj e   = And (V3Event v3 e) (And (Theme dobj e)
                                                      (Recipient oobj e)) ;
    

fun iVS : VS -> (Event -> Prop) -> Ind -> Event -> Prop ;
def
    iVS vs eprop subj e = And
        (And (VSEvent vs e) (Agent subj e))
        (ExistE (\e2 -> And
            (Ccomp e2 e)
            (eprop e2)
        )) ;

-- interpretation stops at the following functions

fun
    -- Uniqueness operator for definite descriptions
    Unique : (Ind -> Prop) -> Ind -> Prop ;


fun
    -- Thematic Role Predicates with dot notation structure
    -- Agent       : Verb -> Ind   -> Event -> Prop ;  -- e.g. "paint . agent ( e , x )"
    -- Theme       : Verb -> Ind   -> Event -> Prop ;
    -- Recipient   : V3 -> Ind     -> Event -> Prop ;
    -- Ccomp       : VS -> Event   -> Event -> Prop ;  -- e_comp is first event arg

    -- without verb and dot notation
    Agent    :  Ind   -> Event -> Prop ;  -- just "agent ( e , x )"
    Theme    :  Ind   -> Event -> Prop ;
    Recipient:  Ind   -> Event -> Prop ;
    Ccomp    :  Event -> Event -> Prop ;

    Nmod      :  Prep -> Ind -> Ind -> Prop ;  -- e.g. "nmod . beside ( x , y )"

    Time        : Tense -> Event -> Prop ;
    Anteriority : Ant   -> Event -> Prop ;


-- verb is a proposition about an event
fun
    VUnergEvent : VUnerg    -> Event  -> Prop ;
    VUnaccEvent : VUnacc    -> Event  -> Prop ;
    V2Event     : V2        -> Event  -> Prop ;
    V3Event     : V3        -> Event  -> Prop ;
    VSEvent     : VS        -> Event  -> Prop ;


-- a noun is a proposition about an individual
fun iN : N -> Ind -> Prop ;


}
