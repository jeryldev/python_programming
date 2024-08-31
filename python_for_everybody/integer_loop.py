largest = None
smallest = None
while True:
    num = input("Enter a number: ")
    if num == "done":
        print(f"Maximum is {largest}")
        print(f"Minimum is {smallest}")
        break

    try:
        int_num = int(num)
    except:
        print("Invalid input")
        continue

    if largest is None:
        largest = int_num
    elif smallest is None:
        smallest = int_num
    else:
        if largest < int_num:
            largest = int_num
        elif smallest > int_num:
            smallest = int_num
        else:
            continue
