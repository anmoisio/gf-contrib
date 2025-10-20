
concrete CogsEng of Cogs = CatEng ** open ResEng, ParadigmsEng, Prelude  in {
    lincat
        VUnerg, VUnacc = Verb ;
        V3doc = Verb ** {c2, c3 : Str} ;
    lin
        VUnergV v = v ;
        VUnaccV v = v ;
        V3docV3 v = v ;
} ;
