-- 0
n = a `div` length xs
    where
    a = 10;
    xs = [1,2,3,4,5]

-- 1 
data Fruit = Apple | Banana | Orange | Unknown -- fruit is tybe the rest are constructors, they have arity 0 (expect no arguments)

--2
data Day = Mon | Tue | Wed | Thu | Fri | Sat | Sun
data DailySpecials = Offer Day (Maybe Fruit)

-- take the form ::t day Just fruit or none
-- eg Mon Just Apple, Tues None etc...Applicative

--3

-- values, Banana, Offer Tue (Just Orange), 7.2, Circle 7.2
-- experssions, not (not False), 4 + 5, area (Circle 6), Square (7 + 2), Square (area (Circle 2))


--4

data ABinTreeInt = Leaf Int | Node Int BinTreeInt BinTreeInt
-- Leaf 3
-- Leaf -3
-- Leaf (-3)
-- Leaf 3.14
-- Node 3.14 (Leaf 1) (Leaf 2)
-- Node 0 (Node 1 (Leaf 2) (Leaf 3)) (Leaf 4)
-- Node 0 (BinTreeInt 1) (BinTreeInt 2)
-- Node 0 (Node 1 (Leaf 2)) (Leaf 4)
-- Node (Node 1 (Leaf 2) (Leaf 3)) (Leaf 4)
-- BinTreeInt Int (Leaf 0) (Leaf 1)    bintreeint is a type not a constructor

-- 5
data BinTree a = Leafa a | Nodea a (BinTree a) (BinTree a)

type BinTreeInt = BinTree Int -- sanity check

numberOfLeaves :: BinTree a -> Int
numberOfLeaves (Leafa _) = 1
numberOfLeaves (Nodea _ left right) = numberOfLeaves left + numberOfLeaves right

-- numberOfLeaves (Nodea 1 (Leafa 1) (Leafa 1)

-- 6

mAnd :: Maybe Bool -> Maybe Bool -> Maybe Bool
mAnd (Just a) (Just b) = Just (a && b)
mAnd _ _ = Nothing
mOr :: Maybe Bool -> Maybe Bool -> Maybe Bool
mOr (Just x) (Just y) = Just (x || y)
mOr _ _ = Nothing
mNot :: Maybe Bool -> Maybe Bool
mNot (Just x) = Just (not x)
mNot _ = Nothing
mImply :: Maybe Bool -> Maybe Bool -> Maybe Bool
mImply (Just True) (Just False) = Just False
mXor :: Maybe Bool -> Maybe Bool -> Maybe Bool
mXor (Just a) (Just b) = Just ((a||b)&& not (a&&b))


-- 7
data List a = Empty | Cons a (List a)

listLength :: List a -> Int
listLength (Cons a b)  = 1 + listLength b
listLength Empty = 0

-- 8 tersdhrtfjygkuhli
data Nat = Zero | Succ Nat | Prev Nat

add :: Nat -> Nat -> Nat
add Zero Zero = Zero
add (Succ n) Zero = Succ n
add Zero (Succ m) = Succ m
add (Succ n) (Succ m) = Succ (Succ (add n m))
add (Succ n) (Prev m) = n


-- 9

double :: Num a => a -> a
double x = x + x



main = do
    putStrLn (show 1)


