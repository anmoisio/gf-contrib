abstract SimplerCogs = {
cat

    S ;

    VP_external ;
    VP_internal ;
    VP_passive ;
    VP_passive_dat ;

    NP ;

    PP_iobj ;
    PP_loc ;

    N ;
    PN ;

    P_beside ;
    P_in ;
    P_iobj ;
    P_on ;

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

    AUX ;
    BY ;
    C ;
    Det ;
    INF ;

fun

    mkS 		                : NP -> VP_external     -> S ;
    mkS2 		                : VP_internal           -> S ;
    mkS3 		                : NP -> VP_passive      -> S ;
    mkS4 		                : NP -> VP_passive_dat  -> S ;

    mkVP_external 		: V_unerg                       -> VP_external ; -- slept
    mkVP_external2 		: V_unacc -> NP                 -> VP_external ; -- burned a cake
    mkVP_external3 		: V_trans_omissible             -> VP_external ; -- ate
    mkVP_external4 	    : V_trans_omissible -> NP       -> VP_external ; -- ate a cake
    mkVP_external5 		: V_trans_not_omissible -> NP   -> VP_external ; -- liked a cake
    mkVP_external6 		: V_inf_taking -> INF -> V_inf  -> VP_external ; -- planned to eat
    mkVP_external7 		: V_cp_taking -> C -> S         -> VP_external ; -- liked that a dog ate
    mkVP_external8 		: V_dat -> NP -> PP_iobj        -> VP_external ; -- gave a bone to the dog
    mkVP_external9 		: V_dat -> NP -> NP             -> VP_external ; -- gave the dog a bone

    mkVP_internal 		: NP -> V_unacc -> VP_internal ;                 -- a cake burned

    mkVP_passive        : AUX -> V_trans_not_omissible_pp               -> VP_passive ; -- was liked
    mkVP_passive2 		: AUX -> V_trans_not_omissible_pp -> BY -> NP   -> VP_passive ; -- was liked by a boy
    mkVP_passive3 		: AUX -> V_trans_omissible_pp                   -> VP_passive ; -- was eaten
    mkVP_passive4 		: AUX -> V_trans_omissible_pp -> BY -> NP       -> VP_passive ; -- was eaten by a boy
    mkVP_passive5 		: AUX -> V_unacc_pp                             -> VP_passive ; -- was burned
    mkVP_passive6 		: AUX -> V_unacc_pp -> BY -> NP                 -> VP_passive ; -- was burned by a boy

    mkVP_passive7 		: AUX -> V_dat_pp -> PP_iobj                    -> VP_passive ; -- was given to a dog
    mkVP_passive8 		: AUX -> V_dat_pp -> PP_iobj -> BY -> NP        -> VP_passive ; -- was given to a dog by a boy

    mkVP_passive_dat 	: AUX -> V_dat_pp -> NP                         -> VP_passive_dat ; -- was given a bone
    mkVP_passive_dat2 	: AUX -> V_dat_pp -> NP -> BY -> NP             -> VP_passive_dat ; -- was given a bone by a boy

    mkNP 		        : Det -> N ->           NP ; -- a bone
    mkNP2 		        : Det -> N -> PP_loc -> NP ; -- a bone in a bag
    mkNP_pn 	        : PN ->                 NP ; -- Abigail

    mkPP_iobj 		: P_iobj -> NP -> PP_iobj ;
    mkPP_loc 		: P_on -> NP -> PP_loc ;
    mkPP_loc2 		: P_in -> NP -> PP_loc ;
    mkPP_loc3 		: P_beside -> NP -> PP_loc ;

    to_P_iobj 		: P_iobj ;
    on_P_on 		: P_on ;
    in_P_in 		: P_in ;
    beside_P_beside : P_beside ;
    the_Det         : Det ;
    a_Det 		    : Det ;
    that_C 		    : C ;
    was_AUX 	    : AUX ;
    by_BY 		    : BY ;
    to_INF 		    : INF ;
}
