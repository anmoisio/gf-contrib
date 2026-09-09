-- constructors for Artificial, nonsense CNs 
concrete ArtificialCNsEng of ArtificialCNs = CatEng ** open ResEng in {
    lincat
        PrepArtif1, PrepArtif2 = {s : Str} ;

    lin
        PrepArtif1NP prep np = {s = prep.s ++ (np.s ! NPAcc)} ;
        PrepArtif2NP prep np = {s = prep.s ++ (np.s ! NPAcc)} ;

        a_PrepArtif1 = {s = "a1"} ;
        b_PrepArtif1 = {s = "b1"} ;
        c_PrepArtif1 = {s = "c1"} ;
        d_PrepArtif1 = {s = "d1"} ;
        e_PrepArtif1 = {s = "e1"} ;

        a_PrepArtif2 = {s = "a2"} ;
        b_PrepArtif2 = {s = "b2"} ;
        c_PrepArtif2 = {s = "c2"} ;
        d_PrepArtif2 = {s = "d2"} ;
        e_PrepArtif2 = {s = "e2"} ;

} ;
