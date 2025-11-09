curry:: ((a, b) -> c) -> a -> b -> c
curry f a b = f (a, b)


uncurry :: (a -> b -> c) -> ((a,b) -> c)
uncurry f(x,y) = f x y

minHamming :: Eq a => [[a]] -> Int
minHamming xs = foldr min 10000 [hammin x y | x <- xs, y <- xs] -- does the same list at once (silly)
    where 
        hammin :: Eq a => [a] -> [a] -> Int
        hammin [] [] = 0
        hammin [] [a] = error "dwdwa"
        hammin [a] [] = error "dwdwa"
        hammin (x:xs) (y:ys)
            | x == y = 0 + hammin xs ys
            | otherwise = 1 + hammin xs ys


palindromeBy :: (a -> a -> Bool) -> [a] -> Bool 
palindromeBy f xs = palindrome f xs (reverse xs)
    where
        palindrome :: (a -> a -> Bool) -> [a] -> [a] -> Bool
        palindrome f [] [] = False
        palindrome f (x:xs) (y:ys) = palindrome f xs ys && f x y