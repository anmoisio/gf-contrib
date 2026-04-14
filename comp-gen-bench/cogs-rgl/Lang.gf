
abstract Lang =
    -- from abstract/Grammar.gf
    Noun [
        DetCN
        ,DetQuant
        ,NumSg
        ,NumPl
        ,UsePN
        ,IndefArt
        ,DefArt
        ,UseN
        ,AdjCN
        ,RelCN
        ,AdvCN
    ],
    Verb [
        UseV
        ,ComplVV
        ,ComplVS
        ,ComplVQ
        ,SlashV2a
        ,Slash2V3
        ,Slash3V3
        ,SlashV2A
        ,ComplSlash
        ,AdvVP
    ], 
    Adjective [
        PositA
    ],
    Adverb [
        PrepNP
    ],
    -- Numeral,
    Sentence [
        PredVP
        ,SlashVP
        ,SlashVS
        ,UseCl
        ,UseQCl
        ,UseRCl
        ,UseSlash
    ],
    Question [
        QuestVP
        ,QuestSlash
        ,AdvIP
    ],
    Relative [
        RelVP
        ,RelSlash
        ,IdRP
    ],
    Conjunction [
        ConjS
        ,BaseS
    ],
    -- Phrase,
    -- Text,
    Structural [
        by8agent_Prep
        ,in_Prep
        ,on_Prep
        ,whatSg_IP
        ,whoSg_IP
        ,want_VV
        ,and_Conj
    ],
    -- Idiom,
    Tense [
        TTAnt
        ,PPos
        -- ,TPres
        ,TPast
        ,ASimul
        -- ,AAnter
    ],
    -- Names,
    -- Transfer,

    -- not in Grammar.gf
    -- Extra,
    Extend [
        PresPartAP
        ,PassVPSlash
    ],

    -- from abstract/Lang.gf
    -- Construction,
    -- Documentation,
    -- Markup - [stringMark],

    -- from the cogs dataset
    -- Cogs,
    CogsLexicon

    ** {
flags startcat=S ;

} ;
