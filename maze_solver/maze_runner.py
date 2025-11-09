from maze import (print_maze,
                  create_maze,
                  add_horizontal_wall,
                  add_vertical_wall)
from runner import create_runner, get_pos, move, explore
import numpy as np
from typing import Optional
import argparse


def maze_reader(maze_file: str) -> np.ndarray:
    """
    Creates a maze from an input file
    
    iterates through the file and adds walls to the corresponding
    numpy array which represents the maze
    makes use of both prebuild add_wall functions as part of the 
    maze file
    """
    try:
        temp = open(maze_file, "r").readlines()
    except FileNotFoundError:
        raise IOError
    try:
        file: np.ndarray = np.array([[j for j in i.strip("\n")] for i in temp])
    except ValueError:
        raise ValueError
    y, x = file.shape
    y = int((y - 1) / 2)
    x = int((x - 1) / 2)
    maze = create_maze(x, y)
    # verticle walls
    for Y in range(y):
        for X in range(x):
            new_Y = y - Y - 1
            if file[2 * new_Y + 1, 2 * X] == "#":
                maze = add_vertical_wall(maze, Y, X)
            elif file[2 * new_Y + 1, 2 * X] == ".":
                continue
            else:
                raise ValueError

    # horizontal walls
    for X in range(x):
        for Y in range(y):
            new_Y = y - Y - 1
            if file[2 * new_Y, 2 * X + 1] == "#":
                maze = add_horizontal_wall(maze, X, Y + 1)
            elif file[2 * new_Y, 2 * X + 1] == ".":
                continue
            else:
                raise ValueError
    return maze


def shortest_path(
    maze: np.ndarray,
    starting: Optional[tuple[int, int]] = None,
    goal: Optional[tuple[int, int]] = None,
) -> list[tuple[int, int]]:
    """
    uses left hug to find the shortest path in a simple maze (will now work for loops)
    creates a runner and makes the runner repeatedly explore the maze until it reaches the goal
    at each step it saves the runners current position to a list
    the list is then iterated through and for all instances where a point has been visited twice
    all the moves between the are removed as they must not be on the shortest path
    this is done until evey value in visited is unique and then visited is output
    """
    if starting is None:
        starting = (0, 0)
    elif starting[0] >= maze.shape[1] or starting[1] >= maze.shape[0]:
        raise IOError("start is out of bounds of the maze")
    if goal is None:
        goal = (maze.shape[1] - 1, maze.shape[0] - 1)
    elif goal[0] >= maze.shape[1] or goal[1] >= maze.shape[0]:
        raise IOError("goal is out of bounds of the maze")

    runner = create_runner(starting[0], starting[1])
    route = []
    while get_pos(runner) != goal:
        route.append(tuple(runner[0]))
        runner, _ = move(runner, maze)
    route.append(get_pos(runner))

    visited = []
    for i in route:
        if i in visited:
            visited.append(tuple(i))
            current = visited.index(i)
            visited.pop(current)
            while visited[current] != i:
                visited.pop(current)
        else:
            visited.append(tuple(i))

    return visited


if __name__ == "__main__":
    """
    the main of the whole projcet
    called through the console usning:
    maze_runner.py [-h] [--starting STARTING] [--goal GOAL] maze
    """
    parser = argparse.ArgumentParser(description="ECS Maze Runner")
    parser.add_argument(
        "maze", type=str, help="The name of the maze file, e.g., maze1.mz"
    )
    parser.add_argument(
        "--starting", type=str, help='The starting position, e.g., "2, 1"'
    )
    parser.add_argument(
        "--goal", type=str, help='The goal position, e.g., "4, 5"'
    )

    args = parser.parse_args()

    maze = maze_reader(args.maze)
    
    # input validating from the console input
    try:
        pos = args.starting.split(", ")
    except AttributeError:
        pos = [0, 0]
        # CATCH ERROR HERE
    try:
        args.goal = tuple([int(i) for i in args.goal.split(", ")])
    except AttributeError:
        args.goal = maze.shape[1] - 1, maze.shape[0] - 1
        # CATCH ERROR HERE
    runner = create_runner(int(pos[0]), int(pos[1]))

    # clears the efile ready to be written to
    open("exploration.csv", "w").write(
        "Step,x-coordinate,y-coordinate,Actions\n"
        )
    file = open("exploration.csv", "a")
    i = 1 # represents the number of moves
    
    # performs the explore function appending each position and move into
    # the output file as it goes
    while get_pos(runner) != args.goal:
        old_pos = get_pos(runner)
        runner, act = move(runner, maze)
        file.write(f"{i},{old_pos[0]},{old_pos[1]},{act}\n")
        i += 1

    open("statistics.txt", "w")
    file = open("statistics.txt", "a")
    file.writelines(args.maze + "\n")
    # calculates and adds the stats to the second output file
    # as required by the specification by calling shortest_path
    exploration_steps = i - 1
    shortest = shortest_path(maze, pos, args.goal)
    path_length = len(shortest)
    file.writelines(str((exploration_steps / 4) + path_length) + "\n")
    file.writelines(str(exploration_steps) + "\n")
    file.write(str(shortest) + "\n")
    file.write(str(path_length) + "\n")