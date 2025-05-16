# msg = "123//345//678"

# x = len(msg.strip().split("//"))

import string

data_string = "123//234//567//890//999"  # your input string
numbers = [int(num) for num in data_string.split('//') if num.strip() != '']

# Generate dictionary with dynamic keys from alphabet
keys = list(string.ascii_lowercase)  # ['a', 'b', 'c', ..., 'z']

data = {}
for i, num in enumerate(numbers):
    if i < len(keys):  # make sure we don't run out of letters
        data[keys[i]] = [num]
    else:
        # fallback key naming like a1, a2... if more than 26 items
        data[f'key{i}'] = [num]

print(data)
