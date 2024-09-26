import requests
import re

# url = "http://py4e-data.dr-chuck.net/regex_sum_42.txt"
url = "http://py4e-data.dr-chuck.net/regex_sum_2079263.txt"
content = ""
overall_total = 0

try:
    response = requests.get(url)
    if response.status_code == 200:
        content = response.text.split("\n")
    else:
        print(f"Failed to retrieve content. Status code: {response.status_code}")
except Exception as e:
    print(e)
    print("File could not be opened.")
    quit()


def sum_array(numbers_list):
    return sum(int(item) for item in numbers_list) if numbers_list else 0


for line in content:
    numbers_list = re.findall("[0-9]+", line)
    line_total = sum_array(numbers_list)
    overall_total = overall_total + line_total

print(overall_total)
