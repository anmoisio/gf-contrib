
abstract ScanAddJump = Scan
    - [jump_V]
    **
{
    flags startcat = Utt ;

    cat VJ ;
        -- Utt ;       -- 13122 + 81 + 1 = 13204
        -- ConjImp ;   -- (81*81) + (81*81) = 13122
        -- Imp ;       -- 27 + 27 + 27 = 81
        -- VP ;        -- 3 + (4*2) + (4*2) + (4*2) = 27
        -- Adv ;       -- 2
        -- Verb ;      -- 3 + 1 = 5
        -- VD ;        -- 1
        -- VJ ;        -- 1
        -- V ;         -- 3

    data
        UseVJ      : VJ -> Utt ;
        jump_VJ    : VJ ;
}
