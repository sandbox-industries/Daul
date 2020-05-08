# Su Doku (Japanese meaning number place) is the name given to a popular puzzle concept.
# Its origin is unclear, but credit must be attributed to Leonhard Euler who invented a similar,
# and much more difficult, puzzle idea called Latin Squares. The objective of Su Doku puzzles,
# however, is to replace the blanks (or zeros) in a 9 by 9 grid in such that each row, column,
# and 3 by 3 box contains each of the digits 1 to 9. Below is an example of a typical starting
# puzzle grid and its solution grid.
#
# A well constructed Su Doku puzzle has a unique solution and can be solved by logic,
# although it may be necessary to employ "guess and test" methods in order to eliminate
# options (there is much contested opinion over this). The complexity of the search determines
# the difficulty of the puzzle; the example above is considered easy because it can be
# solved by straight forward direct deduction.
#
# The 6K text file, sudoku.txt (right click and 'Save Link/Target As...'),
# contains fifty different Su Doku puzzles ranging in difficulty, but all with unique
# solutions (the first puzzle in the file is the example above).
#
# By solving all fifty puzzles find the sum of the 3-digit numbers found in the
# top left corner of each solution grid; for example, 483 is the 3-digit number
# found in the top left corner of the solution grid above.

puzzles = r'D:\Python\Pycharm\Repos\Daul\Datasets\p096_sudoku.txt'


def sudoku(file):
    #               Puzzle Format Example
    #    X  0    1    2    3    4    5    6    7    8
    #  Y
    #  0 [['6', '0', '8', '0', '7', '0', '5', '0', '2'],
    #  1  ['0', '5', '0', '6', '0', '8', '0', '7', '0'],
    #  2  ['0', '0', '2', '0', '0', '0', '3', '0', '0'],
    #  3  ['5', '0', '0', '0', '9', '0', '0', '0', '6'],
    #  4  ['0', '4', '0', '3', '0', '2', '0', '5', '0'],
    #  5  ['8', '0', '0', '0', '5', '0', '0', '0', '3'],
    #  6  ['0', '0', '5', '0', '0', '0', '2', '0', '0'],
    #  7  ['0', '1', '0', '7', '0', '4', '0', '9', '0'],
    #  8  ['4', '0', '9', '0', '6', '0', '7', '0', '1']]
    sudoku = []
    # print(len(sudoku))

    with open(file, 'rt') as puzzles:

        #
        for line in puzzles:
            line = line.strip('\n')

            # See if line in file belongs to a puzzle
            try:

                int(line)
                sudoku.append([char for char in line])

                if len(sudoku) == 9:
                    solve(sudoku)
                    sudoku = []

            except ValueError:
                continue

def poss(pos_x, pos_y, sudoku):


    for i in range(1, 10):
        num = str(i)

        # If the number is in the row, column, or 9 piece block skip it.
        if num in sudoku[pos_y]:

            if num in [pos_y[pos_x] for pos_y in sudoku]:

                if num in [i[x // 3: x // 3 * 3 + 2] for i in sudoku[y // 3: y // 3 * 3 + 2]]:

                    pass
                    print(sudoku)
                    sudoku[y][x] = num
                    solve(sudoku)


def solve(sudoku):

    for row in sudoku:

        if '0' in row:
            y = sudoku.index(row)
            x = row.index('0')

            sudoku[y][x] = poss(x, y)

            

            return sudoku




print(sudoku(puzzles))

