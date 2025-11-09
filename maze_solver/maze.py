from typing import Optional

import numpy as np

RUNNER = tuple[list[int], str]
# MAZE = "np.ndarray"


def create_maze(width: int = 5, height: int = 5) -> np.ndarray:
    """
    creates an 2-dimensional array of integers to represent
    the maze in the dimensions specified when the function os called
    dimensions default to 5x5 as specified

    walls a binary numbers in each square - 1 means
    the presence of a wall 0 means lack off
    1 = 0001 - wall to the east of cell
    2 = 0010 - wall to the north of cell
    4 = 0100 - wall to the west of cell
    8 = 1000 - wall to the south of cell

    eg 5 = 0101 means walks to te east and west of a c
    15 = 1111 means the cell is entirely surrounded by walls
    """
    # initilise an array of dimensions filled with 0s (no walls yet)
    maze = np.array([
        [0 for i in range(width)]
        for j in range(height)
        ])
    # add all the top and bottom walls by iterating along
    # the width and setting the top
    # and bottom values in the array to reflect a wall above
    # or below respectively
    for i in range(width):
        maze[0][i] += 2  # north wall
        maze[height - 1][i] += 8  # south wall
    # add all the right and left walls by iterating along
    # the height and setting the right
    # and left values in the array to reflect a wall
    # right or left respectively
    for i in range(height):
        maze[i][0] += 4  # west wall
        maze[i][width - 1] += 1  # east wall
    return maze


def add_horizontal_wall(
    maze: np.ndarray, x_coordinate: int, horizontal_line: int
) -> np.ndarray:
    """
    adds a horizontal wall
    converts the y coordinate as teh maze's origin is the bottom left
    while numpy is the top left
    selects the cells that neighbor the wall (cells above and bellow)
    for each cell
        accesses the array to fetch the value in the cell
        uses a bitwise or with the correct integer to reflect the new
        wall
        (or is used to prevent a bit overflow the would case the cell
        to hold an erroneous value )
        (both cells are updated to maintain consistency throughout the
        maze)
        update the value off the cell in the maze to be this new value
    returns the maze so it can be used throughout the program
    """
    horizontal_line = maze.shape[0] - horizontal_line - 1
    maze[horizontal_line, x_coordinate] |= 8  # south wall for cell above
    maze[horizontal_line + 1, x_coordinate] |= 2  # north wall for cell below
    return maze


def add_vertical_wall(
    maze: np.ndarray, y_coordinate: int, vertical_line: int
) -> np.ndarray:
    """
    adds a vertical wall
    converts the y coordinate as teh maze's origin is the bottom left
    while numpy is the top left
    selects the cells that neighbor the wall (cells east and west)
    for each cell
        accesses the array to fetch the value in the cell
        uses a bitwise or with the correct integer to reflect the new wall
        (or is used to prevent a bit overflow the would case the cell to hold
        an erroneous value )
        (both cells are updated to maintain consistency throughout the maze)
        update the value off the cell in the maze to be this new value
    returns the maze so it can be used throughout the program
    """
    y_coordinate = maze.shape[0] - y_coordinate - 1
    maze[y_coordinate, vertical_line - 1] |= 1  # east wall for cell on left
    maze[y_coordinate, vertical_line] |= 4  # west wall for cell on right
    return maze


def get_dimensions(maze: np.ndarray) -> tuple[int, int]:
    """
    uses the inbuilt numpy attribute "shape" to fetch shape
    reverses the order as shape outputs a tuple in the form (y,x)
    and this function must output (x,y)
    """
    return maze.shape[1], maze.shape[0]


def get_walls(
    maze: np.ndarray, x_coordinate: int, y_coordinate: int
) -> tuple[bool, bool, bool, bool]:
    """
    takes a maze and coordinates as input
    
    return true if there is a wall for each in (N,E,S,W)
    
    uses a bitwise and operator to check the bits stored in each
    cell as they represent where each wall is
    """
    y_coordinate = maze.shape[0] - y_coordinate - 1
    pos = int(maze[y_coordinate, x_coordinate])
    return (
        2 & pos != 0,
        1 & pos != 0,
        8 & pos != 0,
        4 & pos != 0,
    )  # bitwise and for NESW truth values


# should check outside walls??
def print_maze(
    maze: np.ndarray,
    runner: RUNNER = ([0, 0], "N"),
    goal: Optional[tuple[int, int]] = None,
    path: Optional[list[tuple[int,int]]] = None
):
    """
    takes a maze and optionsal starting,goal,path as inputs
    loops throught the maze to create an array where each position in the array
    is surrounded by empty nodes that can be updated to display walls
    the first generatior places a wall on each corner and the top and left sides of
    the maze as these will always contain walls for a complete maze
    the function then loops through the maze and updates the new array to represent walls
    accordingly with the ██ ascii character
    fianlly it prints the maze line by line into the console for the user to see
    """
    out = np.array(
        [
            [
                ("██" if
                 (i % 2 == 0 and j % 2 == 0) or
                 (i == 0 or j == 0)
                 else "  ")
                for i in range(get_dimensions(maze)[0] * 2 + 1)
            ]
            for j in range(get_dimensions(maze)[1] * 2 + 1)
        ]
    )
    for x in range(get_dimensions(maze)[0]):
        for y in range(get_dimensions(maze)[1]):
            y_coordinate = maze.shape[0] - y - 1
            if get_walls(maze, x, y)[1]:
                out[2 * y_coordinate + 1, 2 * x + 2] = "██"
            if get_walls(maze, x, y)[2]:
                out[2 * y_coordinate + 2, 2 * x + 1] = "██"  # alt 219
            if path and (x,y) in path:
                out[2 * y_coordinate + 1, 2 * x+1] = "* "

    facing = {"N": "/\\", "E": ">", "S": "\\/", "W": "<"}
    r_x, r_y = runner[0][0], maze.shape[0] - runner[0][1] - 1
    out[2 * r_y + 1, 2 * r_x + 1] = facing[runner[1]] + " "

    if goal is None:
        goal = maze.shape[1] - 1, maze.shape[0] - 1

    r_x, r_y = goal[0], maze.shape[0] - goal[1] - 1
    out[2 * r_y + 1, 2 * r_x + 1] = "* "

    if goal[0] == runner[0][0] and goal[1] == runner[0][1]:
        out[2 * r_y + 1, 2 * r_x + 1] = "()"

    for i in out:
        prt = ""
        for j in i:
            prt += j
        print(prt)
