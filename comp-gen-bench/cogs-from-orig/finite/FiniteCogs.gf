
-- the grammar is finite but generates about 2*10^20 trees

abstract FiniteCogs = {
flags startcat = S ;

cat
    Cl ; -- new
    Cl_2nd_order ;
    Cl_3rd_order ;
    AUX ;
    BY ;
    C ;
    Det ;
    INF ;
    NP_animate_dobj ;
    NP_animate_dobj_noPP ;
    NP_animate_iobj ;
    NP_animate_nsubj ;
    NP_animate_nsubjpass ;
    NP_beside ;
    NP_beside_2nd_order ;
    NP_dobj ;
    NP_in ;
    NP_in_2nd_order ;
    NP_inanimate_dobj ;
    NP_inanimate_dobj_noPP ;
    NP_inanimate_nsubjpass ;
    NP_on ;
    NP_on_2nd_order ;
    NP_unacc_subj ;
    N_beside ;
    N_common_animate_dobj ;
    N_common_animate_iobj ;
    N_common_animate_nsubj ;
    N_common_animate_nsubjpass ;
    N_common_inanimate_dobj ;
    N_common_inanimate_nsubjpass ;
    N_in ;
    N_on ;
    N_prop_dobj ;
    N_prop_iobj ;
    N_prop_nsubj ;
    N_prop_nsubjpass ;
    PP_iobj ;
    PP_loc ;
    PP_loc_1st_order ;
    PP_loc_2nd_order ;
    P_beside ;
    P_in ;
    P_iobj ;
    P_on ;
    S ;
    VP_external ;
    VP_external_2nd_order ;
    VP_external_3rd_order ;
    VP_internal ;
    VP_passive ;
    VP_passive_dat ;
    V_cp_taking ;
    V_dat ;
    V_dat_pp ;
    V_inf ;
    V_inf_taking ;
    V_trans_not_omissible ;
    V_trans_not_omissible_pp ;
    V_trans_omissible ;
    V_trans_omissible_pp ;
    V_unacc ;
    V_unacc_pp ;
    V_unerg ;
data
    UseCl                   : Cl            -> S ;
    UseCl_2nd_order         : Cl_2nd_order -> S ;
    UseCl_3rd_order         : Cl_3rd_order -> S ;

    mkS5 		: NP_animate_nsubj -> VP_external_2nd_order -> Cl_2nd_order ;
    mkS6 		: NP_animate_nsubj -> VP_external_3rd_order -> Cl_3rd_order ;
    mkS 		: NP_animate_nsubj -> VP_external           -> Cl ;
    -- mkS2 		: VP_internal -> S ;
    -- mkS3 		: NP_inanimate_nsubjpass -> VP_passive -> S ;
    -- mkS4 		: NP_animate_nsubjpass -> VP_passive_dat -> S ;
    mkS2 		: VP_internal                               -> Cl ;
    mkS3 		: NP_inanimate_nsubjpass -> VP_passive      -> Cl ;
    mkS4 		: NP_animate_nsubjpass -> VP_passive_dat    -> Cl ;

    mkVP_external 		: V_unerg                           -> VP_external ;
    mkVP_external2 		: V_unacc -> NP_dobj                -> VP_external ;
    mkVP_external3 		: V_trans_omissible                 -> VP_external ;
    mkVP_external4 		: V_trans_omissible -> NP_dobj      -> VP_external ;
    mkVP_external5 		: V_trans_not_omissible -> NP_dobj  -> VP_external ;
    mkVP_external6 		: V_inf_taking -> INF -> V_inf      -> VP_external ;

    -- mkVP_external7 		: V_cp_taking -> C -> S -> VP_external ;
    mkVP_external7 		: V_cp_taking -> C -> Cl            -> VP_external_2nd_order ;
    mkVP_external10 	: V_cp_taking -> C -> Cl_2nd_order  -> VP_external_3rd_order ;
    mkVP_external8 		: V_dat -> NP_inanimate_dobj -> PP_iobj         -> VP_external ;
    mkVP_external9 		: V_dat -> NP_animate_iobj -> NP_inanimate_dobj -> VP_external ;

    mkVP_internal 		: NP_unacc_subj -> V_unacc                              -> VP_internal ;

    mkVP_passive 		: AUX -> V_trans_not_omissible_pp                           -> VP_passive ;
    mkVP_passive2 		: AUX -> V_trans_not_omissible_pp -> BY -> NP_animate_nsubj -> VP_passive ;
    mkVP_passive3 		: AUX -> V_trans_omissible_pp                               -> VP_passive ;
    mkVP_passive4 		: AUX -> V_trans_omissible_pp -> BY -> NP_animate_nsubj     -> VP_passive ;
    mkVP_passive5 		: AUX -> V_unacc_pp                                         -> VP_passive ;
    mkVP_passive6 		: AUX -> V_unacc_pp -> BY -> NP_animate_nsubj               -> VP_passive ;
    mkVP_passive7 		: AUX -> V_dat_pp -> PP_iobj                                -> VP_passive ;
    mkVP_passive8 		: AUX -> V_dat_pp -> PP_iobj -> BY -> NP_animate_nsubj      -> VP_passive ;

    mkVP_passive_dat 		: AUX -> V_dat_pp -> NP_inanimate_dobj                          -> VP_passive_dat ;
    mkVP_passive_dat2 		: AUX -> V_dat_pp -> NP_inanimate_dobj -> BY -> NP_animate_nsubj -> VP_passive_dat ;

    mkNP_dobj 		: NP_inanimate_dobj                             -> NP_dobj ;
    mkNP_dobj2 		: NP_animate_dobj                               -> NP_dobj ;
    mkNP_unacc_subj 		: NP_inanimate_dobj_noPP                -> NP_unacc_subj ;
    mkNP_unacc_subj2 		: NP_animate_dobj_noPP                  -> NP_unacc_subj ;
    mkNP_animate_dobj_noPP 		: Det -> N_common_animate_dobj      -> NP_animate_dobj_noPP ;
    mkNP_animate_dobj_noPP2 		: N_prop_dobj                   -> NP_animate_dobj_noPP ;
    mkNP_animate_dobj 		: Det -> N_common_animate_dobj          -> NP_animate_dobj ;
    mkNP_animate_dobj2 		: Det -> N_common_animate_dobj -> PP_loc -> NP_animate_dobj ;
    mkNP_animate_dobj3 		: N_prop_dobj                           -> NP_animate_dobj ;
    mkNP_animate_iobj 		: Det -> N_common_animate_iobj          -> NP_animate_iobj ;
    mkNP_animate_iobj2 		: N_prop_iobj -> NP_animate_iobj ;
    mkNP_animate_nsubj 		: Det -> N_common_animate_nsubj         -> NP_animate_nsubj ;
    mkNP_animate_nsubj2 		: N_prop_nsubj                      -> NP_animate_nsubj ;
    mkNP_animate_nsubjpass 		: Det -> N_common_animate_nsubjpass -> NP_animate_nsubjpass ;
    mkNP_animate_nsubjpass2 		: N_prop_nsubjpass              -> NP_animate_nsubjpass ;
    mkNP_inanimate_dobj 		: Det -> N_common_inanimate_dobj    -> NP_inanimate_dobj ;
    mkNP_inanimate_dobj2 		: Det -> N_common_inanimate_dobj -> PP_loc -> NP_inanimate_dobj ;
    mkNP_inanimate_dobj_noPP 		: Det -> N_common_inanimate_dobj -> NP_inanimate_dobj_noPP ;
    mkNP_inanimate_nsubjpass 		: Det -> N_common_inanimate_nsubjpass -> NP_inanimate_nsubjpass ;

    mkPP_iobj 		: P_iobj -> NP_animate_iobj -> PP_iobj ;

    UsePPloc1st     : PP_loc_1st_order -> PP_loc ;
    UsePPloc2nd     : PP_loc_2nd_order -> PP_loc ;

    -- mkPP_loc 		: P_on -> NP_on -> PP_loc ;
    mkPP_loc 		: P_on -> NP_on -> PP_loc_1st_order ;
    mkPP_loc4 		: P_on -> NP_on_2nd_order -> PP_loc_2nd_order ;
    -- mkPP_loc2 		: P_in -> NP_in -> PP_loc ;
    mkPP_loc2 		: P_in -> NP_in -> PP_loc_1st_order ;
    mkPP_loc5 		: P_in -> NP_in_2nd_order -> PP_loc_2nd_order ;
    -- mkPP_loc3 		: P_beside -> NP_beside -> PP_loc ;
    mkPP_loc3 		: P_beside -> NP_beside -> PP_loc_1st_order ;
    mkPP_loc6 		: P_beside -> NP_beside_2nd_order -> PP_loc_2nd_order ;

    -- mkNP_on 		: Det -> N_on -> PP_loc -> NP_on ;
    mkNP_on 		: Det -> N_on -> PP_loc_1st_order -> NP_on_2nd_order ;
    mkNP_on2 		: Det -> N_on -> NP_on ;
    -- mkNP_in 		: Det -> N_in -> PP_loc -> NP_in ;
    mkNP_in 		: Det -> N_in -> PP_loc_1st_order -> NP_in_2nd_order ;
    mkNP_in2 		: Det -> N_in -> NP_in ;
    -- mkNP_beside 		: Det -> N_beside -> PP_loc -> NP_beside ;
    mkNP_beside 		: Det -> N_beside -> PP_loc_1st_order -> NP_beside_2nd_order ;
    mkNP_beside2 		: Det -> N_beside -> NP_beside ;
    the_Det 		: Det ;
    a_Det 		: Det ;
    that_C 		: C ;
    was_AUX 		: AUX ;
    by_BY 		: BY ;
    to_P_iobj 		: P_iobj ;
    on_P_on 		: P_on ;
    in_P_in 		: P_in ;
    beside_P_beside 		: P_beside ;
    to_INF 		: INF ;

}
