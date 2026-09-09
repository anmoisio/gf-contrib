-- constructors for Artificial, nonsense CNs 
abstract ArtificialCNs = Cat ** {
    cat
        PrepArtif1 ;
        PrepArtif2 ;
        PrepArtif3 ;
    data
        PrepArtif1NP : PrepArtif1 -> NP -> Adv ;
        PrepArtif2NP : PrepArtif2 -> NP -> Adv ;
        PrepArtif3NP : PrepArtif3 -> NP -> Adv ;

        a_PrepArtif1 : PrepArtif1 ;
        b_PrepArtif1 : PrepArtif1 ;
        c_PrepArtif1 : PrepArtif1 ;
        d_PrepArtif1 : PrepArtif1 ;
        e_PrepArtif1 : PrepArtif1 ;

        a_PrepArtif2 : PrepArtif2 ;
        b_PrepArtif2 : PrepArtif2 ;
        c_PrepArtif2 : PrepArtif2 ;
        d_PrepArtif2 : PrepArtif2 ;
        e_PrepArtif2 : PrepArtif2 ;

        a_PrepArtif3 : PrepArtif3 ;
        b_PrepArtif3 : PrepArtif3 ;
        c_PrepArtif3 : PrepArtif3 ;
        d_PrepArtif3 : PrepArtif3 ;
        e_PrepArtif3 : PrepArtif3 ;
} ;
