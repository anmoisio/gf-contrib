abstract Semantics = MiniGrammar, Logic ** {

flags startcat = Prop ;

cat
    Assert ; Presup ;
    [Assert] {0} ;
    [Presup] {0} ;

    Verb ;

fun
    VVerb  : V  -> Verb ;
    V2Verb : V2 -> Verb ;
    V3Verb : V3 -> Verb ;
    VSVerb : VS -> Verb ;


data
    -- Uniqueness operator for definite descriptions
    Unique : (Ind -> Prop) -> Ind -> Prop ;

    -- Thematic Role Predicates with dot notation structure
    Agent       : Verb -> Ind   -> Event -> Prop ;  -- e.g. "paint . agent ( e , x )"
    Theme       : Verb -> Ind   -> Event -> Prop ;
    Recipient   : V3 -> Ind     -> Event -> Prop ;
    Ccomp       : VS -> Event   -> Event -> Prop ;  -- e_comp is first event arg

    Time        : Event -> Tense -> Prop ;
    

fun iS : S -> Prop ;
def
    -- Push polarity into VP for simple clauses so subject quantification stays outside Not.
    iS (UseCl t p (PredVP np vp)) = ExistE (iTense t (iNP np (iPol p (iVP vp)))) ;
    -- iS (UseCl t p cl) = ExistE (iTense t (iPol p (iCl cl))) ;
    -- iS (UseCl t p cl) = ExistE (iCl cl) ;
    -- iS (ConjS conj x y) = iConj conj (iS x) (iS y) ;

-- fun iCl : Cl -> Event -> Prop ;
-- def
--     iCl (PredVP np vp) = iNP np (iVP vp) ;

fun iCl : Pol -> Cl -> Event -> Prop ;
def
    iCl PPos (PredVP np vp) = iNP np (iVP vp) ;
    iCl PNeg (PredVP np vp) = iNP np (iPol PNeg (iVP vp)) ;


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
    iDet a_Det     n vp  = \e -> Exist (\x -> And (n x) (vp x e)) ;
    iDet every_Det n vp  = \e -> All   (\x -> If  (n x) (vp x e)) ;
    iDet the_Det n vp    = \e -> Exist (\x -> And
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

fun
    iTense : Tense -> (Event -> Prop) -> Event -> Prop ;
    -- iPol   : Pol   -> (Event -> Prop) -> Event -> Prop ;
    iPol : Pol   -> (Ind -> Event -> Prop) -> (Ind -> Event -> Prop) ;
def
    -- Tense adds a temporal predicate to the event property. 
    iTense t P = \e -> And (P e) (Time e t) ;

    -- Polarity modifies the event property. 
    -- iPol PPos P = P ;
    -- iPol PNeg P = \e -> Not (P e) ;

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
    iVP (UseV v) i = iV v i ;

    -- The object NP takes the transitive verb as its scope.
    -- `i` is the subject, `y` will be the direct object variable, and z the oblique object.
    -- The result of `iNP np (...)` is the final Event -> Prop for the subject `i`.
    iVP (ComplV2 v np) i                    = iNP np (\y -> iV2 v y i) ;
    iVP (ComplV3 v np_dobj np_oobj) i       = iNP np_oobj (\z -> iNP np_dobj (\y -> iV3 v y z i)) ;
    iVP (ComplPrepV3 v np_dobj np_oobj) i   = iNP np_oobj (\z -> iNP np_dobj (\y -> iV3 v y z i)) ;

    -- sentence as complement
    -- iVP (ComplVS vs (UseCl t p cl)) i = iVS vs (iTense t (iPol p (iCl cl))) i ;
    iVP (ComplVS vs (UseCl t p cl)) i = iVS vs (iTense t (iCl p cl)) i ;

fun iCN : CN -> Ind -> Prop ;
def
    -- Common noun properties remain properties of individuals. 
    iCN (UseN n) = iN n ;
    -- iCN (ModCN ap cn) i = And (iAP ap i) (iCN cn i) ;


-- a noun is a proposition about an individual
fun iN : N -> Ind -> Prop ;


-- a verb is a proposition about 1-3 individual(s) and an event
-- Build a flat conjunction: paint.agent(e,subj) AND paint.theme(e,obj)
fun
    iV  : V  -> Ind                 -> Event -> Prop ;
    iV2 : V2 -> Ind -> Ind          -> Event -> Prop ;
    iV3 : V3 -> Ind -> Ind -> Ind   -> Event -> Prop ;
def
    iV  v i e                = Agent (VVerb v) i e ;
    iV2 v obj subj e         = And (Agent (V2Verb v) subj e) (Theme (V2Verb v) obj e) ;
    iV3 v3 dobj oobj subj e  = And (And
        (Agent (V3Verb v3) subj e) (Theme (V3Verb v3) oobj e)) (Recipient v3 dobj e) ;

fun iVS : VS -> (Event -> Prop) -> Ind -> Event -> Prop ;
def
    iVS vs eprop subj e = And
        (Agent (VSVerb vs) subj e)
        (ExistE (\e2 -> And
            (Ccomp vs e2 e)
            (eprop e2)
        )) ;

-- fun iAdA : AdA -> (Ind -> Prop) -> Ind -> Prop ;
-- def
--     -- Adverbs modify adjective properties
--     iAdA ada prop = prop ; -- placeholder - needs specific adverb definitions

}
