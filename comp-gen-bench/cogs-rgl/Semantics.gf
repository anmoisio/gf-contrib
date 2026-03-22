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
    Extend,

    CogsLexicon,
    
    Logic ** {

flags startcat = Wrapper ;

cat
    Assert ; Presup ; Inds ; Events ;
    [Assert] {0} ;
    [Presup] {0} ;
    [Events] {0} ;
    [Inds] {0} ;


-- needed in linearisation
fun Wrapper : Prop -> Prop ;

-- A sentence is a proposition.
fun iS : S -> Prop ;
def iS (UseCl (TTAnt t ant) p (PredVP np vp)) = ExistE (iTense t (iAnt ant (iNP np (iPol p (iVP vp))))) ;

fun iQS : QS -> Prop ;
def
    iQS (UseQCl (TTAnt t ant) p (QuestVP ip vp))     = ExistE (iTense t (iAnt ant (iIP ip (iPol p (iVP vp))))) ;
    iQS (UseQCl (TTAnt t ant) p (QuestSlash ip cls)) = ExistE (iTense t (iAnt ant (iIP ip (iPol p (iClSlash cls))))) ;


-- A noun phrase is interpreted as a function that takes a verb phrase denotation
-- an returns a proposition about an event
fun iNP : NP -> (Ind -> Event -> Prop) -> Event -> Prop ;
def
    iNP (DetCN det cn) = iDet det (iCN cn) ;
    iNP (UsePN pn)     = iPN pn ;
    -- iNP (AdvNP np pp)  = iAdvNP pp (iNP np) ; -- this is for "Paris today", should not be used for "a house on a hill"

    -- NP conjunction creates a complex event property.                
    -- e.g., for "John and Mary ran", this yields                     
    -- \e -> And( (run(e) & Ag(e,j)), (run(e) & Ag(e,m)) )              
    -- which asserts a single event with two agents (or two events).  
    -- A simpler conjunction can also be defined.                     
    -- iNP (ConjNP conj x y) p = iConj_EP conj (iNP x p) (iNP y p) ;

-- like iVP but the missing individual is the object instead of subject: (whom) he sees
fun iClSlash : ClSlash -> Ind -> Event -> Prop ;
def
    -- same as "iVP (ComplSlash vpslash np)" except subj and obj switch places
    iClSlash (SlashVP np vps) =
        \obj -> iNP np (\subj -> iVPSlash vps subj obj) ;     -- (what) the boy sees 
    iClSlash (SlashVS np vs (UseSlash (TTAnt t ant) p cls)) = -- (what) the boy says that the cat saw
                                                              -- obj is in the complement
        \obj -> iNP np (\subj -> iVS vs (iTense t (iAnt ant ((iPol p (iClSlash cls)) obj))) subj) ;

-- An interrogative pronoun, e.g. "who walks?" --> walk(QInd)
fun iIP : IP -> (Ind -> Event -> Prop) -> Event -> Prop ;
def
    iIP (AdvIP _ adv) vpf = \e -> And (vpf QInd e) (iAdvCN adv QInd) ;
    iIP _ vpf = vpf QInd ; -- doesn't matter if ip is who/what/which/whom (?)

-- same as iIP but for relative clauses, e.g. "who walks" in "she saw the man who walks"
-- in SLOG the rp is always "that"
fun iRCl : RP -> (Ind -> Event -> Prop) -> Ind -> Event -> Prop ;
def
    iRCl IdRP vf i = vf i ;

-- A determiner is a function from a CN denotation to a NP denotation. 
-- A noun (a proposition about an individual) and a verb phrase (a proposition about
-- an individual and an event) combine into a proposition of event.
fun iDet : Det -> (Ind -> Prop) -> (Ind -> Event -> Prop) -> Event -> Prop ;
def
    iDet (DetQuant IndefArt NumSg) cnf vpf  = \e -> Exist (\x -> And (cnf x) (vpf x e)) ;
    -- iDet every_Det n vpf  = \e -> All   (\x -> If  (n x) (vpf x e)) ;
    iDet (DetQuant DefArt NumSg) cnf vpf    = \e -> Exist (\x -> And

            -- Russelian description:
            -- (n x)
            -- (And (All (\y -> If (n y) (Equals y x)))
            --      (vp x e)
            -- )

            -- Using uniqueness operator instead of Russelian description.
            -- (Unique cnf x) -- causes "index too large" error because it's not eta-expanded
            -- (Unique (\z -> cnf z) x)
            (Unique (\z -> cnf x) x)
            (vpf x e)
        ) ;

-- Tense adds a temporal predicate to the event property. Same for Ant.
fun
    iTense  : Tense -> (Event -> Prop) -> Event -> Prop ;
    iAnt    : Ant   -> (Event -> Prop) -> Event -> Prop ;
def
    iTense t p = \e -> And (p e) (Time t e) ;
    iAnt ant p = \e -> And (p e) (Anteriority ant e) ;

fun iPol : Pol -> (Ind -> Event -> Prop) -> Ind -> Event -> Prop ;
def
    iPol PPos vpf = vpf ;
    iPol PNeg vpf = \i,e -> Not (vpf i e) ;

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
    iVP (UseV v) = iV v ;

    -- The object NP takes the transitive verb as its scope.
    -- `i` is the subject, `y` will be the direct object variable, and z the oblique object.
    -- The result of `iNP np (...)` is the final Event -> Prop for the subject `i`.
    -- iVP (ComplSlash (SlashV2a v2) np) = \subj -> iNP np (\obj -> iV2 v2 subj obj) ;
    iVP (ComplSlash vpslash np) = \subj -> iNP np (\obj -> iVPSlash vpslash subj obj) ;

    -- Slash2V3 and Slash3V3 are same but np_oo and np_do switch places; the have the same meaning
    -- DOC: "give a dog a bone" vs. the normal "give a bone to a dog" also switches the order of the arguments
    -- so there are 2x2 possibilities.
    -- If v3 is a DOC, then arg1 is the indirect object (oobj) and arg2 the direct object (dobj).
    -- iVP (ComplSlash (Slash3V3 v3 arg2) arg1) = \subj -> iNP arg1 (\x1 -> iNP arg2 (\x2 -> iV3 v3 subj x1 x2)) ;

    -- passive voice
    iVP (PassVPSlash (SlashV2a v2))      = iV2Pass v2 ;
    iVP (PassVPSlash (Slash3V3 v3 arg2)) = \x1 -> iNP arg2 (\x2 -> iV3Pass v3 x1 x2) ;
    iVP (AdvVP vp adv)                    = iAdvVP adv (iVP vp) ;

    -- sentence as complement
    iVP (ComplVS vs (UseCl (TTAnt t ant) p (PredVP np vp))) = -- said that the boy walked
        iVS vs (iTense t (iAnt ant (iNP np (iPol p (iVP vp))))) ;

    -- verb as complement
    iVP (ComplVV vv vp) = iVV vv (iVP vp) ;

-- slashed verb is a proposition about an event and two noun phrases, the subject and object
fun iVPSlash : VPSlash -> Ind -> Ind -> Event -> Prop ;
def
    iVPSlash (SlashV2a v2) = iV2 v2 ;
    iVPSlash (Slash3V3 v3 n_oobj) = \subj,dobj -> iNP n_oobj (\oobj -> iV3 v3 subj dobj oobj) ;


-- Adverbs modify verb phrases, e.g. "is painted by a boy"
-- In COGS the only adverb that modifies a verb phrase is "by" with an agent NP.
-- To extend COGS, other adverbs could be added here.
fun iAdvVP : Adv -> (Ind -> Event -> Prop) -> Ind -> Event -> Prop ;
def iAdvVP (PrepNP by8agent_Prep np) vpf = \i -> iNP np (\y,e -> And (vpf i e) (Agent y e)) ;

-- Adverbs can also modify noun phrases, e.g. "Paris today" -- we might include this later
-- fun iAdvNP : Adv -> ((Ind -> Event -> Prop) -> Event -> Prop) ->
--                     (Ind -> Event -> Prop) -> Event -> Prop ;
-- def iAdvNP (PrepNP prep np) npf vpf =
--         npf (\x,e -> iNP np (\y,e -> And (vpf x e) (iPrep prep x y)) e) ;

-- Adverbs can also modify common nouns, e.g. "house on a hill"
-- But we interpret a prepositional phrase (type Adv) as a proposition about an individual
fun iAdvCN : Adv -> Ind -> Prop ;
def iAdvCN (PrepNP prep np) = \x -> ExistE (\e -> iNP np (\y,e' -> iPrep prep x y) e) ;

-- An adjective is a proposition about an individual.
fun iAP : AP -> Ind -> Prop ;
def
    -- simple adjective
    iAP (PositA a) = iA a ;
    -- participial phrase
    iAP (PresPartAP vp) = \x -> ExistE (\e -> (iVP vp x e)) ;

-- A noun is a proposition about an individual.
fun iCN : CN -> Ind -> Prop ;
def
    iCN (UseN n) = iN n ;
    iCN (AdvCN cn adv) = \x -> And (iCN cn x) (iAdvCN adv x) ;
    iCN (AdjCN adj cn) = \x -> And (iCN cn x) (iAP adj x) ;
    iCN (RelCN cn (UseRCl (TTAnt t ant) p (RelVP rp vp)))         = \x -> And (iCN cn x) (ExistE (iTense t (iAnt ant (iRCl rp (iPol p (iVP vp)) x)))) ;
    iCN (RelCN cn (UseRCl (TTAnt t ant) p (RelSlash rp clslash))) = \x -> And (iCN cn x) (ExistE (iTense t (iAnt ant (iRCl rp (iPol p (iClSlash clslash)) x)))) ;

-- Proper nouns are individuals, and they combine with verb phrases,
-- similarly to nouns in iDet (only simpler).
fun iPN : PN -> (Ind -> Event -> Prop) -> Event -> Prop ;
def iPN pn vpf = vpf (PNInd pn) ;

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
    iV (VUnergV v) i e      = And (VUnergEvent v e) (Agent i e) ;
    iV (VUnaccV v) i e      = And (VUnaccEvent v e) (Theme i e) ;
    iV2 v subj obj e        = And (V2Event v e) (And (Agent subj e) (Theme obj e)) ;
    iV3 (V3docV3 v3) subj oobj dobj e   = And (V3docEvent v3 e) (And (And
                                            (Agent subj e)
                                            (Recipient oobj e))
                                            (Theme dobj e)) ;
    iV3 v3           subj dobj oobj e   = And (V3Event v3 e) (And (And
                                            (Agent subj e)
                                            (Theme dobj e))
                                            (Recipient oobj e)) ;
    iV2Pass v obj e                     = And (V2Event v e) (Theme obj e) ;
    iV3Pass (V3docV3 v3) oobj dobj e    = And (V3docEvent v3 e) (And (Recipient oobj e) (Theme dobj e)) ;
    iV3Pass v3           dobj oobj e    = And (V3Event    v3 e) (And (Theme dobj e) (Recipient oobj e)) ;
    iVV vv vpf subj e                   = And (VVEvent vv e) (ExistE (\e2 -> And (And
                                            (Agent subj e)
                                            (Xcomp e e2)) 
                                            (vpf subj e2))) ;
    iVS vs eprop subj e                 = And
                                            (And (VSEvent vs e) (Agent subj e))
                                            (ExistE (\e2 -> And
                                                (Ccomp e e2)
                                                (eprop e2)
                                            )) ;


-- these could got to Logic.gf
fun
    -- Uniqueness operator for definite descriptions
    Unique      : (Ind -> Prop) -> Ind -> Prop ;

    -- thematic role predicates
    Agent       : Ind   -> Event -> Prop ;  -- agent ( e , x )
    Theme       : Ind   -> Event -> Prop ;
    Recipient   : Ind   -> Event -> Prop ;
    Ccomp       : Event -> Event -> Prop ;
    Xcomp       : Event -> Event -> Prop ;


-- interpretation stops at the lexical and morphological interpretation functions
fun
    -- verb is a proposition about an event
    VUnergEvent : VUnerg    -> Event -> Prop ;
    VUnaccEvent : VUnacc    -> Event -> Prop ;
    V2Event     : V2        -> Event -> Prop ;
    V3Event     : V3        -> Event -> Prop ;
    V3docEvent  : V3doc     -> Event -> Prop ;
    VVEvent     : VV        -> Event -> Prop ;
    VSEvent     : VS        -> Event -> Prop ;

    -- each noun and adjective is a proposition about an individual
    iN : N -> Ind -> Prop ;
    iA : A -> Ind -> Prop ;

    -- proper noun as Ind
    PNInd : PN -> Ind ;

    -- the individual in interrogative clauses "who walks?" --> walk(QInd)
    QInd : Ind ;

    -- prepositions are relations between individuals
    iPrep : Prep -> Ind -> Ind -> Prop ;  -- e.g. "nmod . beside ( x , y )"

    -- morphological features
    Time        : Tense -> Event -> Prop ;
    Anteriority : Ant   -> Event -> Prop ;

}
