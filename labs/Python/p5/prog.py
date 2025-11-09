def divide_numbers(numerator, divisor) -> float:
    if divisor == 0:
        print("Cannot divide by zero. Please provide a non-zero divisor.")
        raise ValueError
    result = numerator / divisor
    return result

import math

def find_square_root(x):
    if type(x) not in (int,float):
        raise ValueError("Input is not a number.")
    elif x < 0:
        raise ValueError("Cannot compute square root of negative numbers.")
    return math.sqrt(x)

def create_alias() -> (int, str):
    alias = input("")
    err = 0
    if alias == "":
        print("An alias cannot be the empty string")
        err += 1
    if alias[0].isdigit():
        print("An alias cannot start with a digit")
        err += 2
    if len(alias) > 8:
        print("An alias cannot be longer than 8 characters")
        err += 4
    if " " in alias:
        print("An alias cannot contain spaces")
        err += 8
    if err:
        alias = ""

    return (err,alias)
    
def bad_half_xfail(number: int) -> bool:
    if number <= 1:
        return False
    for i in range(2, int(number**0.5)):
        if number % i == 0:
            return False
    return True

def bad_one_xfail(number: int) -> bool:
    if number < 1:
        return False
    for i in range(2, int(number**0.5) + 1):
        if number % i == 0:
            return False
    return True

for i in range(25):
    print(i,bad_one_xfail(i))