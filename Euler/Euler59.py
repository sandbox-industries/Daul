from string import ascii_lowercase

path = r'D:\Python\Pycharm\Repos\Daul\Datasets\p059_cipher.txt'
with open(path) as file:
    cipher = [int(i) for i in file.readline().split(',')]



print(cipher)
# print([chr(i) for i in cipher])


key_length = 3


for i in ascii_lowercase:
    for j in ascii_lowercase:
        for k in ascii_lowercase:
            decrypted = []
            for idx in range(0, len(cipher), key_length):
                decrypted.append(cipher[idx] ^ ord(i))
                decrypted.append(cipher[idx+1] ^ ord(j))
                decrypted.append(cipher[idx+2] ^ ord(k))
            print(decrypted)
                # if
print(cipher)