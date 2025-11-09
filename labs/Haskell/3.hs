map' :: (a -> b) -> [a] -> [b]
map' f = foldr ((:) . f ) []

-- filter' :: (a -> Bool) -> [a] -> [a]
-- filter' f = foldr (checker f) []

-- checker :: (a -> Bool) -> a -> a
-- checker f x 
--     | f x == True = (a:)
--     | otherwise = id

-- all' :: (a -> Bool) -> [a] -> Bool
-- all' f xs = foldr (&&) True (map f xs)

-- any' :: (a -> Bool) -> [a] -> Bool
-- any' f xs = foldr (||) False (map f xs)

-- group' :: Eq a => [a] -> [[a]]
-- group' = foldr grouper []
--   where 
--     grouper :: a -> [[a]] -> [[a]]
--     grouper x acc 
--       | null acc = [[x]]
--       | x == head (head acc) = (x : head acc) : tail acc
--       | otherwise = [x] : acc

dec2Int :: [Int] -> Int
dec2Int = foldl (\x xs -> x*10 + xs) 0

wellBracketed :: String -> Bool
wellBracketed x = check x == 0
    where
        check :: String -> Int
        check = foldl count 0
            where
                count :: Int -> Char -> Int
                count c '(' = c+1
                count 0 ')' = -999999
                count c ')' = c-1
                count c _ = c

data Tree a = Leaf a | Node (Tree a) a (Tree a) deriving (Eq,Show)

foldTree :: (a -> b) -> (b -> a -> b -> b) -> Tree a -> b
foldTree 

main = do
    print (wellBracketed "((())))(")