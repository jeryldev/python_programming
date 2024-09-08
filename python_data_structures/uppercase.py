# Use words.txt as the file name
fname = input("Enter file name: ")
fh = ""

try:
    fh = open(fname)
except:
    print("File could not be opened.")
    quit()

for line in fh:
    print(line.upper().rstrip())
