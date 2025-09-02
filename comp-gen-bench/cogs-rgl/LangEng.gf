
concrete LangEng of Lang =
    
    NounEng - [AdvNP,ExtAdvNP,RelNP,ApposCN],
    VerbEng - [
    -- AdvVPSlash would be need to modify a verb with a prep phrase
    -- note that we're simplifying the language a lot when we get rid of
    -- the scope ambiguity of adverbs
        AdvVPSlash, 
        VPSlashPrep,Slash3V3,ReflVP,UseComp,ExtAdvVP],
    AdjectiveEng,
    AdverbEng,
    -- NumeralEng,
    SentenceEng - [PredSCVP],
    -- QuestionEng,
    RelativeEng,
    ConjunctionEng,
    PhraseEng,
    TextX - [Pol,PPos,PNeg,SC,CAdv],
    StructuralEng - [
        -- want_VV,
        by8means_Prep -- only by8agent_Prep is used
    ], 
    -- IdiomEng,
    TenseX - [Pol,PPos,PNeg,SC,CAdv],
    -- NamesEng
    CogsLexiconEng
    ** open ResEng, Prelude in {

flags startcat = Phr ; unlexer = text ; lexer = text ;

lin
    PPos = {s = [] ; p = CPos} ;
    PNeg = {s = [] ; p = CNeg True} ; -- contracted: don't

    PassV3 v = insertObj (\\_ => v.s ! VPPart ++ v.p) (predAux auxBe) ;

} ;
