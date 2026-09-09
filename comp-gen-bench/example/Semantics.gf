
abstract Semantics = Logic, Lang ** {
    fun iS : S -> Prop ;
    def iS (Sentence np vp) = ExistEvent (iNP np (iVP vp)) ;

    fun iDet : Det -> (Ind -> Prop) ->
                      (Ind -> Event -> Prop) -> Event -> Prop ;
    def
        iDet a_Det   nf vpf = \e -> Exist (\x -> And (nf x) (vpf x e)) ;
        iDet the_Det nf vpf = \e -> Exist (\x -> And 
                                (Unique (\z -> nf x) x) (vpf x e)) ;

    fun iNP : NP -> (Ind -> Event -> Prop) -> Event -> Prop ;
    def iNP (Nounphrase det n) vpf = iDet det (iN n) vpf ;

    fun iVP : VP -> Ind -> Event -> Prop ;
    def
        iVP (Verb2phrase v np) = \i -> iNP np (\y -> iV2 v i y) ;
        iVP (Verb1phrase v)    = iV1 v ;

    fun
        iV2 : V2 -> Ind -> Ind -> Event -> Prop ;
        iV1 : V1 -> Ind        -> Event -> Prop ;
    def
        iV2 (V2Verb v) subj obj e = And (iV v e) (And 
                                        (Agent subj e) (Theme obj e)) ;
        iV1 (V1Verb v) subj     e = And (iV v e) (Agent subj e) ;

    fun iV : V -> Event -> Prop ;
    fun iN : N -> Ind -> Prop ;
}
