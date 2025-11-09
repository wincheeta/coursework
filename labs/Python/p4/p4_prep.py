def find_common(f1,f2) -> list[str]:
    try:
        f1 = set(open(f"P4-Prep-SupportFiles\{f1}","r").readlines())
        f2 = set(open(f"P4-Prep-SupportFiles\{f2}","r").readlines())
    except:
        raise ValueError()
    list = []
    for i in f1:
        if i in f2:
            list.append(i.replace("\n",""))
    return list


print(find_common("numbers.txt","oddnumbers.txt"))