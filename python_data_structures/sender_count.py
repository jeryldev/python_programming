name = input("Enter file:")
if len(name) < 1:
    name = "mbox-short.txt"

handle = ""

try:
    handle = open(name)
except:
    print("File could not be opened.")
    quit()

senders_dictionary = dict()

for line in handle:
    if line.startswith("From "):
        email = line.rstrip().split()[1]
        if email in senders_dictionary.keys():
            senders_dictionary[email] = senders_dictionary.get(email) + 1
        else:
            senders_dictionary[email] = 1

email_max = max(senders_dictionary, key=senders_dictionary.get, default=None)

print(f"{email_max} {senders_dictionary[email_max]}")
