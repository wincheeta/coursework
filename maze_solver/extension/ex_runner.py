from typing import Optional
import numpy as np
from time import sleep
import maze as MAZE

RUNNER = tuple[list[int], str] # constant showing expected data type of a runner
# MAZE = "numpy.ndarray"


def create_runner(x: int = 0, y: int = 0, orientation: str = "N") -> RUNNER:
    """
    creates the runner - runner is stored as a list containing another
    list of x, y coordinates and a radian representation of the
    orientation of the runner

    the orientation is stored as radians with East being 0 as this
    allows the use of trigonametric functions to calculate direction moved
    - this also allows the code to be expanded to solve none
    grid mazes

    the dictionary ori is used to convert between radians and compass diretion
    """
    return ([x, y], orientation)


def get_x(runner: RUNNER) -> int:
    """
    returns the x coordinate of the runner as an int
    """
    return runner[0][0]


def get_y(runner: RUNNER) -> int:
    """
    returns the y coordinate of the runner as an int
    """
    return runner[0][1]


def get_pos(runner: RUNNER) -> tuple[int, int]:
    """
    returns a tuple of the x,y coordinates of a runner
    """
    return runner[0][0], runner[0][1]


def get_orientation(runner: RUNNER) -> str:
    """
    returns the orientation of the runner as a compass direction

    uses the dictionary "rev_ori" to convert from radians to compass point
    """
    return runner[1]


def turn(runner: RUNNER, direction: str) -> RUNNER:
    """
    modifies the orientation of the runner either 90 deg left or right
    the result is the % by 2pi to keep the orientation between 0 and 2pi
    so that both the dictionaries work for conversions

    finally returns the newly updated runner to be used elsewhere
    """
    compass = ["N", "E", "S", "W"]
    pos = compass.index(runner[1])
    if direction == "Left":
        ori = compass[(pos - 1) % 4]
    else:
        ori = compass[(pos + 1) % 4]
    return (runner[0], ori)


def forward(runner: RUNNER) -> RUNNER:
    """
    moves the runner forward one step in the dirrection that it is facing
    """
    match runner[1]:
        case "N":
            runner[0][1] += 1
        case "E":
            runner[0][0] += 1
        case "S":
            runner[0][1] -= 1
        case "W":
            runner[0][0] -= 1
    return runner


def sense_walls(runner: RUNNER, maze: "np.ndarray") -> tuple[bool, bool, bool]:
    """
    uses the orientation of the runner to return whether there is a wall to the left, front and right
    
    it does this by calling the get walls function and checking the value at the front
    it then adapts the index to check left and right wrapping back to the start / end 
    if the index is out of bounds
    """
    walls = MAZE.get_walls(maze, get_x(runner), get_y(runner))
    index = {"E": 1, "N": 0, "W": 3, "S": 2}
    front = index[get_orientation(runner)]
    return walls[front - 1], walls[front], walls[(front + 1) % 4]


def go_straight(runner: RUNNER, maze: "np.ndarray") -> RUNNER:
    """
    checks if there is a wall forward
    if not calls the forward funtion to move into the cell directly 
    in front
    """
    if sense_walls(runner, maze)[1]:
        raise ValueError
    else:
        return forward(runner)


def move(runner: RUNNER, maze: "np.ndarray"):  # left hug algorithm
    """
    uses a left hug aproach to move the runner
    first calls the sense walls to check if walls are 
    to the left, front or right.
    priority of left > front > right
    
    will turn to face the first available dirrection with no walls and go that way
    
    returns the runner with a new position and actions taken to arrive in the next sqaure
    """
    left, forward, right = sense_walls(runner, maze)
    if not left:
        runner = turn(runner, "Left")
        action = "LF"
        go_straight(runner, maze)
    elif not forward:
        action = "F"
        go_straight(runner, maze)
    elif not right:
        runner = turn(runner, "Right")
        action = "RF"
        go_straight(runner, maze)
    else:
        runner = turn(runner, "Left")
        runner = turn(runner, "Left")
        action = "LLF"  # turn around here
        go_straight(runner, maze)

    return runner, action


def explore(
    runner: RUNNER,
    maze: "np.ndarray",
    goal: Optional[tuple[int, int]] = None,
    display: Optional[bool] = False,
) -> str:
    """
    repeatedly calls the move function until the runner
    arrives at the goal
    
    return a string of all the actions it took to get to the goal
    """
    if goal is None:
        goal = maze.shape[1] - 1, maze.shape[0] - 1
    actions = ""
    while get_pos(runner) != goal:
        if display:
            MAZE.print_maze(maze, runner, goal)
            sleep(0.5)
        runner, temp = move(runner, maze)
        actions += temp
    return actions
