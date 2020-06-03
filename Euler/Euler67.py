file = r'D:\Python\Pycharm\Repos\Daul\Datasets\p067_triangle.txt'

def triangle(file):

    with open(file, 'r') as triangle:

        triangle = [line.strip('\n').split(' ') for line in triangle]
        for line in triangle:
            for num in line:
                int(num)
        print(triangle)
        # for num in triangle:
        #     num = int(num)
        return tree
print(triangle(file))
# def solve(triangle, idx):


class Node:
    def __init__(self, value, parent_l, parent_r): # , child_l, child_r):
        self.value = value
        self.parent_l = None
        self.parent_r = None
        # self.child_l = None
        # self.child_r = None
        self.sum = None
        self.root = None

    def getvalue(self):
        return Node.value

    def getparentl(self):
        return Node.parent_l

    def getparentr(self):
        return Node.parent_r

    # def getchildl(self):
    #     return Node.child_l
    #
    # def getchildr(self):
    #     return Node.child_r

    def getroot(self):
        return Node.root

    def setvalue(self):
        Node.value = value

    def setparentl(self, parentl):
        Node.parent_l = parentl

    def setparentr(self, parentr):
        Node.parent_r = parentr

    # def setchildl(self, childl):
    #     Node.child_l = childl
    #
    # def setchildr(self, childr):
    #     Node.child_r = childr

    def setroot(self, root):
        Node.root = root

def solve(tree):
    for line, idx in enumerate(tree):
        if len(line) == 0:
            Node.setroot(line[0])
        if



solve(tree)