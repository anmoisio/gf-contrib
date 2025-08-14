
concrete ConInput of Abstract = {
    lincat A, B, C, D, E, F, G, H = {s : Str};
    
    oper linArg : {s : Str} -> {s : Str} = \arg -> {s = arg.s} ;

    lin
        BtoA  = linArg ;                        -- straight arity=1
        CtoA  = linArg ;                        -- straight arity=1

        CtoCtoB  c1 c2 = {s = c1.s ++ "fword1" ++ c2.s} ; -- straight arity=2 fword=(idx1,fword1)
        CtoCtoB2 c1 c2 = {s = c1.s ++ "fword2" ++ c2.s} ; -- straight arity=2 fword=(idx1,fword2)
        
        DtoC = linArg ;                         -- straight arity=1
        DtoC2 d = {s = d.s ++ "fword3"} ;       -- straight arity=1 fword=(idx1,fword3)
        DtoC3 d = {s = d.s ++ "fword4"} ;       -- straight arity=1 fword=(idx1,fword4)
        
        HtoD = linArg ;                                 -- straight arity=1
        FtoEtoD  f e = {s = f.s ++ e.s} ;               -- straight arity=2
        FtoEtoD2 f e = {s = f.s ++ "fword5" ++ e.s} ;   -- straight arity=2 fword=(idx1,fword5)
        FtoEtoD3 f e = {s = f.s ++ "fword6" ++ e.s} ;   -- straight arity=2 fword=(idx1,fword6)

        HtoF = linArg ;                         -- straight arity=1
        GtoF = linArg ;                         -- straight arity=1

        e1  = {s = "e1"} ; -- straight arity=0
        e2  = {s = "e2"} ; -- straight arity=0
        g   = {s = "g"} ;  -- straight arity=0
        h1  = {s = "h1"} ; -- straight arity=0
        h2  = {s = "h2"} ; -- straight arity=0
        h3  = {s = "h3"} ; -- straight arity=0
        h4  = {s = "h4"} ; -- straight arity=0
}
