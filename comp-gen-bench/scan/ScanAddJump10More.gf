
abstract ScanAddJump = Scan - [jump_V] ** {
    flags startcat = Utt ;

    cat VJ ;

    data
        UseVJ       : VJ -> Utt ;
        jump_VJ     : VJ ;

        hop_V       : V ;
        swim_V      : V ;
        sprint_V    : V ;
        drive_V     : V ;
        leap_V      : V ;
        glide_V     : V ;
        crawl_V     : V ;
        dash_V      : V ;
        trot_V      : V ;
        gallop_V    : V ;
}
