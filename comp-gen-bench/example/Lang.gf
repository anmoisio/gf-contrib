
abstract Lang = {
    cat S ; NP ; VP ; V2 ; V1 ; V ; N ; Det ;
    data
        Sentence         : NP -> VP -> S ;
        Verb2phrase      : V2 -> NP -> VP ;
        Verb1phrase      : V1 -> VP ;
        Nounphrase       : Det -> N -> NP ;
        V2Verb           : V -> V2 ;
        V1Verb           : V -> V1 ;
        drink_V          : V ;
        a_Det, the_Det   : Det ;
        man_N, coffee_N  : N ;
}
