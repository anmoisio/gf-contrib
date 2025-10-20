
concrete LangFin of Lang =

    -- from finnish/GrammarFin.gf
    NounFin - [
        DetNP,
        AdvCN,
        ExtAdvNP,
        RelNP,
        ApposCN
        -- DefArt, -- no articles in finnish, everything is indefinite
        -- MassNP
    ],
    VerbFin - [
        -- AdvVPSlash would be need to modify a verb with a prep phrase
        -- note that we're simplifying the language a lot when we get rid of
        -- the scope ambiguity of adverbs
        AdvVPSlash,
        PassV2,         -- replaced by PassVPSlash
        VPSlashPrep,
        ReflVP,
        UseComp,
        ExtAdvVP
        ,Slash2V3 -- having Slash3V3 is enough for COGS
    ],
    AdjectiveFin,
    AdverbFin - [
        SubjS -- SubjS  : Subj -> S -> Adv ; -- when she sleeps
    ],
    -- NumeralFin,
    SentenceFin - [PredSCVP],
    -- QuestionFin,
    RelativeFin,
    ConjunctionFin,
    -- PhraseFin,
    TextX,
    StructuralFin - [
        -- want_VV,
        by8means_Prep -- only by8agent_Prep is used
    ], 
    -- IdiomFin,
    TenseX,
    -- NamesFin

    -- not in Grammar.gf
    ExtraFin [
        PassVPSlash,
        passVPSlash
        -- ,PassAgentVPSlash
    ],

    -- from english/LangFin.gf
    -- ConstructionFin,
    -- DocumentationFin, --# notpresent
    -- MarkupFin - [stringMark],

    -- from the cogs dataset
    CogsFin,
    CogsLexiconFin

    ** {

flags startcat = Phr ; unlexer = finnish ; lexer = text ;

} ;
