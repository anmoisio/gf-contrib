abstract ScanNoOpposite20More = Scan - [OppositeVP] ** {
	flags startcat = Utt ;

	cat VPopp ;

	data
		UseVPopp		: VPopp -> Utt ;
		OppositeVP		: Verb -> Adv -> VPopp ;
		VerbAdvAdvAdvAdv		: Verb -> Adv -> VP ;
		VerbVerbVerbVerbVerbAdv		: Verb -> Adv -> VP ;
		AdvVerbAdvAdv		: Verb -> Adv -> VP ;
		VerbAdvVerb		: Verb -> Adv -> VP ;
		VerbVerbAdvVerbVerbAdvAdvVerb		: Verb -> Adv -> VP ;
		VerbVerbAdvAdv		: Verb -> Adv -> VP ;
		VerbAdvVerbVerbVerbVerbVerbVerb		: Verb -> Adv -> VP ;
		AdvVerbAdv		: Verb -> Adv -> VP ;
		VerbVerbVerbVerbAdvAdvVerbVerb		: Verb -> Adv -> VP ;
		AdvAdvVerbVerb		: Verb -> Adv -> VP ;
		VerbVerbAdvAdvVerbAdv		: Verb -> Adv -> VP ;
		VerbAdvVerbVerbAdv		: Verb -> Adv -> VP ;
		VerbAdvAdvVerbAdvAdv		: Verb -> Adv -> VP ;
		AdvAdvAdvVerb		: Verb -> Adv -> VP ;
		AdvAdvVerbVerbAdvAdvVerb		: Verb -> Adv -> VP ;
		VerbVerbAdv		: Verb -> Adv -> VP ;
		VerbAdvAdvVerbVerbAdvAdv		: Verb -> Adv -> VP ;
		VerbVerbVerbVerbVerbAdvVerb		: Verb -> Adv -> VP ;
		VerbVerbAdvAdvVerb		: Verb -> Adv -> VP ;
		AdvVerbVerb		: Verb -> Adv -> VP ;

}
