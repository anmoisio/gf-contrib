
abstract ScanNoOpposite10More = Scan - [OppositeVP] ** {
	flags startcat = Utt ;

	cat VPopp ;

	data
		UseVPopp		                : VPopp -> Utt ;
		OppositeVP		                : Verb -> Adv -> VPopp ;

		AdvAdvVerbAdvVerbAdv	        : Verb -> Adv -> VP ;
		AdvVerbAdv		                : Verb -> Adv -> VP ;
		AdvAdvVerbVerbAdvAdv		    : Verb -> Adv -> VP ;
		AdvVerbAdvVerbVerbAdvVerbVerb   : Verb -> Adv -> VP ;
		VerbAdvAdv		                : Verb -> Adv -> VP ;
		VerbAdvVerbVerbVerb		        : Verb -> Adv -> VP ;
		AdvAdvVerbVerb		            : Verb -> Adv -> VP ;
		VerbVerbVerbAdv		            : Verb -> Adv -> VP ;
		AdvVerbAdvVerbAdv		        : Verb -> Adv -> VP ;
		AdvVerbAdvVerbAdvVerbVerb	    : Verb -> Adv -> VP ;

}
