hrs = input("Enter Hours: ")
rate = input("Enter Rate: ")
try:
    h = float(hrs)
    r = float(rate)
except:
    print("Error: Please enter a number")
    quit()

if h > 40:
    pay = (40 * r) + ((h - 40) * (r * 1.5))
    print(pay)
else:
    pay = h * r
    print(pay)
