
abstract CogsRestricted = Cogs ** {

cat AdverbNP ; AdvForVerb ; VerbPrep ; -- AdverbVP ;
data
    -- These restrict the scope of PP modifiers to the immideately previous NP
    PredVPadv   : AdverbNP -> VP -> Cl ;
    ComplSlashadv  : VPSlash -> AdverbNP -> VP ;
    Slash3V3adv    : V3  -> AdverbNP -> VPSlash ;
    AdvNPnew    : NP -> Adv -> AdverbNP ;
    PrepNPadv   : Prep -> AdverbNP -> Adv ;

    -- these restrict the AdvVP to only "by" adverb phrases
    AdvVPnew    : VP -> AdvForVerb -> VP ;
    PrepNPforverb : VerbPrep -> NP -> AdvForVerb ;
    by8agent_VerbPrep : VerbPrep ;
} ;
