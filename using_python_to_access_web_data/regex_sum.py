import re

fname = input("Enter file name: ")
if len(fname) < 1:
    fname = "regex_sum_2079263.txt"
    # fname = "regex_sum_42.txt"

content = ""
overall_total = 0


def sum_array(numbers_list):
    return sum(int(item) for item in numbers_list) if numbers_list else 0


try:
    content = open(fname)
except Exception as e:
    print(e)
    print("File could not be opened.")
    quit()

for line in content:
    numbers_list = re.findall("[0-9]+", line)
    line_total = sum_array(numbers_list)
    overall_total = overall_total + line_total

print(overall_total)
