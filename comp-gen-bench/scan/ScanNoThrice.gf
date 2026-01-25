
abstract ScanStructGen2 = Scan
    - [Thrice]
    **
{
    flags startcat = Utt ;

    cat ImpThrice ;

    data
        UseImpThrice    : ImpThrice -> Utt ;
        Thrice          : VP -> ImpThrice ;
}
