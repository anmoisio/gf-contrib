-- things that are not in the RGL
-- but are needed for COGS
abstract Cogs = Cat ** {
    -- unergative-unaccusative distinction
    cat VUnerg ; VUnacc ;
    data
        VUnergV : VUnerg -> V ;
        VUnaccV : VUnacc -> V ;
} ;
