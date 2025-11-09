import Data.List (delete)

data Check = Green | Yellow | Grey | MPT deriving (Eq,Show,Read)
type Marking = (Char,Check)
type Markings = [(Char,Check)]

markGuess  :: String -> String -> Markings 
markGuess ans ges = checkifyellow ans ges (checkifgreens ans ges (checkifgrey ges ans))

checkifgrey :: String -> [b0] -> Markings
checkifgrey = zipWith (\a b -> (a,Grey))

checkifgreens :: String -> String -> Markings -> Markings
checkifgreens = zipWith3 (\a g m -> if a == g then (g, Green) else m)

checkifyellow :: String -> String -> Markings -> Markings
checkifyellow as gs ms = 
    let 
        ans = deleteAll as (greens ms)
    in
        checkyellows ans gs ms
    where 
        greens :: Markings -> String
        greens ((x,Green):xs) = x: greens xs
        greens ((x,_):xs) = greens xs
        greens [] = []

checkyellows :: String -> String -> Markings -> Markings
checkyellows _ [] [] = []
checkyellows as (g:gs) (m:ms) =
    let
        (ans,mark) = check as g m
    in
        mark : checkyellows ans gs ms
    where
        check :: String -> Char -> Marking -> (String,Marking)
        check as g m@(v,val)
            | val /= Green && contains g as = (delete g as, (g, Yellow))
            | otherwise = (as,m)


contains ::  Char -> String -> Bool
contains c str = or (map (== c) str)

deleteAll :: String -> String -> String
deleteAll og (g:grn) = deleteAll (delete g og) grn
deleteAll og [] = og

main = do
    print (markGuess "abccd" "cccxx")
