# Use the file name mbox-short.txt as the file name
fname = input("Enter file name: ")

fh = ""

try:
    fh = open(fname)
except:
    print("File could not be opened")
    quit()

count = 0
confidence = 0

for line in fh:
    if not line.startswith("X-DSPAM-Confidence:"):
        continue
    line_start = line.rfind(":") + 1
    line_end = len(line)
    confidence_value = float(line[line_start:line_end].strip())
    count = count + 1
    confidence = confidence + confidence_value

print(f"Average spam confidence: {confidence/count}")
