
abstract ExampleSemantics = MiniGrammar ** {

flags startcat = Prop ;

cat Prop ; Ind ; Event ;

fun iS : S -> Prop ;
def iS (UseCl t p (PredVP np vp)) = ExistE (iTense t (iNP np (iPol p (iVP vp)))) ;

fun iTense : Tense -> (Event -> Prop) -> Event -> Prop ;
def iTense t P = \e -> And (P e) (Time t e) ;

fun iNP : NP -> (Ind -> Event -> Prop) -> Event -> Prop ;
def iNP (DetCN det cn) vp = iDet det (iCN cn) vp ;

-- Polarity modifies the interpreted verb phrase
fun iPol : Pol -> (Ind -> Event -> Prop) -> (Ind -> Event -> Prop) ;
def
    iPol PPos vp = vp ;
    iPol PNeg vp = \x,e -> Not (vp x e) ;

fun iVP : VP -> Ind -> Event -> Prop ;
def
    iVP (UseV v) i = iV v i ;
    -- The object NP takes the transitive verb as its scope.
    -- i is the subject and y is the direct object variable
    iVP (ComplV2 v np) i = iNP np (\y -> iV2 v i y) ;

-- A noun and a verb phrase combine into a proposition of event
fun iDet : Det -> (Ind -> Prop) -> (Ind -> Event -> Prop) -> Event -> Prop ;
def
    iDet a_Det     n vp  = \e -> Exist (\x -> And (n x) (vp x e)) ;
    iDet every_Det n vp  = \e -> All   (\x -> If  (n x) (vp x e)) ;

-- A verb is a proposition about 1-2 individual(s) and an event
fun
    iV  : V  -> Ind        -> Event -> Prop ;
    iV2 : V2 -> Ind -> Ind -> Event -> Prop ;
def
    iV  v subj e     = Agent (VVerb v) subj e ;
    iV2 v subj obj e = And (Agent (V2Verb v) subj e) (Theme (V2Verb v) obj e) ;

-- A common noun is a proposition about an individual
fun iCN : CN -> Ind -> Prop ;
-- interpretation stops at nouns

fun
    Agent   : Verb -> Ind -> Event -> Prop ;
    Theme   : Verb -> Ind -> Event -> Prop ;
    Time    : Tense -> Event -> Prop ;

    And, Or, If : Prop -> Prop -> Prop ;
    Not         : Prop -> Prop ;
    All, Exist  : (Ind -> Prop) -> Prop ;
    ExistE      : (Event -> Prop) -> Prop ;

}
