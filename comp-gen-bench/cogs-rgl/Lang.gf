
abstract Lang =

    -- from abstract/Grammar.gf
    Noun,
    Verb, 
    Adjective,
    Adverb,
    Numeral,
    Sentence, 
    Question,
    Relative,
    Conjunction,
    Phrase,
    Text,
    Structural,
    Idiom,
    Tense,
    Names,
    -- Transfer,

    -- not in Grammar.gf
    Extra,

    -- from abstract/Lang.gf
    -- Construction,
    -- Documentation,
    -- Markup - [stringMark],

    -- from the cogs dataset
    CogsLexicon

    ** {
flags startcat=Phr ;

-- fun
--     PassV3   : V3 -> VP ; -- was given to him by a mailman
} ;
