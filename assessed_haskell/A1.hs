convertBiString ::  String -> String 
convertBiString [] = []
convertBiString (x:xs)
    | x == '<' = reverseString (removeFirst xs)
    | x == '>' = forwardString (removeFirst xs)
    | otherwise = x : forwardString xs
    
    
reverseString :: String -> String
reverseString [] = []
reverseString (x:xs)
    | x == '<' = reverseString (removeFirst xs)
    | x == '>' = forwardString (removeFirst xs)
    | x == ':' = removeFirst xs
    | otherwise = reverseString xs ++ [x]

forwardString :: String -> String
forwardString [] = []
forwardString (x:xs)
    | x == '<' = reverseString (removeFirst xs)
    | x == '>' = forwardString (removeFirst xs)
    | x == ':' = removeFirst xs
    | otherwise = x : forwardString xs

removeFirst :: String -> String
removeFirst [] = []
removeFirst (x:xs) = xs