

num_names = int(input('What is the number of names wanted on the list?'))
max_len = 0
names = []


for i in range(1, num_names+1):

    name = input(f"Please enter name number {i}. ").capitalize()
    while name.isalpha() == False:
        name = input(f"Silly you, names don't have integers. Please enter name number {i}. ").capitalize()
    names.append(name)

    if len(name) > max_len:

        max_len = len(name)

names.sort()

# Creates index for the characters in the name strings.
# max_len is the length of the largest name.

for i in range(max_len):

    line = ''

    # Creates index for which name string in names list we are referencing
    for x in range(num_names):

        # Checks if name is shorter than our current index to avoid indexing errors
        if len(names[x]) >= i+1:

            # Adds the character and 3 spaces to the line
            line += names[x][i] + ' '*3

        else:
            # Adds 4 spaces
            line += ' '*4

    print(line)