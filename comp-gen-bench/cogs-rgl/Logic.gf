
-- neo-Davidsonian semantics
abstract Logic = {
    cat
        Prop ; Ind ; Event ;
    fun
        And, Or, If : Prop -> Prop -> Prop ;
        Not         : Prop -> Prop ;
        All, Exist  : (Ind -> Prop) -> Prop ;
        ExistE      : (Event -> Prop) -> Prop ;
        Equals      : Ind -> Ind -> Prop ;
        EmptyProp   : Event -> Prop ;
        DummyEvent  : Event ;


        -- Uniqueness operator for definite descriptions
        Unique      : (Ind -> Prop) -> Ind -> Prop ;

        -- thematic role predicates
        Agent, Theme, Recipient : Ind   -> Event -> Prop ;

        -- clausal complements
        Ccomp, Xcomp            : Event -> Event -> Prop ;

        -- the individual in questions: "who walks?" --> walk(QInd)
        QInd : Ind ;
}
