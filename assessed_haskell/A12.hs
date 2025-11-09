data Chunk = Raw String | Rendered String

convertBiString :: String -> String
convertBiString "" = ""
convertBiString s =
    let (out, _) = forward s
    in out
  where
    forward:: String -> (String, String)
    forward x =
      let (chunks, rest) = parse x
      in (renderLR chunks, rest)

    back :: String -> (String, String)
    back x =
      let (chunks, rest) = parse x
      in (renderRL chunks, rest)
    
    parse :: String -> ([Chunk], String)
    parse input = eat input []

    eat :: String -> [Chunk] -> ([Chunk], String)
    eat [] acc = (reverse acc, [])
    eat ('>':'>':rest) acc =
            let (sub, afterSub) = forward rest
            in eat afterSub (Rendered sub : acc)
    eat ('<':'<':rest) acc =
            let (sub, afterSub) = back rest
            in eat afterSub (Rendered sub : acc)
    eat(':':':':rest) acc = (reverse acc, rest)
    eat a acc =
        let (text, rest) = spanToMarker a
        in eat rest (Raw text : acc)


    getStr :: Chunk -> String
    getStr (Raw s) = s
    getStr (Rendered s) = s
    
    renderLR :: [Chunk] -> String
    renderLR = concatMap getStr

    renderRL :: [Chunk] -> String
    renderRL chunks = concatMap renderChunk (reverse chunks)
      where
        renderChunk (Raw str)      = reverse str
        renderChunk (Rendered str) = str

    spanToMarker :: String -> (String, String)
    spanToMarker str = eat str []
      where
        eat :: String -> String -> (String, String)
        eat [] acc = (reverse acc, [])
        eat rest@('>' : '>' : _) acc = (reverse acc, rest)
        eat rest@('<' : '<' : _) acc = (reverse acc, rest)
        eat rest@(':' : ':' : _) acc = (reverse acc, rest)
        eat (c:cs) acc = eat cs (c:acc)

main = do 
    print ( convertBiString [] == "")
    print (convertBiString "abcdefghi" =="abcdefghi")
    print (convertBiString "abc>>def::ghi" == "abcdefghi")
    print (convertBiString "abc>>defghi" == "abcdefghi")
    print (convertBiString "abc<<def::ghi" == "abcfedghi")
    print (convertBiString "abc<<defghi" == "abcihgfed")
    print (convertBiString "abc<<def>>123::jkl::mno" == "abclkj123fedmno")
    print (convertBiString "abc<<def>>123::jklmno" == "abconmlkj123fed")