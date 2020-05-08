# def grid(x,y):
#
#
#     grid = [[0 for i in range(x+1)] for i in range(y+1)]
#     return x, y
# gx, y = grid(20,20)
x = 20
y = 20
num = 1
# num = sum([i for i in range(1, x+1)]) * y + 1
# print(num)
for i in range(21,41):
    num *= i
anum = 1
for i in range(1,21):
    anum *= i
print(num/anum)
