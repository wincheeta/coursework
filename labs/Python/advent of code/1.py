file = [i.strip("\n").split("   ") for i in open("1.txt","r").readlines()]

a = []
b = []
for i in file:
    a.append(i[0])
    b.append(i[1])
    
a.sort(); b.sort()

sum = 0
for i in range(len(a)):
    #sum+= abs(int(a[i])-int(b[i]))
    
    sum += int(a[i]) * b.count(a[i])
    
print(sum)