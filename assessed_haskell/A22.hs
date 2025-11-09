import Data.Map (Map, empty, insertWith, toList, lookup, findWithDefault)
import Data.Bits ((.&.), (.|.))
import Data.List (transpose, intercalate)
import Control.Monad (join)

-- Define connectivity constants
n, e, s, w :: Int
n = 1  -- North (0001) corresponds to a connection to (x, y-1)
e = 2  -- East (0010) corresponds to a connection to (x+1, y)
s = 4  -- South (0100) corresponds to a connection to (x, y+1)
w = 8  -- West (1000) corresponds to a connection to (x-1, y)

type Coord = (Int, Int)
type Path = (Coord, Coord)
type MazeInfo = Map Coord Int -- Map from (x, y) to connectivity bitmask

-- A function to render the maze
renderMaze :: [Path] -> [String]
renderMaze [] = []
renderMaze paths =
    let
        (maxX, maxY) = maxPoint paths
        mazeInfo = buildMazeInfo paths
        -- Create a grid of 3x3 cells. The grid is (maxX+1) x (maxY+1).
        -- Accessing (x, y) in the grid should give the cell for that coordinate.
        cellGrid = [[getCell mazeInfo (x, y) | x <- [0..maxX]] | y <- [0..maxY]]
    in
        -- Combine the rows of 3x3 cells into the final output strings
        flattenGrid cellGrid

maxPoint :: [Path] -> Coord
maxPoint [] = (0, 0)
maxPoint xs = (maxXVal, maxYVal)
    where
        maxXVal = maximum [max x1 x2 | ((x1,_), (x2,_)) <- xs]
        maxYVal = maximum [max y1 y2 | ((_,y1), (_,y2)) <- xs]

pointsInaPath :: ((Int, Int), (Int, Int)) -> [((Int,Int),Int)] -- N north connect, S south connect etc...
pointsInaPath ((x1,y1),(x2,y2))
    | x1 == x2 = [((x1,y), direction (min y1 y2) (max y1 y2) y "V") | y <- [(min y1 y2)..(max y1 y2)]]
    | y1 == y2 = [((x,y1), direction (min x1 x2) (max x1 x2) x "H") | x <- [(min x1 x2)..(max x1 x2)]]
        where
            direction :: Int -> Int -> Int -> String -> Int
            direction start finish current "H"
                | start == current = e
                | finish == current = w
                | otherwise = e .|. w 
            direction start finish current "V"
                | start == current = s
                | finish == current = n
                | otherwise = n .|. s
            direction _ _ _ _ = 0

buildMazeInfo :: [Path] -> MazeInfo
buildMazeInfo maze = 
    let 
        paths = concatMap pointsInaPath maze
    in 
        -- `insertWith (.|.)` combines connectivity bitmasks for the same coordinate
        foldr combineConnectivityStep empty paths
            where
                combineConnectivityStep :: (Coord, Int) -> MazeInfo -> MazeInfo
                combineConnectivityStep (coord, conn) accMap = 
                    insertWith (.|.) coord conn accMap
                    
-- Get a 3x3 list of characters for a given connectivity bitmask
renderCell :: Int -> [String]
renderCell conn = 
    let 
        north = if (conn .&. n) /= 0 then '|' else '.'
        south = if (conn .&. s) /= 0 then '|' else '.'
        east  = if (conn .&. e) /= 0 then '-' else '.'
        west  = if (conn .&. w) /= 0 then '-' else '.'
    in
        [
            ['.', north, '.'],
            [west, 'o', east],
            ['.', south, '.']
        ]

-- Get the 3x3 cell for a coordinate, or a blank cell if it's not in the maze
getCell :: MazeInfo -> Coord -> [String]
getCell info coord = 
    let 
        cell = Data.Map.lookup coord info
    in
        if cell == Nothing
        then
            ["...","...","..."]
        else
            renderCell (Data.Map.findWithDefault 0 coord info)

-- Flattens a row of 3x3 cells (a list of 3x3 matrices) into three long strings
concatRow :: [[[Char]]] -> [[Char]]
concatRow cells = 
    -- cells is a list of 3x3 grids: [C1, C2, C3, ...]
    -- where Ci = [R_i1, R_i2, R_i3]
    -- We want [R_11++R_21++R_31..., R_12++R_22++R_32..., R_13++R_23++R_33...]
    let 
        -- Transpose converts [[R1C1], [R1C2], ...] to [[R1C1, R1C2, ...], ...]
        -- where R1C1 is [row1, row2, row3]
        transposedCells = transpose cells 
    in
        -- Now we have [[R1C1, R1C2, ...], [R2C1, R2C2, ...], [R3C1, R3C2, ...]]
        -- We join each of these inner lists of strings (rows of the cells)
        map concat transposedCells

-- Flattens the entire grid of 3x3 cells into the final list of strings
flattenGrid :: [[[[Char]]]] -> [String]
flattenGrid gridOfCells = 
    -- gridOfCells is a list of rows, where each row is a list of 3x3 cells
    concatMap concatRow gridOfCells

main = do
    mapM_ putStrLn (renderMaze [((0,0),(0,1)),((0,1),(1,1)),((1,1),(1,2)),((1,2),(2,2)),((2,2),(2,3)),((2,3),(3,3)),((3,3),(3,5)),((3,4),(4,4)), ((2,5),(5,5)),((2,5),(2,6)),((1,6),(2,6)),((1,7),(1,6)),((0,7),(1,7)),((5,5),(5,6)),((5,6),(6,6)),((6,6),(6,7)),((6,7),(7,7))])