fname = input("Enter file name: ")
fh = open(fname)
lst = list()
for line in fh:
    for word in line.rstrip().split():
        if word in lst:
            continue
        lst.append(word)

print(sorted(lst))
