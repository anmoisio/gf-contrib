
abstract ScanStructGenMore = Scan
    - [OppositeVP]
    **
{
    flags startcat = Utt ;

    cat VPopp ;

    data
        UseVPopp    : VPopp -> Utt ;
        OppositeVP  : Verb -> Adv -> VPopp ;

        -- walk three_quarters left, I_TURN_LEFT I_TURN_LEFT I_TURN_LEFT I_WALK 
        ThreeQuartersVP  : Verb -> Adv -> VP ;
        -- walk five_quarters left, I_TURN_LEFT I_TURN_LEFT I_TURN_LEFT I_TURN_LEFT I_TURN_LEFT I_WALK 
        FiveQuartersVP  : Verb -> Adv -> VP ;
        -- walk one_and_a_half left, I_TURN_LEFT I_TURN_LEFT I_TURN_LEFT I_TURN_LEFT I_TURN_LEFT I_TURN_LEFT I_TURN_LEFT I_WALK 
        OneAndHalfVP  : Verb -> Adv -> VP ;
        -- walk much left, I_TURN_LEFT I_WALK I_WALK
        MuchVP  : Verb -> Adv -> VP ;
        -- walk mucher left, I_TURN_LEFT I_WALK I_WALK I_WALK
        MucherVP  : Verb -> Adv -> VP ;

}
