concrete CogsEng of Cogs = open Prelude in {
lincat
    AUX,
    BY,
    C,
    Det,
    INF,
    NP_animate_dobj,
    NP_animate_dobj_noPP,
    NP_animate_iobj,
    NP_animate_nsubj,
    NP_animate_nsubjpass,
    NP_beside,
    NP_dobj,
    NP_in,
    NP_inanimate_dobj,
    NP_inanimate_dobj_noPP,
    NP_inanimate_nsubjpass,
    NP_on,
    NP_unacc_subj,
    N_beside,
    N_common_animate_dobj,
    N_common_animate_iobj,
    N_common_animate_nsubj,
    N_common_animate_nsubjpass,
    N_common_inanimate_dobj,
    N_common_inanimate_nsubjpass,
    N_in,
    N_on,
    N_prop_dobj,
    N_prop_iobj,
    N_prop_nsubj,
    N_prop_nsubjpass,
    PP_iobj,
    PP_loc,
    P_beside,
    P_in,
    P_iobj,
    P_on,
    S,
    VP_external,
    VP_internal,
    VP_passive,
    VP_passive_dat,
    V_cp_taking,
    V_dat,
    V_dat_pp,
    V_inf,
    V_inf_taking,
    V_trans_not_omissible,
    V_trans_not_omissible_pp,
    V_trans_omissible,
    V_trans_omissible_pp,
    V_unacc,
    V_unacc_pp,
    V_unerg = {s : Str} ;

oper
	lin1args : (x1 : {s : Str}) -> {s : Str} = \x1 -> {s = x1.s} ;
	lin2args : (x1,x2 : {s : Str}) -> {s : Str} = \x1,x2 -> {s = x1.s ++ x2.s} ;
	lin3args : (x1,x2,x3 : {s : Str}) -> {s : Str} = \x1,x2,x3 -> {s = x1.s ++ x2.s ++ x3.s} ;
	lin4args : (x1,x2,x3,x4 : {s : Str}) -> {s : Str} = \x1,x2,x3,x4 -> {s = x1.s ++ x2.s ++ x3.s ++ x4.s} ;
	lin5args : (x1,x2,x3,x4,x5 : {s : Str}) -> {s : Str} = \x1,x2,x3,x4,x5 -> {s = x1.s ++ x2.s ++ x3.s ++ x4.s ++ x5.s} ;
	lin6args : (x1,x2,x3,x4,x5,x6 : {s : Str}) -> {s : Str} = \x1,x2,x3,x4,x5,x6 -> {s = x1.s ++ x2.s ++ x3.s ++ x4.s ++ x5.s ++ x6.s} ;
	lin7args : (x1,x2,x3,x4,x5,x6,x7 : {s : Str}) -> {s : Str} = \x1,x2,x3,x4,x5,x6,x7 -> {s = x1.s ++ x2.s ++ x3.s ++ x4.s ++ x5.s ++ x6.s ++ x7.s} ;

lin
    mkS 		= lin2args ;
    mkS2 		= lin1args ;
    mkS3 		= lin2args ;
    mkS4 		= lin2args ;
    mkVP_external 		= lin1args ;
    mkVP_external2 		= lin2args ;
    mkVP_external3 		= lin1args ;
    mkVP_external4 		= lin2args ;
    mkVP_external5 		= lin2args ;
    mkVP_external6 		= lin3args ;
    mkVP_external7 		= lin3args ;
    mkVP_external8 		= lin3args ;
    mkVP_external9 		= lin3args ;
    mkVP_internal 		= lin2args ;
    mkVP_passive 		= lin2args ;
    mkVP_passive2 		= lin4args ;
    mkVP_passive3 		= lin2args ;
    mkVP_passive4 		= lin4args ;
    mkVP_passive5 		= lin2args ;
    mkVP_passive6 		= lin4args ;
    mkVP_passive7 		= lin3args ;
    mkVP_passive8 		= lin5args ;
    mkVP_passive_dat 		= lin3args ;
    mkVP_passive_dat2 		= lin5args ;
    mkNP_dobj 		= lin1args ;
    mkNP_dobj2 		= lin1args ;
    mkNP_unacc_subj 		= lin1args ;
    mkNP_unacc_subj2 		= lin1args ;
    mkNP_animate_dobj_noPP 		= lin2args ;
    mkNP_animate_dobj_noPP2 		= lin1args ;
    mkNP_animate_dobj 		= lin2args ;
    mkNP_animate_dobj2 		= lin3args ;
    mkNP_animate_dobj3 		= lin1args ;
    mkNP_animate_iobj 		= lin2args ;
    mkNP_animate_iobj2 		= lin1args ;
    mkNP_animate_nsubj 		= lin2args ;
    mkNP_animate_nsubj2 		= lin1args ;
    mkNP_animate_nsubjpass 		= lin2args ;
    mkNP_animate_nsubjpass2 		= lin1args ;
    mkNP_inanimate_dobj 		= lin2args ;
    mkNP_inanimate_dobj2 		= lin3args ;
    mkNP_inanimate_dobj_noPP 		= lin2args ;
    mkNP_inanimate_nsubjpass 		= lin2args ;
    mkNP_on 		= lin3args ;
    mkNP_on2 		= lin2args ;
    mkNP_in 		= lin3args ;
    mkNP_in2 		= lin2args ;
    mkNP_beside 		= lin3args ;
    mkNP_beside2 		= lin2args ;
    the_Det 		= ss "the" ;
    a_Det 		= ss "a" ;
    that_C 		= ss "that" ;
    was_AUX 		= ss "was" ;
    by_BY 		= ss "by" ;
    mkPP_iobj 		= lin2args ;
    mkPP_loc 		= lin2args ;
    mkPP_loc2 		= lin2args ;
    mkPP_loc3 		= lin2args ;
    to_P_iobj 		= ss "to" ;
    on_P_on 		= ss "on" ;
    in_P_in 		= ss "in" ;
    beside_P_beside 		= ss "beside" ;
    to_INF 		= ss "to" ;

}
