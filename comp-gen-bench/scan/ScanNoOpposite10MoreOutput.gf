concrete ScanNoOpposite10MoreOutput of ScanNoOpposite10More = ScanOutput ** 
{
	lincat VPopp = {s : Str};
	lin
		UseVPopp vpopp = vpopp ;
		AdvAdvVerbAdvVerbAdv    verb adv = {s = adv.s ++ adv.s ++ verb.s ++ adv.s ++ verb.s ++ adv.s} ;
		AdvVerbAdv              verb adv = {s = adv.s ++ verb.s ++ adv.s} ;
		AdvAdvVerbVerbAdvAdv    verb adv = {s = adv.s ++ adv.s ++ verb.s ++ verb.s ++ adv.s ++ adv.s} ;
		AdvVerbAdvVerbVerbAdvVerbVerb verb adv = {s = adv.s ++ verb.s ++ adv.s ++ verb.s ++ verb.s ++ adv.s ++ verb.s ++ verb.s} ;
		VerbAdvAdv              verb adv = {s = verb.s ++ adv.s ++ adv.s} ;
		VerbAdvVerbVerbVerb     verb adv = {s = verb.s ++ adv.s ++ verb.s ++ verb.s ++ verb.s} ;
		AdvAdvVerbVerb          verb adv = {s = adv.s ++ adv.s ++ verb.s ++ verb.s} ;
		VerbVerbVerbAdv         verb adv = {s = verb.s ++ verb.s ++ verb.s ++ adv.s} ;
		AdvVerbAdvVerbAdv       verb adv = {s = adv.s ++ verb.s ++ adv.s ++ verb.s ++ adv.s} ;
		AdvVerbAdvVerbAdvVerbVerb verb adv = {s = adv.s ++ verb.s ++ adv.s ++ verb.s ++ adv.s ++ verb.s ++ verb.s} ;
}
