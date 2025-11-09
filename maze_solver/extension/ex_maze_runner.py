from typing import Optional
import argparse
import numpy as np
from ex_maze import (print_maze, create_maze, add_horizontal_wall, add_vertical_wall, get_walls, get_dimensions)
from ex_runner import create_runner, get_pos, move


def maze_reader(maze_file: str) -> np.ndarray:
    """
    uses left hug to find the shortest path in a simple maze (will now work for loops)
    creates a runner and makes the runner repeatedly explore the maze until it reaches the goal
    at each step it saves the runners current position to a list
    the list is then iterated through and for all instances where a point has been visited twice
    all the moves between the are removed as they must not be on the shortest path
    this is done until evey value in visited is unique and then visited is output
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


def cell_id(pos, width):
    """
    creates a unique int for each cell in a maze
    used so that each position can be hashed into a dictionary and set
    """
    return pos[0] + pos[1]*width


def id_to_cell(id, width):
    """
    converts back from the unique id into the coordinates of a cell
    """
    return (id % width, id // width)


def shortest_path(
    maze: np.ndarray,
    starting: Optional[tuple[int, int]] = None,
    goal: Optional[tuple[int, int]] = None,
) -> list[tuple[int, int]]:
    """
    My implimentatinon of dijkstras shortest path algorithm
    
    nodes is a dictionary that contains each node's id as a key,
    and the shortest path to that node (excluding itself) as the vaule
    the path is represented by a list of tupples
    
    the algorithm works by doing a breath first traversal of the maze
    and comparing the lenght of the route to istself with the lenght of the route 
    its neighbours
    if its route is shorter it updates the neighbour to reflect this 
    
    finally it returns the value corresponding to the id of the goal
    as that will be the shortest path to the goal
    """
    if starting is None:
        starting = (0, 0)
    elif starting[0] >= maze.shape[1] or starting[1] >= maze.shape[0]:
        raise IOError("start is out of bounds of the maze")
    if goal is None:
        goal = (maze.shape[1] - 1, maze.shape[0] - 1)
    elif goal[0] >= maze.shape[1] or goal[1] >= maze.shape[0]:
        raise IOError("goal is out of bounds of the maze")

    to_visit = [starting]
    visited = set()
    nodes = dict()
    x, y = None, None
    while to_visit:
        x, y = to_visit.pop(0)
        width = get_dimensions(maze)[0]
        id = cell_id((x, y), width)
        if id in visited:
            continue
        visited.add(id)
        if id not in nodes.keys():
            nodes[id] = [i for i in range(width*get_dimensions(maze)[1])]
        if (x, y) == starting:
            nodes[id] = []

        walls = get_walls(maze, x, y)
        neighbors = [
            ((x, y + 1), walls[0]),
            ((x + 1, y), walls[1]),
            ((x, y - 1), walls[2]),
            ((x - 1, y), walls[3])
        ]

        for (nx, ny), wall in neighbors:
            neighbor_id = cell_id((nx, ny), width)
            if not wall:
                if neighbor_id not in visited:
                    to_visit.append((nx, ny))
                if neighbor_id not in nodes.keys() or len(nodes[id]) + 1 < len(nodes[neighbor_id]):
                    nodes[neighbor_id] = nodes[id] + [(x, y)]
    return nodes[cell_id((goal[0], goal[1]), width)] + [goal]


if __name__ == "__main__":
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
    try:
        pos = args.starting.split(", ")
    except AttributeError:
        pos = (0, 0)
        # CATCH ERROR HERE
    try:
        args.goal = tuple([int(i) for i in args.goal.split(", ")])
    except AttributeError:
        args.goal = maze.shape[1] - 1, maze.shape[0] - 1
        # CATCH ERROR HERE
    runner = create_runner(int(pos[0]), int(pos[1]))

    open("exploration.csv", "w").write(
        "Step, x-coordinate, y-coordinate, Actions\n"
        )
    file = open("exploration.csv", "a")
    i = 1
    while get_pos(runner) != args.goal:
        old_pos = get_pos(runner)
        runner, act = move(runner, maze)
        file.write(f"{i}, {old_pos[0]}, {old_pos[1]}, {act}\n")
        i += 1

    open("statistics.txt", "w")
    file = open("statistics.txt", "a")
    file.writelines(args.maze + "\n")

    exploration_steps = i - 1
    shortest = shortest_path(maze, pos, args.goal)
    print_maze(maze, path=shortest)
    path_length = len(shortest)
    file.writelines(str((exploration_steps / 4) + path_length) + "\n")
    file.writelines(str(exploration_steps) + "\n")
    file.write(str(shortest) + "\n")
    file.write(str(path_length) + "\n")

    # print_maze(maze)

    # maze_runner.py [-h] [--starting STARTING] [--goal GOAL] maze
