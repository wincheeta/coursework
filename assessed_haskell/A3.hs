import Data.Map (Map, empty, insertWith, toList, lookup,findWithDefault)
import Data.Bits ( Bits((.&.), (.|.)) )
import Data.List (transpose)

type Point = (Int,Int)
type Line = (Point,Point)
type AsciiPoint = (String,String,String)

n, e, s, w :: Int
exists = 16
n = 1  -- North (0001)
e = 2  -- East (0010)
s = 4  -- South (0100)
w = 8  -- West (1000)

parseMaze :: [String] -> [Line]
parseMaze x = getLines (convertIntonums x)
    where
        getLines :: [[Int]] -> [Line]
        getLines (xs) = (getLinesInRows xs 0) ++ getLinesInCols (transpose xs) 0

        getLinesInRows :: [[Int]] -> Int -> [Line]
        getLinesInRows (x:xs) y = linesInRow x (0,y) [] ++ getLinesInRows xs (y+1)
        getLinesInRows [] y = []

        getLinesInCols :: [[Int]] -> Int -> [Line]
        getLinesInCols (x:xs) y = linesInCol x (y,0) [] ++ getLinesInCols xs (y+1)
        getLinesInCols [] y = []



linesInRow :: [Int] -> (Int,Int) -> [Line] -> [Line]
linesInRow (x:xs) pos acc
    | x .&. e == e =
        let
            (ans,rest,poss) = findHorizontal xs (pos,(incrPos pos))
        in
            linesInRow rest poss (ans:acc)
    | (x .&. exists) == exists && (x .&. (n+e+s+w)) == 0 = linesInRow xs (incrPos pos) ((pos,pos):acc)
    | x .&. w == w = error "you shouldnt have found this"
    | otherwise = linesInRow xs (incrPos pos) acc
    where
        findHorizontal :: [Int] -> Line -> (Line,[Int],Point)
        findHorizontal (x:xs) line
            | x .&. 10 == 10 =
                let
                    (start,(x,y)) = line
                in
                    findHorizontal xs (start,(x+1,y))
            | x .&. w == w =
                let
                    (start,(x,y)) = line
                in
                    ((start,(x,y)),xs,(x+1,y))
            | otherwise = error "you shouldnt have found this"
        findHorizontal [] line =
            let
                (start,(x,y)) = line
            in
                ((start,(x,y)),xs,(x+1,y))
        incrPos :: Point -> Point
        incrPos (x,y) = (x+1,y)
linesInRow [] pos acc = acc

linesInCol :: [Int] -> (Int,Int) -> [Line] -> [Line]
linesInCol (x:xs) pos acc
    | x .&. s == s =
        let
            (ans,rest,poss) = findVertical xs (pos,(incrPos pos))
        in
            linesInCol rest poss (ans:acc)
    -- | x .&. exists == exists = linesInCol xs (incrPos pos) acc
    | x .&. n == n = error "you shouldnt have found this"
    | otherwise = linesInCol xs (incrPos pos) acc
    where
        findVertical :: [Int] -> Line -> (Line,[Int],Point)
        findVertical (x:xs) line
            | x .&. 5 == 5 =
                let
                    (start,(x,y)) = line
                in
                    findVertical xs (start,(x,y+1))
            | x .&. n == n =
                let
                    (start,(x,y)) = line
                in
                    ((start,(x,y)),xs,(x,y+1))
            | otherwise = error "you shouldnt have found this"
        incrPos :: Point -> Point
        incrPos (x,y) = (x,y+1)
linesInCol [] pos acc = acc


convertIntonums :: [String] -> [[Int]]
convertIntonums x = convertToInts $ breakIntoColumns $ breakIntoRows x
    where
        breakIntoRows :: [String] -> [[String]]
        breakIntoRows (a:b:c:xs) = [a,b,c] : breakIntoRows xs
        breakIntoRows [] = []
        breakIntoRows _ = error "FUCK"

        breakIntoColumns :: [[String]] -> [[AsciiPoint]]
        breakIntoColumns x = map breakColumn x

        breakColumn :: [String] -> [AsciiPoint]
        breakColumn [] = []  -- Base case: If the input list is empty, the result is empty.
        breakColumn [a, b, c]
            | all null [a, b, c] = []
            | otherwise =
                (take 3 a, take 3 b, take 3 c) : breakColumn [drop 3 a, drop 3 b, drop 3 c]

        convertToInts :: [[AsciiPoint]] -> [[Int]]
        convertToInts x = map rowOfInts x
            where
                rowOfInts :: [AsciiPoint] -> [Int]
                rowOfInts x = map value x
                    where
                        value :: AsciiPoint -> Int
                        value (_:no:_,we:ex:ea,_:so:_) =
                            let
                              jhbgv   north = if no == '|' then n else 0
                                south = if so == '|' then s else 0
                                east = if ea == "-" then e else 0
                                west = if we == '-' then w else 0
                                esi = if ex == 'o' then exists else 0
                            in
                                north + south + east + west + esi


main = do
    -- print (linesInRow ".o--o..o--o--o--o..o." (0,0) [])
    -- mapM_ print (breakIntoColumns $ breakIntoRows ["......","....o.","....|.","....|.","....o.","......"])
    -- mapM_ putStrLn $ show (breakIntoColumns $ breakIntoRows ["..................","..................","..................","..................","..................","..................","..................",".o--o--o--o--o--o.",".................."])
    print (parseMaze ["...",".o.","..."])
    mapM_ print (parseMaze ["...............","...............","...............","...............",".............o.",".............|.",".............|.",".............o.",".............|.",".............|.",".............o.","...............","...............","...............","...............","...............","....o--o--o--o.","..............."] )
