
abstract LangNPStructs = LangVPStructs,
    -- from abstract/Grammar.gf
    Noun [
        DetCN
        ,DetQuant
        ,NumSg
        -- ,NumPl
        -- ,UsePN
        ,IndefArt
        -- ,DefArt
        ,UseN
        ,AdjCN
        ,RelCN
        ,AdvCN
    ] ** {
flags startcat=S ;

} ;
