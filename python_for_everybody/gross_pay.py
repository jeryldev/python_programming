def computepay(h, r):
    if h > 40:
        return (40 * r) + ((h - 40) * (r * 1.5))
    else:
        return h * r


hrs = input("Enter Hours: ")
rate = input("Enter Rate: ")

try:
    h = float(hrs)
    r = float(rate)
except:
    print("Error: Please enter a number")
    quit()

p = computepay(h, r)
print("Pay", p)
