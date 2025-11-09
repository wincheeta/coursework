a = "(9971281982620107047517255007210168226664"
b = "c81e728d9d4c2f636f067f89cc14862c"
for j in range(26):
    out = ""
    for i in b:
        out += chr(ord(i)-j)
    print(out)
