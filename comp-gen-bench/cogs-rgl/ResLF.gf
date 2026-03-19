
resource ResLF = {

    param
        IsEmpty = Empty | NonEmpty ;

    oper
        mkListLin : Str -> (f,fs : {s : Str ; isEmpty : IsEmpty}) -> {s : Str ; isEmpty : IsEmpty} =
            \separ,f,fs ->
            -- let
            --     sep : Str = case <f.isEmpty,fs.isEmpty> of {
            --                     <_,Empty> => "" ;
            --                     <Empty,_> => "" ;
            --                     <_,_> => separ } ;
            --     emptiness : IsEmpty = case <f.isEmpty,fs.isEmpty> of {
            --                     <Empty,Empty> => Empty ;
            --                     <_,_> => NonEmpty } ;
            -- in  {s = f.s ++ sep ++ fs.s ; isEmpty = emptiness}
            {s = f.s ++ separ ++ fs.s ; isEmpty = NonEmpty}
            ;
}
