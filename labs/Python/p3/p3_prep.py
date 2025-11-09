ragged_list = [[5], [6, 7, 8,6]]

def flatten_ragged_list(ragged_list):
    list = []
    for i  in ragged_list:
        for j  in i:
            list.append(j)
    return list

def access_element(ragged_list, i, j) -> tuple[int, int]:
    if ragged_list == None:
        return (3, 0)

    try:
        ragged_list[i]
        try:
            ragged_list[i][j]
            return (0, ragged_list[i][j])
        except:
            return (2, 0)
    except:
        return (1, 0)

def calculate_statistics(ragged_list):
    list = flatten_ragged_list(ragged_list)
    num = len(list)
    sum = 0
    big = 0
    for i in list:
        sum += i
    avg = sum/num

from datetime import datetime, timedelta
#
# now = datetime.now()
# print("The time now is", now.hour, ":", now.minute)
# print("The current year is", now.year)
#
# # default format (no format specified)
# print(f'{now}')
#
# # Friendly format
# print(f'{now:%B %d, %Y, %H:%M}')
#
# # ISO 8601 date-only format
# print(f'{now:%Y-%m-%d}')
#
# # 12-hour clock
# print(f'{now:%I:%M %p}')

now = datetime.now()

# subtract 2 hours from now
date = now - timedelta(hours = 2)

# find the difference between the two datetime objects
delta = now - date
seconds = delta.total_seconds()

print(f'{date:%B %d, %Y, %H:%M:%S}')
print(f'Difference of {seconds} seconds')

print(type(timedelta(seconds=1)+ now))