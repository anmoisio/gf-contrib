resource MiniResEng = open Prelude in {

param
  Number = Sg | Pl ;
  Case = Nom | Acc ;
  Person = Per1 | Per2 | Per3 ;

  Agreement = Agr Number Person ;

  VForm = Inf | PresSg3 | Past | PastPart | PresPart ;

oper
  Noun : Type = {s : Number => Str} ;

  mkNoun : Str -> Str -> Noun = \sg,pl -> {
    s = table {Sg => sg ; Pl => pl}
    } ;

  regNoun : Str -> Noun = \sg -> mkNoun sg (sg + "s") ;

  -- smart paradigm
  smartNoun : Str -> Noun = \sg -> case sg of {
    _ + ("ay"|"ey"|"oy"|"uy") => regNoun sg ;
    x + "y" => mkNoun sg (x + "ies") ;
    _ + ("ch"|"sh"|"s"|"o") => mkNoun sg (sg + "es") ;
    _       => regNoun sg
    } ;

  mkN = overload {
   mkN : Str -> Noun = smartNoun ;
   mkN : Str -> Str -> Noun = mkNoun ;
   } ;

  ProperName : Type = {s : Str} ;

  mkPN : Str -> ProperName = \s -> {s = s} ;

  Adjective : Type = {s : Str} ;

  mkA : Str -> Adjective = \s -> {s = s} ;

  Verb : Type = {s : VForm => Str} ;

  mkVerb : (inf,pres,past,pastp,presp : Str) -> Verb =
    \inf,pres,past,pastp,presp -> {
    s = table {
      Inf => inf ;
      PresSg3 => pres ;
      Past => past ;
      PastPart => pastp ;
      PresPart => presp
      }
    } ;


   regVerb : Str -> Verb = \s ->
     mkVerb s (s + "s") (s + "ed") (s + "ed") (s + "ing") ;

   smartVerb : Str -> Verb = \inf -> case inf of {
    _ + ("ay"|"ey"|"oy"|"uy") => regVerb inf ;
    x + "y" =>
      mkVerb inf (x + "ies") (x + "ied") (x + "ied") (inf + "ing") ;
    x + "e" =>
      mkVerb inf (inf + "s") (x + "ed") (x + "ed") (x + "ing") ;
    _ + ("ch"|"sh"|"s"|"o") =>
      mkVerb inf (inf + "es") (inf + "ed") (inf + "ed") (inf + "ing") ;
    _       => regVerb inf
    } ;
 
  mkV = overload {
   mkV : Str -> Verb = smartVerb ;
   mkV : (inf,past,pastp : Str) -> Verb =
     \inf,past,pastp -> {
       s = table {
         Past => past ;
	 PastPart => pastp ;
	 f => (smartVerb inf).s ! f
	 }
       } ;
   mkV : (inf,pres,past,pastp,presp : Str) -> Verb = mkVerb ;
   } ;

  Verb2 : Type = Verb ** {c : Str} ;

  mkV2 = overload {
    mkV2 : Str         -> Verb2 = \s   -> mkV s ** {c = []} ;
    mkV2 : Str  -> Str -> Verb2 = \s,p -> mkV s ** {c = p} ;
    mkV2 : Verb        -> Verb2 = \v   -> v ** {c = []} ;
    mkV2 : Verb -> Str -> Verb2 = \v,p -> v ** {c = p} ;
    } ;

  Adverb : Type = {s : Str} ;

  mkAdv : Str -> Adverb = \s -> {s = s} ;

   noVerb = mkVerb "" "" "" "" "" ;
   do_Verb = mkVerb "do" "does" "did" "done" "doing" ;
   have_Verb = mkVerb "have" "has" "had" "had" "having" ;

  be_GVerb : GVerb = {
     s = table {
       PresSg1 => "am" ;
       PresPl  => "are" ;
       PastPl  => "were" ;
       VF vf   => (mkVerb "be" "is" "was" "been" "being").s ! vf
       } ;
     isAux = True
     } ;

  GVerb : Type = {
     s : GVForm => Str ;
     isAux : Bool
     } ;

 param
   GVForm = VF VForm | PresSg1 | PresPl | PastPl ;

 oper
   verb2gverb : Verb -> GVerb = \v -> {s =
     table {
        PresSg1 => v.s ! Inf ;
        PresPl  => v.s ! Inf ;
        PastPl  => v.s ! Past ;
        VF vf   => v.s ! vf
     } ;
      isAux = False
   } ;

}