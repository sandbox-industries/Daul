from string import ascii_uppercase

file = 'D:\Python\Pycharm\Repos\Daul\Datasets\p022_names.txt'
letters = ascii_uppercase

# Read in file and turn the line of text in to a list of strings
with open(file, 'rt') as file:

    line = file.read()

    names = sorted([i[1:-1] for i in line.split(",")])

# key is an upper-case letter || value is int 1-26 {'A': 1, 'B': 2, ...}
letters_dict = dict(zip(letters, range(1, len(letters)+1)))


for i in range(len(names)):
    name_int = 0
    for char in names[i]:
        name_int += letters_dict[char]
    names[i] = name_int

# key is and int 1-... || value is the sum of the translated characters
names_dict = dict(zip(range(1, len(names)+1), names))

total = sum([key*val for key, val in names_dict.items()])

print(total)
