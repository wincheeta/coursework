f = [i.strip("\n").split(",") for i in open("ecs.txt").readlines()]

for i in f:
    for a in range(int(len(i))):
        print(chr(~int(i[a])))
 