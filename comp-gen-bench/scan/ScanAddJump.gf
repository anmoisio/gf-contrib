
abstract ScanAddJump = Scan
    - [jump_V]
    **
{
    flags startcat = Utt ;

    cat VJ ;

    data
        UseVJ      : VJ -> Utt ;
        jump_VJ    : VJ ;
}
