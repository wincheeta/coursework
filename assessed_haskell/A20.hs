import Data.Map (Map, empty, insertWith, lookup)
import Data.List (nub)

-- Type aliases for clarity and better documentation
type Point = (Int, Int)
type Path = (Point, Point)
data Direction = N | E | S | W deriving (Show, Eq, Ord)
type Connections = [Direction]
type MazeInfo = Map Point Connections

-- | findMaxCoords: Determines the maximum X and Y coordinates in the maze.
-- This defines the size of the logical grid (0 to maxX, 0 to maxY).
findMaxCoords :: [Path] -> Point
findMaxCoords paths = (maxX, maxY)
  where
    -- Extract all coordinates from all paths
    allCoords = concatMap (\((x1, y1), (x2, y2)) -> [(x1, y1), (x2, y2)]) paths
    -- Use 0 as a baseline in case of an empty path list
    maxX = maximum (0 : map fst allCoords)
    maxY = maximum (0 : map snd allCoords)

-- | direction: Determines the direction from point P1 to adjacent point P2.
-- Returns Nothing if they are not adjacent or on a diagonal.
direction :: Point -> Point -> Maybe Direction
direction (x1, y1) (x2, y2)
  -- N: (x, y) to (x, y-1)
  | x1 == x2 && y2 == y1 - 1 = Just N
  -- S: (x, y) to (x, y+1)
  | x1 == x2 && y2 == y1 + 1 = Just S
  -- E: (x, y) to (x+1, y)
  | y1 == y2 && x2 == x1 + 1 = Just E
  -- W: (x, y) to (x-1, y)
  | y1 == y2 && x2 == x1 - 1 = Just W
  | otherwise = Nothing

-- | pathSegments: Decomposes a Path into a list of adjacent (length-1) segments.
pathSegments :: Path -> [(Point, Point)]
pathSegments ((x1, y1), (x2, y2))
  | x1 == x2 = -- Vertical path
    let minY = min y1 y2
        maxY = max y1 y2
    in [((x1, y), (x1, y + 1)) | y <- [minY .. maxY - 1]]
  | y1 == y2 = -- Horizontal path
    let minX = min x1 x2
        maxX = max x1 x2
    in [((x, y1), (x + 1, y1)) | x <- [minX .. maxX - 1]]
  | otherwise = [] -- Only horizontal or vertical paths are valid

-- | buildMazeInfo: Processes all path segments to build a map from Point to unique Connections.
buildMazeInfo :: [Path] -> MazeInfo
buildMazeInfo paths = foldl combineSegments empty allSegments
  where
    allSegments = concatMap pathSegments paths

    -- Function to aggregate connections for each point from a segment (p1, p2)
    combineSegments :: MazeInfo -> (Point, Point) -> MazeInfo
    combineSegments acc (p1, p2) =
      let dir1To2 = direction p1 p2
          dir2To1 = direction p2 p1

          -- Helper to add a new direction to a point's list, ensuring uniqueness
          addDir p d m =
            case d of
              Just dir -> insertWith (\new old -> nub (new ++ old)) p [dir] m
              Nothing -> m

          -- Update map for both endpoints of the segment
          step1 = addDir p1 dir1To2 acc
          step2 = addDir p2 dir2To1 step1
      in step2

-- | renderCell: Creates the 3x3 character matrix for a given cell coordinate.
renderCell :: Maybe Connections -> [String]
renderCell mconnections =
  case mconnections of
    Just connections ->
      -- If the point is on a path, use 'o' in the center and connection symbols
      [ ['.', north, '.'],
        [west, 'o', east],
        ['.', south, '.']
      ]
      where
        hasN = N `elem` connections
        hasS = S `elem` connections
        hasE = E `elem` connections
        hasW = W `elem` connections

        -- '|' for vertical, '-' for horizontal, '.' otherwise
        north = if hasN then '|' else '.'
        south = if hasS then '|' else '.'
        east = if hasE then '-' else '.'
        west = if hasW then '-' else '.'

    Nothing ->
      -- If the point is not on a path, the cell is entirely '.'
      replicate 3 (replicate 3 '.')

-- | renderMaze: The main function to render the maze row-by-row.
renderMaze :: [((Int, Int), (Int, Int))] -> [String]
renderMaze paths =
  let
    -- 1. Determine maze bounds
    (maxX, maxY) = findMaxCoords paths

    -- 2. Build connectivity map
    mazeInfo = buildMazeInfo paths

    gridCoordsY = [0 .. maxY]
    gridCoordsX = [0 .. maxX]

    -- | generateRowBlock: Produces a block of 3 output rows for a specific grid Y-coordinate.
    generateRowBlock y =
      let
        -- Get the 3x3 cell representation for each point (x, y) across the row
        -- The result is a list of 3x3 matrices (list of strings)
        cells = [renderCell $ Data.Map.lookup (x, y) mazeInfo | x <- gridCoordsX]

        -- | flattenRow: Concatenates the r'-th output row from all 3x3 cells horizontally.
        -- r' = 0: top row of the cell (North connection)
        -- r' = 1: middle row of the cell (West/East/Center)
        -- r' = 2: bottom row of the cell (South connection)
        flattenRow r' = concatMap (\cell -> cell !! r') cells
      in
        -- Produce the 3 concatenated output strings for this Y block
        [flattenRow 0, flattenRow 1, flattenRow 2]

  in
    -- Combine all 3-row blocks into a single list of output strings
    concatMap generateRowBlock gridCoordsY

mazeExample1 :: [Path]
mazeExample1 = [((2,0),(2,3)),((0,1),(4,1)),((1,3),(3,3)),((1,3),(1,5)),((3,3),(3,5))] 

main = do
    mapM_ putStrLn $ renderMaze mazeExample1
    print (renderMaze [((0,0),(0,1)),((0,1),(1,1)),((1,1),(1,2)),((1,2),(2,2)),((2,2),(2,3)),((2,3),(3,3)),((3,3),(3,5)),((3,4),(4,4)), ((2,5),(5,5)),((2,5),(2,6)),((1,6),(2,6)),((1,7),(1,6)),((0,7),(1,7)),((5,5),(5,6)),((5,6),(6,6)),((6,6),(6,7)),((6,7),(7,7))])