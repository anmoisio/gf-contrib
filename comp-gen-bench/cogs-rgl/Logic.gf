
-- neo-Davidsonian semantics
abstract Logic = {
    cat
        Prop ; Ind ; Event ;
    data
        And, Or, If : Prop -> Prop -> Prop ;
        Not         : Prop -> Prop ;
        All, Exist  : (Ind -> Prop) -> Prop ;
        ExistE      : (Event -> Prop) -> Prop ;
        Equals      : Ind -> Ind -> Prop ;
}
