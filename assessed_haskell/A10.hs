module BiString (convertBiString) where
data Chunk = Raw String | Rendered String

convertBiString :: String -> String
convertBiString "" = ""
convertBiString s =
    -- The top-level context is always left-to-right (forward).
    -- The second element of the tuple (the remaining unparsed string) is ignored.
    let (out, _) = forward s
    in out
  where
    -- Forward-declare forward and back so they can be mutually recursive.
    forward, back :: String -> (String, String)

    -- Data type to distinguish raw text (which gets reversed in RL)
    -- from rendered sub-isolates (which are treated as atomic blocks).

    -- Processes a Left-to-Right (LR) isolate.
    -- Returns the final rendered string and the remainder of the input.
    forward x =
      let (chunks, rest) = parse x
      in (renderLR chunks, rest)

    -- Processes a Right-to-Left (RL) isolate.
    -- Returns the final rendered string and the remainder of the input.
    back x =
      let (chunks, rest) = parse x
      in (renderRL chunks, rest)

    -- Helper to extract the string content from any chunk.
    getStr :: Chunk -> String
    getStr (Raw s) = s
    getStr (Rendered s) = s
    
    -- Renders a list of chunks in LR order.
    renderLR :: [Chunk] -> String
    renderLR = concatMap getStr

    -- Renders a list of chunks in RL order.
    renderRL :: [Chunk] -> String
    renderRL chunks = concatMap renderChunk (reverse chunks)
      where
        -- Raw text is reversed; rendered sub-isolates are not.
        renderChunk (Raw str)      = reverse str
        renderChunk (Rendered str) = str

    -- The main parsing logic, shared by 'forward' and 'back'.
    -- This corresponds to the 'eat' function in the provided format.
    -- It returns a list of Chunks to allow for different rendering strategies.
    parse :: String -> ([Chunk], String)
    parse input = go input []
      where
        go :: String -> [Chunk] -> ([Chunk], String)
        -- Base case: End of string.
        go [] acc = (reverse acc, [])
        -- An LR isolate begins. Recursively call 'forward'.
        go ('>':'>':rest) acc =
            let (sub, afterSub) = forward rest
            in go afterSub (Rendered sub : acc)
        -- An RL isolate begins. Recursively call 'back'.
        go ('<':'<':rest) acc =
            let (sub, afterSub) = back rest
            in go afterSub (Rendered sub : acc)
        -- The current isolate ends.
        go (':':':':rest) acc = (reverse acc, rest)
        -- A raw text segment. Consume until the next marker.
        go str acc =
            let (text, rest) = spanToMarker str
            in go rest (Raw text : acc)

    -- Consumes characters from a string until a marker ('>>', '<<', '::')
    -- or the end of the string is found.
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
    print (convertBiString "abc<<def>>123::jklmno")