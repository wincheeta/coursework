
import Distribution.Simple.PackageIndex (SearchResult(None))
import Data.List (unzip4, delete, transpose, nub)
data Check = Green | Yellow | Grey deriving (Eq,Show,Read)
type Marking = (Char,Check)
type Markings = [(Char,Check)]
type State = (String,String,String,[String])

collateMarking :: [Markings] -> State
collateMarking ms = compbineresults (map getresults ms)

compbineresults :: [State] -> State
compbineresults m =
    let
        (yell,grey,green,yelpos) = unzip4 m
    in
        (combineyell yell [], combinegrey grey, combinegreen green, combineyelpos (transpose yelpos))

-- [("xz","y","--z",["x","",""])] - [["xz xs"], []]

combineyell :: [String] -> String -> String
combineyell (a:xs) acc= combineyell xs (combine a acc)
combineyell [] acc = acc

combine :: String -> String -> String
combine a b = (deleteAll a b) ++ (deleteAll b a) ++ commonChars a b

commonChars :: String -> String -> String
commonChars (a:as) b
    | contains b a = a : commonChars as (delete a b) 
    | otherwise = commonChars as b
commonChars [] b = []

deleteAll :: String -> String -> String --origional, characters to be deleted
deleteAll og grn = foldl (flip delete) og grn

combinegrey :: [String] -> String
combinegrey (xs) = removeDuplicates (concat xs)

combinegreen  :: [String] -> String
combinegreen = map getval . transpose
    where
        getval :: String -> Char
        getval ('-':xs) = getval xs
        getval (c:xs) = c
        getval [] = '-'


combineyelpos :: [[String]] -> [String]
combineyelpos = map concat

contains ::  String -> Char -> Bool
contains str c = or (map (== c) str)

removeDuplicates :: String -> String
removeDuplicates [] = []
removeDuplicates (x:xs) = x : removeDuplicates (filter (\c -> c /= x) xs)


getresults :: Markings -> State
getresults m = (getyellow m, getgrey m, getgreen m, yellowpos m)

getgreen :: Markings -> String
getgreen = map process
    where
        process :: Marking -> Char
        process (c,Green) = c
        process _ = '-'

getyellow :: Markings -> String
getyellow ((c,Yellow):xs) = c : getyellow xs
getyellow ((c,Green):xs) = c : getyellow xs
getyellow [] = []
getyellow (_:xs) = getyellow xs

yellowpos :: Markings -> [String]
yellowpos ((c,Yellow):xs) = [[c]] ++ yellowpos (addyellow c xs)
yellowpos ((c,_):xs) = [""] ++ yellowpos xs
yellowpos [] = []

addyellow :: Char -> Markings -> Markings
addyellow i = map (\(c,val) -> if i==c && val /= Green then (c,Yellow) else (c,val))

getgrey :: Markings -> String
getgrey ((c,Yellow):xs) = getgrey (addyellow c xs)
getgrey ((c,Grey):xs) = c : getgrey xs
getgrey ((c,_):xs) = getgrey xs
getgrey [] = []

main = do
    print (commonChars "hello" "helllo")
    print (collateMarking [[('h',Grey),('i',Grey),('j',Grey),('a',Grey),('c',Grey),('k',Grey),('e',Grey),('r',Yellow),('s',Grey)],
        [('c',Grey),('o',Green),('n',Grey),('j',Grey),('u',Grey),('n',Grey),('c',Grey),('t',Grey),('s',Grey)],
        [('o',Yellow),('x',Grey),('y',Grey),('m',Grey),('o',Yellow),('r',Green),('o',Green),('n',Grey),('s',Grey)],
        [('a',Grey),('f',Yellow),('f',Yellow),('o',Yellow),('r',Yellow),('d',Grey),('i',Grey),('n',Grey),('g',Grey)],
        [('p',Yellow),('e',Grey),('r',Yellow),('e',Grey),('n',Grey),('n',Grey),('i',Grey),('a',Grey),('l',Yellow)],
        [('c',Grey),('h',Grey),('r',Yellow),('i',Grey),('s',Grey),('t',Grey),('m',Grey),('a',Grey),('s',Grey)]])