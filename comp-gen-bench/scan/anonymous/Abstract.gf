
abstract Abstract = {
  
    flags startcat = A ;

    cat
        A ; -- 20808 + 102 = 20910
        B ; -- (102*102) + (102*102) = 20808
        C ; -- 34 + 34 + 34 = 102
        D ; -- 4 + (5*2) + (5*2) + (5*2) = 34
        E ; -- 2
        F ; -- 4 + 1 = 5
        G ; -- 1
        H ; -- 4

    data
        BtoA        : B -> A ;
        CtoA        : C -> A ;

        CtoCtoB     : C -> C -> B ;
        CtoCtoB2    : C -> C -> B ;

        DtoC        : D -> C ;
        DtoC2       : D -> C ;
        DtoC3       : D -> C ;
        
        HtoD        : H -> D ;
        FtoEtoD     : F -> E -> D ;
        FtoEtoD2    : F -> E -> D ;
        FtoEtoD3    : F -> E -> D ;

        HtoF        : H -> F ;
        GtoF        : G -> F ;

        e1, e2              : E ;
        g                   : G ;
        h1, h2, h3, h4      : H ; 
}
