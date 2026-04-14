
concrete LangEng of Lang =

    NounEng [
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
    VerbEng [
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
    AdjectiveEng [
        PositA
    ],
    AdverbEng [
        PrepNP
    ],
    -- Numeral,
    SentenceEng [
        PredVP
        ,SlashVP
        ,SlashVS
        ,UseCl
        ,UseQCl
        ,UseRCl
        ,UseSlash
        ,ctr
    ],
    QuestionEng [
        QuestVP
        ,QuestSlash
        ,AdvIP
    ],
    RelativeEng [
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
    StructuralEng [
        by8agent_Prep
        ,in_Prep
        ,on_Prep
        ,whatSg_IP
        ,whoSg_IP
        ,want_VV
        ,and_Conj
    ],
    -- Idiom,
    TenseX [
        TTAnt
        -- ,PPos
        -- ,TPres
        ,TPast
        ,ASimul
        -- ,AAnter
    ],
    -- Names,
    -- Transfer,

    -- not in Grammar.gf
    -- Extra,
    ExtendEng [
        PresPartAP
        ,passVPSlash
        ,PassVPSlash
    ],

    -- from abstract/Lang.gf
    -- Construction,
    -- Documentation,
    -- Markup - [stringMark],

    -- from the cogs dataset
    -- Cogs,
    CogsLexiconEng

    ** open ResEng, Prelude in {

flags startcat = Phr ; unlexer = text ; lexer = text ;

lin
    PPos = {s = [] ; p = CPos} ;
    PNeg = {s = [] ; p = CNeg True} ; -- contracted: don't

} ;
