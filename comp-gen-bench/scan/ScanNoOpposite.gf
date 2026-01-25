
abstract ScanStructGen = Scan
    - [OppositeVP]
    **
{
    flags startcat = Utt ;

    cat VPopp ;

    data
        UseVPopp    : VPopp -> Utt ;
        OppositeVP  : Verb -> Adv -> VPopp ;
}
