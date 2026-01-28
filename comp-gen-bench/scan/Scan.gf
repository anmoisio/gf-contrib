
abstract Scan = {
  
    flags startcat = Utt ;

    cat
        Utt ;       -- 20808 + 102 = 20910
        ConjImp ;   -- (102*102) + (102*102) = 20808
        Imp ;       -- 34 + 34 + 34 = 102
        VP ;        -- 4 + (5*2) + (5*2) + (5*2) = 34
        Adv ;       -- 2
        Verb ;      -- 4 + 1 = 5
        VD ;        -- 1
        V ;         -- 4

    data
        UseConjImp  : ConjImp   -> Utt ;
        UseImp      : Imp       -> Utt ;

        CoordImp    : Imp -> Imp -> ConjImp ;   -- walk and jump
        CoordImpInv : Imp -> Imp -> ConjImp ;   -- walk after jump
        
        ImpVP       : VP -> Imp ;
        Twice       : VP -> Imp ;               -- walk twice
        Thrice      : VP -> Imp ;               -- walk thrice
        
        UseV        : V             -> VP ;       -- walk
        DirVP       : Verb -> Adv   -> VP ;       -- walk left
        OppositeVP  : Verb -> Adv   -> VP ;       -- walk opposite left
        AroundVP    : Verb -> Adv   -> VP ;       -- walk around left

        VVerb       : V     -> Verb ;           -- walk/run/look/jump
        VDVerb      : VD    -> Verb ;           -- turn

        left_Adv, right_Adv             : Adv ;
        turn_VD                         : VD ;
        walk_V, run_V, jump_V, look_V   : V ; 
}
