from string import ascii_uppercase
import time

start = time.time()



letters = ascii_uppercase

path = r'D:\Python\Pycharm\Repos\Daul\Datasets\p042_words.txt'

with open(path) as file:

    words = [i[1:-1] for i in file.read().split(',')]

print(sum([True if sum([dict(zip(letters, range(1, len(letters) + 1)))[char] for char in word]) in [(i * (i + 1)) // 2 for i in range(1, max([len(word) for word in words]) * 26)] else False for word in words]))

# One line cause I'm ugly
# print(sum([True if sum([dict(zip(letters, range(1, len(letters) + 1)))[char] for char in word]) in [(i * (i + 1)) // 2 for i in range(1, max([len(word) for word in words]) * 26)] else False for word in words]))

max_len = max([len(word) for word in words])

# seq_of_triangles = [(i * (i+1))//2 for i in range(1, max_len*26)]

letters_dict = dict(zip(letters, range(1, len(letters)+1)))

for idx in range(len(words)):
    word_int_sum = 0

    for char in words[idx]:

        word_int_sum += letters_dict[char]
    i = 1
    while (i * (i+1))//2 <= word_int_sum:
        if word_int_sum == i:

            words[idx] = True
        i += 1
    words[idx] = False

print(sum(words))

print(time.time() - start)