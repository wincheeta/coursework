{-# OPTIONS_GHC -Wno-overlapping-patterns #-}
import Data.Map (Map, empty, insertWith, toList, lookup,findWithDefault)
import Data.Bits ( Bits((.&.), (.|.)) )

type MazeInfo = Map (Int,Int) Int

n, e, s, w :: Int
n = 1  -- North (0001)
e = 2  -- East (0010)
s = 4  -- South (0100)
w = 8  -- West (1000)

renderMaze :: [((Int, Int), (Int, Int))] -> [String]
renderMaze [] = []
renderMaze paths =
    let
        (maxX, maxY) = maxPoint paths
        mazeInfo = buildMazeInfo paths
        cellGrid = [[getCell mazeInfo (x, y) | x <- [0..maxX]] | y <- [0..maxY]]
    in
        flattenGrid cellGrid


maxPoint :: [((Int, Int), (Int, Int))] -> (Int,Int)
maxPoint xs = (maxX xs, maxY xs)
    where
        maxX,maxY :: [((Int, Int), (Int, Int))] -> Int
        maxX [] = 0
        maxX xs = maximum [max a b | ((a,_), (b,_)) <- xs]

        maxY [] = 0
        maxY xs = maximum [max a b | ((_,a), (_,b)) <- xs]


listAllPaths :: [((Int, Int), (Int, Int))] -> [((Int, Int), Int)]
listAllPaths [] = []
listAllPaths xs = concat (map pointsInaPath xs)
    where
        pointsInaPath :: ((Int, Int), (Int, Int)) -> [((Int,Int),Int)] -- N north connect, S south connect etc...
        pointsInaPath ((x1,y1),(x2,y2))
            | x1 == x2 = [((x1,y), direction (min y1 y2) (max y1 y2) y "V") | y <- [(min y1 y2)..(max y1 y2)]]
            | y1 == y2 = [((x,y1), direction (min x1 x2) (max x1 x2) x "H") | x <- [(min x1 x2)..(max x1 x2)]]
                where
                    direction :: Int -> Int -> Int -> String -> Int
                    direction start finish current "H"
                        | start == finish = 0
                        | start == current = e
                        | finish == current = w
                        | otherwise = e .|. w 
                    direction start finish current "V"
                        | start == finish = 0
                        | start == current = s
                        | finish == current = n
                        | otherwise = n .|. s
                    direction _ _ _ _ = 0

buildMazeInfo :: [((Int, Int), (Int, Int))] -> MazeInfo
buildMazeInfo maze = foldr combineConnectivityStep empty (listAllPaths maze)
    where
        combineConnectivityStep :: ((Int,Int), Int) -> MazeInfo -> MazeInfo
        combineConnectivityStep (coord, conn) accMap = 
            insertWith (.|.) coord conn accMap


-- createPoints :: Int -> Int -> [[Int]]
-- createPoints x y = [[0 | a <- [0..x]] | b <- [0..y]]

renderCell :: Int -> [String]
renderCell x = 
    let north = if (x .&. n) /= 0 then '|' else '.'
        south = if (x .&. s) /= 0 then '|' else '.'
        east = if (x .&. e) /= 0 then '-' else '.'
        west = if (x .&. w) /= 0 then '-' else '.'
    in  
        [
        ['.', north, '.'],
        [west, 'o', east],
        ['.', south, '.']
        ]

getCell :: MazeInfo -> (Int,Int) -> [String]
getCell info coord = 
    if Data.Map.lookup coord info == Nothing
    then
        ["...","...","..."]
    else
        renderCell (Data.Map.findWithDefault 0 coord info)


concatRow :: [[String]] -> [String]
concatRow cells = 
    map concat (transpose cells)
    where
        transpose :: [[a]] -> [[a]]
        transpose [] = []
        transpose ([] : _) = []
        transpose ((x:xs):xss) = (x : map head xss) : transpose (xs : map tail xss)

flattenGrid :: [[[String]]] -> [String]
flattenGrid gridOfCells = 
    concatMap concatRow gridOfCells

main = do
    -- mapM_ print (listAllPaths [((15,12),(10,12)),((0,0),(0,10))])
    -- mapM_ print (createPoints 10 5)
    -- mapM_ print (renderCell 0)
    -- mapM_ putStrLn (renderMaze [((0,0),(0,1)),((0,1),(1,1)),((1,1),(1,2)),((1,2),(2,2)),((2,2),(2,3)),((2,3),(3,3)),((3,3),(3,5)),((3,4),(4,4)), ((2,5),(5,5)),((2,5),(2,6)),((1,6),(2,6)),((1,7),(1,6)),((0,7),(1,7)),((5,5),(5,6)),((5,6),(6,6)),((6,6),(6,7)),((6,7),(7,7))])
    mapM_ putStrLn (renderMaze [((0,0),(0,0))])