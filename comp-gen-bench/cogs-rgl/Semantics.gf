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
    Assert ; Presup ; 
    [Assert] {0} ;
    [Presup] {0} ;
    [Event] {0} ;
    [Ind] {0} ;

    Verb ;

-- needed in linearisation
fun Wrapper : Prop -> Prop ;


-- should polarity be an argument of clause or predicate?
fun iS : S -> Prop ;
def iS (UseCl (TTAnt t ant) p (PredVP np vp)) = ExistE (iTense t (iAnt ant (iNP np (iPol p (iVP vp))))) ;

-- fun iCl : Pol -> Cl -> Event -> Prop ;
-- def iCl p (PredVP np vp) = iNP np (iPol p (iVP vp)) ;


-- After a noun phrase has combined with a verb phrase, the resulting
-- expression is a function that takes an event as its argument.
fun iNP : NP -> (Ind -> Event -> Prop) -> Event -> Prop ;
def
    iNP (DetCN det cn) vp    = iDet det (iCN cn) vp ;
    iNP (UsePN pn) vp        = (iPN pn) vp ;

    -- NP conjunction creates a complex event property.                
    -- e.g., for "John and Mary ran", this yields                     
    -- \e -> And( (run(e) & Ag(e,j)), (run(e) & Ag(e,m)) )              
    -- which asserts a single event with two agents (or two events).  
    -- A simpler conjunction can also be defined.                     
    -- iNP (ConjNP conj x y) p = iConj_EP conj (iNP x p) (iNP y p) ;

-- a noun (proposition that takes an individual) and a verb phrase
-- (proposition that takes an individual and an event) combine into a proposition of event
fun iDet : Det -> (Ind -> Prop) -> (Ind -> Event -> Prop) -> Event -> Prop ;
def
    iDet (DetQuant IndefArt NumSg) n vp  = \e -> Exist (\x -> And (n x) (vp x e)) ;
    -- iDet every_Det n vp  = \e -> All   (\x -> If  (n x) (vp x e)) ;
    iDet (DetQuant DefArt NumSg) n vp    = \e -> Exist (\x -> And
            -- (n x)
            -- (And (All (\y -> If (n y) (Equals y x)))
            --      (vp x e)
            -- )

            -- using uniqueness operator instead of russelian description
            -- (Unique n x) -- causes "index too large" error because it's not eta-expanded
            (Unique (\z -> n z) x)
            (vp x e)
        ) ;

-- a proper noun (an individual) and a verb phrase
-- (proposition that takes an individual and an event) combine into a proposition of event
fun PNInd : PN -> Ind ;
fun iPN : PN -> (Ind -> Event -> Prop) -> Event -> Prop ;
def iPN pn vp = \e -> vp (PNInd pn) e ;

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

fun iVP : VP -> Ind -> Event -> Prop ;
def
    -- UseV applies the lexical verb's meaning directly.
    iVP (UseV v) i = iVCaus v i ;

    -- The object NP takes the transitive verb as its scope.
    -- `i` is the subject, `y` will be the direct object variable, and z the oblique object.
    -- The result of `iNP np (...)` is the final Event -> Prop for the subject `i`.
    -- iVP (ComplV2 v np) i                    = iNP np (\y -> iV2 v y i) ;
    -- iVP (ComplV3 v np_dobj np_oobj) i       = iNP np_oobj (\z -> iNP np_dobj (\y -> iV3 v y z i)) ;
    -- iVP (ComplPrepV3 v np_dobj np_oobj) i   = iNP np_oobj (\z -> iNP np_dobj (\y -> iV3 v y z i)) ;

    iVP (ComplSlash (SlashV2a v2) np) i             = iNP np (\y -> iV2 v2 y i) ;
    iVP (ComplSlash (Slash2V3 v3 np_do) np_oo) i    = iNP np_oo (\z -> iNP np_do (\y -> iV3 v3 y z i)) ;
    -- np_oo and np_do switch places
    iVP (ComplSlash (Slash3V3 v3 np_oo) np_do) i    = iNP np_oo (\z -> iNP np_do (\y -> iV3 v3 y z i)) ;

    -- passive voice
    iVP (PassVPSlash (SlashV2a v2)) i   = iVIncho v2 i ;
    iVP (AdvVP vp adv) i                = iAdv adv (iVP vp) i ;

    -- sentence as complement
    -- iVP (ComplVS vs (UseCl t p cl)) i = iVS vs (iTense t (iPol p (iCl cl))) i ;
    iVP (ComplVS vs (UseCl (TTAnt t ant) p (PredVP np vp))) i = iVS vs (iTense t (iAnt ant (iNP np (iPol p (iVP vp))))) i ;

    -- verb as complement
    -- iVP (ComplVV TODO)


fun iAdv : Adv -> (Ind -> Event -> Prop) -> Ind -> Event -> Prop ;
def
    iAdv (PrepNP by8agent_Prep np) vpf i e = (iNP np (\y,e2 -> And (Agent y e2) (vpf i e2))) e ;




fun iCN : CN -> Ind -> Prop ;
def
    -- Common noun properties remain properties of individuals. 
    iCN (UseN n) = iN n ;
    -- iCN (ModCN ap cn) i = And (iAP ap i) (iCN cn i) ;


-- a verb is a proposition about 1-3 individual(s) and an event
-- Build a flat conjunction: paint.agent(e,subj) AND paint.theme(e,obj)
fun
    iVCaus  : V  -> Ind                 -> Event -> Prop ;
    iVIncho : V2 -> Ind                 -> Event -> Prop ;
    iV2     : V2 -> Ind -> Ind          -> Event -> Prop ;
    iV3     : V3 -> Ind -> Ind -> Ind   -> Event -> Prop ;
def
    -- iVCaus  v i e            = Agent (VVerb v) i e ;
    -- iVIncho v i e            = Theme (V2Verb v) i e ;
    -- iV2 v obj subj e         = And (Agent (V2Verb v) subj e) (Theme (V2Verb v) obj e) ;
    -- iV3 v3 dobj oobj subj e  = And (And
    --     (Agent (V3Verb v3) subj e) (Theme (V3Verb v3) oobj e)) (Recipient v3 dobj e) ;
    iVCaus  v i e            = And (VEvent v e) (Agent i e) ;
    iVIncho v i e            = And (V2Event v e) (Theme i e) ;
    iV2 v obj subj e         = And (V2Event v e) (And (Agent subj e) (Theme obj e)) ;
    iV3 v3 dobj oobj subj e  = And (V3Event v3 e) (And (Agent subj e) (And (Theme oobj e) (Recipient dobj e))) ;

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

    Agent    :  Ind   -> Event -> Prop ;  -- just "agent ( e , x )"
    Theme    :  Ind   -> Event -> Prop ;
    Recipient:  Ind   -> Event -> Prop ;
    Ccomp    :  Event -> Event -> Prop ;

    Time        : Tense -> Event -> Prop ;
    Anteriority : Ant   -> Event -> Prop ;


-- verb is a proposition about an event
fun
    VEvent  : V  -> Event  -> Prop ;
    V2Event : V2 -> Event  -> Prop ;
    V3Event : V3 -> Event  -> Prop ;
    VSEvent : VS -> Event  -> Prop ;


-- a noun is a proposition about an individual
fun iN : N -> Ind -> Prop ;


}
