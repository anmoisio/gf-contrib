concrete MiniGrammarEng of MiniGrammar = open MiniResEng, Prelude in {


  lincat
    Utt = {s : Str} ;
    Adv = Adverb ;
    -- Pol = {s : Str ; b : Bool} ;
    Pol   = {p  : Bool} ;
    Tense = {vf : VForm} ;
    
    S  = {s : Str} ;
    -- Cl = {s : Bool => Str} ;
    Cl = {subj : Str ; a : Agreement ; verb : GVerb ; compl : Str ; isAux : Bool} ;
    -- VP = {verb : GVerb ; compl : Str} ;
    VP = {verb : GVerb ; compl : Str ; isAux : Bool} ;
    AP = Adjective ;
    CN = Noun ;
    NP = {s : Case => Str ; a : Agreement} ;
    Pron = {s : Case => Str ; a : Agreement} ;
    Det = {s : Str ; n : Number} ;
    Conj = {s : Str} ;
    Prep = {s : Str} ;
    V = Verb ;
    V2 = Verb2 ;
    A = Adjective ;
    N = Noun ;
    PN = ProperName ;

  lin
    UttS s = s ;
    UttNP np = {s = np.s ! Acc} ;

    -- UsePresCl pol cl = {
    --   s = pol.s ++ cl.s ! pol.b
    --   } ;

    UseCl t p cl = {
      s = let
            agr = cl.a ;
	    verb = cl.verb.s
          in
          cl.subj ++
	  case <t.vf, p.p, agr, cl.isAux> of {
        <Inf,True ,Agr Sg Per3  ,_>     => verb ! VF PresSg3 ; 
        <Inf,True ,Agr Sg Per1  ,_>     => verb ! PresSg1 ;
        <Inf,True ,_            ,_>     => verb ! PresPl ;
	    <Inf,False,Agr Sg Per3  ,False> => do_Verb.s ! PresSg3 ++ "not" ++ verb ! VF Inf ;
	    <Inf,False,_            ,False> => do_Verb.s ! Inf ++ "not" ++ verb ! VF Inf ;
	    <Inf,False,Agr Sg Per3  ,_>     => verb ! VF PresSg3 ++ "not" ; 
        <Inf,False,Agr Sg Per1  ,_>     => verb ! PresSg1 ++ "not" ; 
        <Inf,False,_            ,_>     => verb ! PresPl ++ "not" ;

        <Past,True ,_           ,_>     => verb ! VF Past ; 
	    <Past,False,_  ,         _>      => do_Verb.s ! Past ++ "not" ++ verb ! VF Inf ;

        <_  ,True ,Agr Sg Per3  ,_>     => have_Verb.s ! PresSg3 ++ verb ! VF PastPart ; 
        <_ , True ,_            ,_>     => have_Verb.s ! Inf ++ verb ! VF PastPart ; 
	    <_,  False,Agr Sg Per3  ,_>     => have_Verb.s ! PresSg3 ++ "not" ++ verb ! VF PastPart ; 
	    <_,  False,_            ,_>     => have_Verb.s ! Inf ++ "not" ++ verb ! VF PastPart
            } ++
	  cl.compl ;
      } ;

    -- PredVP np vp = {
    --   s = \\b =>
    --        np.s ! Nom 
	-- ++ case <b, np.a, vp.verb.isAux> of {
	--     <True, Agr Sg Per1,_> => vp.verb.s ! PresSg1 ;
	--     <True, Agr Sg Per3,_> => vp.verb.s ! VF PresSg3 ;
	--     <True, _          ,_> => vp.verb.s ! PresPl ;
	--     <False, Agr Sg Per1,True>  => vp.verb.s ! PresSg1 ++ "not" ;
	--     <False, Agr Sg Per3,True>  => vp.verb.s ! VF PresSg3 ++ "not" ;
	--     <False, _          ,True>  => vp.verb.s ! PresPl ++ "not" ;
	--     <False, Agr Sg Per3,False> => "does not" ++ vp.verb.s ! VF Inf ;
	--     <False, _          ,False> => "do not" ++ vp.verb.s ! VF Inf
	--     }
    --     ++ vp.compl ;
    --   } ;
    PredVP np vp = {
      subj = np.s ! Nom ;
      a = np.a ;
      verb = vp.verb ;
      compl = vp.compl ;
      isAux = vp.isAux
      } ;

    UseV v = {
      verb = verb2gverb v ;
      compl = [] ;
      isAux = False
      } ;
    -- ComplV2 v2 np = {
    --   verb = verb2gverb v2 ;
    --   compl = v2.c ++ np.s ! Acc
    --   } ;
    ComplV2 v2 np = {
      verb = verb2gverb v2 ;
      compl = v2.c ++ np.s ! Acc ;
      isAux = False
      } ;
    UseAP ap = {
      verb = be_GVerb ;
      compl = ap.s ;
      isAux = False -- is this ok?
      } ;
    AdvVP vp adv =
      vp ** {compl = vp.compl ++ adv.s} ;
      
    DetCN det cn = {
      s = table {c => det.s ++ cn.s ! det.n} ;
      a = Agr det.n Per3
      } ;
    UsePN pn = {
      s = \\_ => pn.s ;
      a = Agr Sg Per3
      } ;
    UsePron p =
      p ;
    MassNP cn = {
      s = \\_ => cn.s ! Sg ;
      a = Agr Sg Per3
      } ;
    a_Det = {s = "a" ; n = Sg} ;
    aPl_Det = {s = "" ; n = Pl} ;
    the_Det = {s = "the" ; n = Sg} ;
    thePl_Det = {s = "the" ; n = Pl} ;
    UseN n =
      n ;
    AdjCN ap cn = {
      s = table {n => ap.s ++ cn.s ! n}
      } ;

    PositA a = a ;

    PrepNP prep np = {s = prep.s ++ np.s ! Acc} ;

    CoordS conj a b = {s = a.s ++ conj.s ++ b.s} ;
    
    PPos  = {s = [] ; p = True} ;
    PNeg  = {s = [] ; p = False} ;

    Pres = {vf = Inf} ;
    Imp = {vf = Past} ;
    Perf = {vf = PastPart} ;

    and_Conj = {s = "and"} ;
    or_Conj = {s = "or"} ;

    every_Det = {s = "every" ; n = Sg} ;

    in_Prep = {s = "in"} ;
    on_Prep = {s = "on"} ;
    with_Prep = {s = "with"} ;

    i_Pron = {
      s = table {Nom => "I" ; Acc => "me"} ;
      a = Agr Sg Per1
      } ;
    youSg_Pron = {
      s = \\_ => "you" ;
      a = Agr Sg Per2
      } ;
    he_Pron = {
      s = table {Nom => "he" ; Acc => "him"} ;
      a = Agr Sg Per3
      } ;
    she_Pron = {
      s = table {Nom => "she" ; Acc => "her"} ;
      a = Agr Sg Per3
      } ;
    we_Pron = {
      s = table {Nom => "we" ; Acc => "us"} ;
      a = Agr Pl Per1
      } ;
    youPl_Pron = {
      s = \\_ => "you" ;
      a = Agr Pl Per2
      } ;
    they_Pron = {
      s = table {Nom => "they" ; Acc => "them"} ;
      a = Agr Pl Per2
      } ;

}
