-- constructors for Artificial, nonsense CNs 
concrete ArtificialCNsLF of ArtificialCNs = CatEng ** open ResEng in {
    lincat
        Prop = {
            s : Str ;
            events : [Events] ;
            inds : [Inds] ;
            presups : [Presup] ;
            asserts : [Assert] ;
            head : [Assert]
        } ;

        -- GF book section 8.7 and blog post https://inariksit.github.io/gf/2021/02/22/lists.html
        Assert, Presup, Inds, Events           = {s : Str ; isEmpty : IsEmpty} ;
        [Assert], [Presup], [Inds], [Events]   = {s : Str ; isEmpty : IsEmpty } ;

        PrepArtif1, PrepArtif2 = {s : Str} ;

    lin



} ;
