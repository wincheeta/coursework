import Data.List

data Check = Green | Yellow | Grey deriving (Eq,Show,Read)
type Marking = [(Char,Check)]
type State = (String,String,String,[String]) -- yellow, grey, green, exclude

possibleWords :: State -> [String] -> [String]
possibleWords (y,gr,g,ex) dict = filtGrey gr (filtYellow y (filtYelloNot ex (filtGreen g dict)))

filtGreen :: String -> [String] -> [String]
filtGreen s dict = filter (filtgreen' s) dict
    where
        filtgreen' :: String -> String -> Bool
        filtgreen' (x:xs) (y:ys)
            | x == '-' = filtgreen' xs ys
            | x /= y = False
            | otherwise = filtgreen' xs ys
        filtgreen' _ _ = True

filtYellow :: String -> [String] -> [String]
filtYellow y dict = filter (filtyellow' y) dict
filtyellow' :: String -> String -> Bool
filtyellow' (x:xs) wrd
    | (contains x wrd) == False = False
    | (contains x wrd) == True = filtyellow' xs (removeletter x wrd [])
    | otherwise = filtyellow' xs wrd
filtyellow' _ _ = True

contains :: Char -> String -> Bool
contains c xs = foldr ((||) . (c ==)) False xs

filtYelloNot :: [String] -> [String] -> [String]
filtYelloNot ex dict = filter (yellowNot ex) dict
    where
        yellowNot :: [String] -> String -> Bool
        yellowNot (x:xs) (y:ys)
            | (checkPos x y) == False = False
            | otherwise = yellowNot xs ys
        yellowNot _ _ = True

        checkPos :: String -> Char -> Bool
        checkPos (x) (y)
            | contains y x = False
            | otherwise = True


filtGrey :: String -> [String] -> [String]
filtGrey gr dict = filter (filtGrey' gr) dict
    where
        filtGrey' :: String -> String -> Bool
        filtGrey' (x:xs) wrd
            | (contains x wrd) == True = False
            | otherwise = filtGrey' xs wrd
        filtGrey' _ _ = True

removeletter :: Char -> String -> String -> String
removeletter c (x:xs) acc
    | c == x = reverse acc ++ xs
    | otherwise = removeletter c xs (x:acc)
removeletter c [] acc = reverse acc
main = do
    print (removeletter 'l' "he" [])
    print (filtyellow' "l" "he")
    print (possibleWords ("h","","h----",["","","","",""])  ["hello"])
    print (possibleWords ("lol","","-----",["l","l","o","",""]) ["hello"])
    print (possibleWords ("eel","oibkgf","---e-",["el","","l","l",""]) ["easel","elder","excel","expel","jewel","leper","level","lever","melee","repel","revel","sleep","sleet","steel","wheel"])
