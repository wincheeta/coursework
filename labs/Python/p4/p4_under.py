from datetime import *
import os 

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
    
def export_leaderboard(leaderboard : dict[str, timedelta], dest):
    try: 
        f = open(dest, "w")
    except:
        raise ValueError()
    f.write("Name,Hour,Minute,Second\n")
    for k in leaderboard.keys():
        time = leaderboard[k]
        if time == None:
            f.write(f"{k},,,\n")
        else:
            secs = int( time.total_seconds() )
            mins = int( secs // 60 )
            hours = int( mins // 60 )
            f.write(f"{k},{hours},{mins%60},{secs%60}\n")
        
        
# if the player is not already on the leaderboard, the player should be added with the time from the source CSV file. If there are no times from the source CSV, you should still add the player on the leaderboard (without a recorded time.
# if the player is already on the leaderboard, but has no recorded time on the board, set the time from the source CSV file (if it is not empty) as the recorded time.
# otherwise, i.e., if the player is already on the leaderboard with a recorded time, update this recorded time only if the time from the source CSV is not empty and is better
def import_leaderboard(leaderboard, source):
    try: 
        f = [i[:-1].split(",") for i in open(source, "r").readlines()]
    except:
        raise ValueError()
    for i in range(1,len(f)):
        try:
            if f[i][1] == "" and  f[i][2] == "" and f[i][3] == "":
                time = None
            else:
                time = timedelta(hours=int(f[i][1]), minutes=int(f[i][2]), seconds=int(f[i][3]))#
            
            if f[i][0] in leaderboard.keys():
                if leaderboard[f[i][0]] == None:
                    leaderboard[f[i][0]] = time
                elif time != None and time.total_seconds() < leaderboard[f[i][0]].total_seconds():
                    leaderboard[f[i][0]] = time
            else:
                leaderboard[f[i][0]] = time
        except:
            pass
        
[]
leaderboard = {
                "Alice": timedelta(hours=5, minutes=4, seconds=10),
                "Charlie": None,
                "Bob": timedelta(hours=5, minutes=10, seconds=7),
            }
destination = "one_runner.csv"
expected_lines = ["Name,Hour,Minute,Second", "Alice,5,4,10"]

#export_leaderboard(leaderboard, destination)
print(leaderboard)
import_leaderboard(leaderboard, destination)