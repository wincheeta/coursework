a = [26, 55, 68, 35, 94, 39, 98, 86, 50, 78, 40, 50, 104, 75, 71, 85, 16, 26, 19, 19, 20, 27, 87, 22, 92, 24, 7, 69, 6, 12, 3, 10, 93, 3, 18, 81, 22, 89]
b = "Ninety puffs a minute, semi-automatic."
c = [35, 59, 13, 42, 70, 126, 42, 71, 49, 77, 110, 53, 32, 88, 2, 93, 89, 18, 9, 21, 28, 82, 5, 69, 72, 0, 11, 13, 9, 10, 87, 13, 85, 16, 3, 24, 28, 25]

f=0
found = True
while found:
    f-=1
    found = False
    for i in range(len(a)):
        if not ord(b[i])+f in a:
           found = True
    print(f)