name = input("Enter file:")
if len(name) < 1:
    name = "mbox-short.txt"

handle = ""

try:
    handle = open(name)
except:
    print("File could not be opened.")
    quit()


def extract_time(text):
    for word in text.split(" "):
        if len(word) == 8 and word.count(":") == 2:
            hours, minutes, seconds = word.split(":")
            return (int(hours), int(minutes), int(seconds))
    return None


time_dict = dict()

for line in handle:
    if line.startswith("From"):
        time = extract_time(line)
        if time != None:
            hours = time[0]
            if hours in time_dict.keys():
                time_dict[hours] = time_dict[hours] + 1
            else:
                time_dict[hours] = 1

for k, v in sorted(time_dict.items()):
    print(f"{k:02d} {v}")
