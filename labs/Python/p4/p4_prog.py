def uniq(src,dst):
    try:
        src = open(src,'r').readlines()
        dst = open(dst,'w')
    except:
        raise ValueError
    count = 0
    dst.write(src[0])
    count += 1
    for i in range(1,len(src)):
        if src[i] != src[i-1]:
            dst.write(src[i])
            count +=1
    return count

import csv


def calculate_running_total(src,dst):
    try:
        src = open(src,'r')
        temp = csv.reader(src,delimiter=',')
        file = [i for i in temp]
        dst =open(dst,'w')
    except:
        raise ValueError
    file[0].append("Running Total\n")
    current = 0
    for i in range(1,len(file)):
        current += int(file[i][-1])
        file[i].append(str(current) + "\n")
    for a in file:
        dst.write(",".join(a))
    return current
print(calculate_running_total("P4-Prog-SupportFiles\pigeon_counts.csv","events_uniq_output.txt"))