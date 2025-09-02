
abstract Lang = 
    Noun,
    Verb, 
    Adjective,
    Adverb,
    --   Numeral,
    Sentence, 
    --   Question,
    Relative,
    Conjunction,
    Phrase,
    Text,
    Structural,
    --   Idiom,
    Tense,
    --   Names,
    Transfer,
    CogsLexicon
    ** {
flags startcat=S ;

fun
    PassV3   : V3 -> VP ; -- was given to him by a mailman
} ;
