[] ++ ys = ys -- 1
(x:xs) ++ ys = x : (xs ++ ys) -- 2

--  prove
xs ++ [] = xs -- base
--base
[] ++ [] = [] -- definition
xs = x:xs'
x:xs' ++ [] = x : (xs' ++ []) -- by definition
= x:xs' = xs -- by inductive hpyothesis

xs ++ (ys ++ zs) = (xs ++ ys) ++ zs
-- base
[] ++ (ys ++ zs) = (ys ++ zs) = (([] ++ ys) ++ zs)

xs ++ (ys ++ zs) = x : (xs' ++ (ys ++ zs)) -- definition 2
x : ((xs' ++ ys) ++ zs) -- hypothesis
x:(xs ++ ys) ++ zs -- reverse definition 2
(xs ++ ys) ++ zs -- reverse deifinition 2






data Nat = Zero | Succ Nat
replicate :: Nat -> a -> [a]
replicate Zero _ = []
replicate (Succ n) x = x : replicate n x

all :: (a -> Bool) -> [a] -> Bool
all p [] = True
all p (x:xs) = p x && all p xs

-- prove 
all (== x) (replicate n x) = True for any x and any n. 

-- base
all (== x) (replicate Zero x) = true -- line 26 -> 30

-- indcution
all (== x) (replicate n x)
all (== x) (x : replicate n-1 x) -- definintion
(== x) x && all (== x) (replicate n-1 x) -- definition
True && True -- inductive hybothesis
-- Assumption: We assumed that x == x always evaluates to True.






take Zero _  = []
take _ [] = []							  
take (Succ n) (x:xs) = x : take n xs

drop Zero xs = xs
drop _ [] = []
drop (Succ n) (_:xs) = drop n xs

-- prove  
for any list we have 
take n xs ++ drop n xs = xs 

-- base
take 0 ns ++ drop 0 ns = [] ++ ns = ns
take n [] += drop n [] = [] ++ [] = []

--induction
take n xs ++ drop n xs 
x : take n xs' ++ drop n xs' -- definition
x : xs' -- inductive hypothsis
xs -- proof





foldl f v xs = foldr (swap f) v (reverse xs)

foldl f acc [] = acc
foldl f acc (x:xs) = foldl f (f acc x) xs

foldr f v []     = v
foldr f v (x:xs) = f x (foldr f v xs)

reverse [] = []
reverse (x:xs) = reverse xs ++ [x]

swap f x y = f y x

-- prove 
foldr f v (xs ++ [y]) = foldr f (f y v) xs