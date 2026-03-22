
concrete LangEng of Lang =

    -- from english/GrammarEng.gf
    NounEng - [
        DetNP
        -- ,AdvCN
        ,ExtAdvNP
        ,RelNP
        ,SentCN
        ,ApposCN
        ,AdvNP -- this is for "Paris today", should not be used for "a house on a hill" which is our use case
    ],
    VerbEng - [
        -- AdvVPSlash would be need to modify a verb with a prep phrase
        -- note that we're simplifying the language a lot when we get rid of
        -- the scope ambiguity of adverbs
        AdvVPSlash,
        PassV2,         -- replaced by PassVPSlash
        VPSlashPrep,
        SlashVV,
        ReflVP,
        UseComp,
        ExtAdvVP
        ,Slash2V3 -- having Slash3V3 is enough for COGS
    ],
    AdjectiveEng,
    AdverbEng - [
        SubjS -- SubjS  : Subj -> S -> Adv ; -- when she sleeps
    ],
    -- NumeralEng,
    SentenceEng - [PredSCVP],
    QuestionEng,
    RelativeEng,
    ConjunctionEng,
    -- PhraseEng,
    TextX - [Pol,PPos,PNeg,SC,CAdv],
    StructuralEng - [
        -- want_VV,
        by8means_Prep   -- only by8agent_Prep is used
        ,whatPl_IP      -- only use singular IPs
        ,whoPl_IP
    ], 
    -- IdiomEng,
    TenseX - [Pol,PPos,PNeg,SC,CAdv],
    -- NamesEng

    -- not in Grammar.gf
    ExtendEng [
        PassVPSlash
        ,passVPSlash
        -- ,PassAgentVPSlash
        ,PresPartAP     -- participial construction
    ],

    

    -- from english/LangEng.gf
    -- ConstructionEng,
    -- DocumentationEng, --# notpresent
    -- MarkupEng - [stringMark],

    -- from the cogs dataset
    -- CogsEng,
    CogsLexiconEng

    ** open ResEng, Prelude in {

flags startcat = Phr ; unlexer = text ; lexer = text ;

lin
    PPos = {s = [] ; p = CPos} ;
    PNeg = {s = [] ; p = CNeg True} ; -- contracted: don't

} ;
