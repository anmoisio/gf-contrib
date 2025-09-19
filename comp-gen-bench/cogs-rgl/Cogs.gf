-- things that are not in the RGL
-- but are needed for COGS
abstract Cogs = Cat ** {
    -- unergative-unaccusative distinction
    cat VUnerg ; VUnacc ; V3doc ;
    data
        VUnergV : VUnerg -> V ;
        VUnaccV : VUnacc -> V ;
        V3docV3 : V3doc -> V3 ;
} ;
