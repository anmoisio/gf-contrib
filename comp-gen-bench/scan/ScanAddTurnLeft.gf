
abstract ScanAddTurnLeft = Scan
    - [left_Adv,right_Adv,DirVP]
    **
{
    flags startcat = Utt ;

    cat AdvLeft ; AdvRight ;
        -- Utt ;       -- 15138 + 87 = 15225
        -- ConjImp ;   -- (87*87) + (87*87) = 15138
        -- Imp ;       -- 29 + 29 + 29 = 87
        -- VP ;        -- 4 + (5*1) + (5*2) + (5*2) = 29
        -- Adv ;       -- 2
        -- AdvLeft ;  -- 1
        -- AdvRight ; -- 1
        -- Verb ;      -- 4 + 1 = 5
        -- VD ;        -- 1
        -- V ;         -- 4

    data
        DirVP       : Verb -> AdvRight -> VP ;       -- walk left
        LeftAdv     : AdvLeft -> Adv ;
        RightAdv    : AdvRight -> Adv ;
        left_Adv    : AdvLeft ;
        right_Adv   : AdvRight ;
}
