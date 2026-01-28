abstract ScanNoOpposite40More = Scan - [OppositeVP] ** {
	flags startcat = Utt ;

	cat VPopp ;

	data
		UseVPopp		: VPopp -> Utt ;
		OppositeVP		: Verb -> Adv -> VPopp ;
		AdvVerbVerbAdvAdv		: Verb -> Adv -> VP ;
		AdvAdvAdvVerbAdv		: Verb -> Adv -> VP ;
		AdvAdvVerbVerbAdv		: Verb -> Adv -> VP ;
		AdvAdvAdvVerbVerb		: Verb -> Adv -> VP ;
		VerbAdvAdvVerbVerbVerb		: Verb -> Adv -> VP ;
		VerbVerbAdvVerbVerbAdvVerbAdv		: Verb -> Adv -> VP ;
		VerbAdvAdvVerbAdv		: Verb -> Adv -> VP ;
		VerbAdvAdvAdvVerb		: Verb -> Adv -> VP ;
		VerbVerbAdvAdvAdvVerbAdvVerb		: Verb -> Adv -> VP ;
		VerbVerbAdvVerbAdvVerb		: Verb -> Adv -> VP ;
		VerbVerbAdvVerbVerbVerbVerb		: Verb -> Adv -> VP ;
		VerbVerbVerbAdvVerbAdvVerb		: Verb -> Adv -> VP ;
		VerbVerbAdvAdv		: Verb -> Adv -> VP ;
		AdvVerbAdvAdvVerbAdvVerbAdv		: Verb -> Adv -> VP ;
		VerbVerbVerbAdvVerbVerbAdvAdv		: Verb -> Adv -> VP ;
		VerbAdvAdvVerbVerbAdv		: Verb -> Adv -> VP ;
		VerbAdvVerbVerbVerbAdvVerb		: Verb -> Adv -> VP ;
		VerbVerbVerbAdv		: Verb -> Adv -> VP ;
		AdvVerbAdv		: Verb -> Adv -> VP ;
		VerbVerbAdv		: Verb -> Adv -> VP ;
		VerbAdvVerbVerbAdvVerbVerbVerb		: Verb -> Adv -> VP ;
		VerbAdvVerbVerb		: Verb -> Adv -> VP ;
		AdvVerbAdvAdvVerbAdv		: Verb -> Adv -> VP ;
		AdvVerbVerbVerb		: Verb -> Adv -> VP ;
		AdvVerbAdvAdv		: Verb -> Adv -> VP ;
		VerbAdvVerb		: Verb -> Adv -> VP ;
		AdvVerbVerb		: Verb -> Adv -> VP ;
		VerbVerbAdvVerbVerbAdvAdv		: Verb -> Adv -> VP ;
		VerbAdvAdvAdvAdvVerbAdv		: Verb -> Adv -> VP ;
		VerbAdvAdv		: Verb -> Adv -> VP ;
		AdvVerbVerbAdvVerb		: Verb -> Adv -> VP ;
		VerbAdvAdvAdv		: Verb -> Adv -> VP ;
		VerbVerbVerbAdvVerbVerbAdvVerb		: Verb -> Adv -> VP ;
		VerbVerbVerbAdvAdvAdvVerb		: Verb -> Adv -> VP ;
		AdvVerbVerbAdvVerbAdv		: Verb -> Adv -> VP ;
		VerbVerbAdvAdvVerbVerb		: Verb -> Adv -> VP ;
		AdvAdvAdvAdvVerbVerbAdvVerb		: Verb -> Adv -> VP ;
		AdvVerbAdvAdvAdvVerbVerb		: Verb -> Adv -> VP ;
		AdvVerbVerbAdv		: Verb -> Adv -> VP ;
		VerbVerbVerbAdvAdvVerb		: Verb -> Adv -> VP ;

}
