abstract SemanticsReCogs = Semantics - [PNInd, iPN] ** {

    flags startcat = Wrapper ;

    fun PNInd : PN -> Ind -> Prop ;

    fun iPN : PN -> (Ind -> Event -> Prop) -> Event -> Prop ;
    def iPN pn vpf = \e -> Exist (\x -> And (PNInd pn x) (vpf x e)) ;
    
}
