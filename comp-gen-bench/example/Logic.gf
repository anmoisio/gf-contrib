abstract Logic = {
    cat Prop ; Ind ; Event ;
    fun
        Exist                   : (Ind -> Prop) -> Prop ;
        ExistEvent              : (Event -> Prop) -> Prop ;
        And                     : Prop -> Prop -> Prop ;
        Agent, Theme, Recipient : Ind -> Event -> Prop ;
        Unique                  : (Ind -> Prop) -> Ind -> Prop ;
}
