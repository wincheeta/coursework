from datetime import timedelta
from os.path import split

from numpy.matlib import empty


def init_leaderboard() -> dict[str, timedelta]:
    leaderboard = {}
    return leaderboard

def add_player(leaderboard,player_name):
    if player_name not in leaderboard.keys():
        leaderboard[player_name] = None
        return True
    else:
        return False

def add_run(leaderboard, player_name, time: timedelta):
    if time.total_seconds() >= 0:
        if player_name in leaderboard.keys():
            if leaderboard[player_name] == None or leaderboard[player_name].total_seconds()  > time.total_seconds():
                leaderboard[player_name] = time
            return 0
        else:
            return 2
    else:
        return 1

def clear_score(leaderboard, player_name):
    if  player_name in leaderboard.keys():
        leaderboard[player_name] = None
        return True
    else:
        return False

def display_leaderboard(leaderboard, n=3):
    empty = True
    for i in leaderboard.values():
        if i != None:
            empty = False
    if empty:
        print("Leaderboard is empty")
        return None

    tempor = {}
    for i in leaderboard.keys():
        if leaderboard[i] != None:
            tempor[i] = leaderboard[i].total_seconds()
    temp = sorted(list(tempor.keys()), key=tempor.__getitem__)
    for i in range(n):
        if i +1 > len(temp):
            continue
        print(str(i+1)+ "\t" +temp[i]+ "\t" + f"{timedelta(seconds = tempor[temp[i]])}")

def calculate_average_time(leaderboard):
    sum = 0
    total = 0
    for i in leaderboard.values():
        if i == None:
            continue
        else:
            sum += i.total_seconds()
            total += 1
    if total:
        return (True, timedelta(seconds = sum / total))
    else:
        return (False, None)


leaderboard = init_leaderboard()
add_player(leaderboard, "Alice")
add_player(leaderboard, "Bob")
add_player(leaderboard, "Charlie")
print(calculate_average_time(leaderboard) == (False, None))