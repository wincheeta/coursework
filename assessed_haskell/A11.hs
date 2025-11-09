data Chunk = Raw String | Rendered String

convertBiString ::  String -> String
convertBiString [] = []
convertBiString x =
    let (out,_) = forward x
    in out
    where
        forward :: String -> (String,String)
        forward x =
            let (chunks, rest) = parse x
            in (renderLR chunks, rest)
        
            -- eat :: String -> [String] -> (String,String)
            -- eat [] acc = (concat (reverse acc), [])
            -- eat (a:b:xs) acc
            --     | [a,b] == ">>" =
            --         let (ren,after) = forward xs
            --             rendered = render
            --         in eat after  (concat (reverse ren:acc), [])
            --     | [a,b] == "<<" =
            --         let (ren,_) = back xs
            --         in (concat (reverse ren:acc), [])
            --     | [a,b] == "::" = (concat (reverse acc), xs)
            --     | otherwise = eat (b:xs) ([a]:acc)
            -- eat (a) acc = (concat (reverse [a]++acc), [])


        back :: String -> (String,String)
        back x =
            let (chunks, rest) = parse x
            in (renderRL chunks, rest)
            -- where
            --     eat :: String -> [String] -> (String,String)
            --     eat [] acc = (concat (reverse acc), [])
            --     eat (a:b:xs) acc
            --         | [a,b] == ">>" =
            --             let (ren,_) = forward xs
            --             in (concat (reverse ren:acc), [])
            --         | [a,b] == "<<" =
            --             let (ren,_) = back xs
            --             in (concat (reverse ren:acc), [])
            --         | [a,b] == "::" = (concat (reverse acc), xs)
            --         | otherwise = eat (b:xs) ([a]:acc)
            --     eat (a) acc = (concat (reverse [a]++acc), [])

        getStr :: String -> String
        getStr (s) = s
        getStr (s) = s

        renderLR :: [String] -> String
        renderLR = concatMap getStr

        -- Renders a list of chunks in RL order.
        renderRL :: [String] -> String
        renderRL chunks = concatMap renderChunk (reverse chunks)
            where
                -- Raw text is reversed; rendered sub-isolates are not.
                renderChunk ( str)      = reverse str
                renderChunk ( str) = str
            
        parse :: String -> ([String], String)
        parse input = go input []
            where
                go :: String -> [String] -> ([String], String)
                go [] acc = (reverse acc, [])
                go (a:b:rest) acc 
                    | [a,b] = ">>" =
                        let (sub, afterSub) = forward rest
                        in go afterSub ( sub : acc)
                    | [a,b] = "<<" =
                        let (sub, afterSub) = back rest
                        in go afterSub ( sub : acc)
                    | [a,b] = "::" = acc = (reverse acc, rest)
                go str acc =
                    let (text, rest) = spanToMarker str
                    in go rest ( text : acc)

        spanToMarker :: String -> (String, String)
        spanToMarker str = go str []
            where
                go :: String -> String -> (String, String)
                go [] acc = (reverse acc, [])
                go rest@('>' : '>' : _) acc = (reverse acc, rest)
                go rest@('<' : '<' : _) acc = (reverse acc, rest)
                go rest@(':' : ':' : _) acc = (reverse acc, rest)
                go (c:cs) acc = go cs (c:acc)

main = do
    print ("abconmlkj321fed" == (convertBiString "abc<<def>>123::jklmno"))
    print (convertBiString "abc<<def>>123::jklmno")