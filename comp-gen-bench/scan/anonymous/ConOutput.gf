
concrete ConOutput of Abstract = {
    lincat A, B, C, D, E, F, G, H = {s : Str};

    oper linArg : {s : Str} -> {s : Str} = \arg -> {s = arg.s} ;

    lin
        BtoA  = linArg ;                        -- straight arity=1
        CtoA  = linArg ;                        -- straight arity=1

        CtoCtoB  c1 c2 = {s = c1.s ++ c2.s} ;   -- straight arity=2
        CtoCtoB2 c1 c2 = {s = c2.s ++ c1.s} ;   -- inverse arity=2

        DtoC = linArg ;                         -- straight arity=1
        DtoC2 d = {s = d.s ++ d.s} ;            -- repeat=2 arity=1
        DtoC3 d = {s = d.s ++ d.s ++ d.s} ;     -- repeat=3 arity=1

        HtoD = linArg ;                             -- straight arity=1
        FtoEtoD  f e = {s =  e.s ++ f.s} ;          -- inverse arity=2
        FtoEtoD2 f e = {s =  e.s ++ e.s ++ f.s} ;   -- repeat=(2,1) arity=2 inverse
        FtoEtoD3 f e = {s =  e.s ++ f.s ++ 
                             e.s ++ f.s ++ 
                             e.s ++ f.s ++ 
                             e.s ++ f.s} ;          -- alternate=4 arity=2 inverse

        HtoF = linArg ;                         -- straight arity=1
        GtoF _ = {s = []} ;                     -- suppress arity=1

        e1  = {s = "e1"} ; -- straight arity=0
        e2  = {s = "e2"} ; -- straight arity=0
        g   = {s = ""} ;   -- suppress arity=0
        h1  = {s = "h1"} ; -- straight arity=0
        h2  = {s = "h2"} ; -- straight arity=0
        h3  = {s = "h3"} ; -- straight arity=0
        h4  = {s = "h4"} ; -- straight arity=0
}
