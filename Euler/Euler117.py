tiles = []
max_row_size = 5
combos = 0
tile_sizes = [1, 2, 3, 4]

while sum(tiles) != max_row_size:

    tiles = []

    space = max_row_size - sum(tiles)

    for size in sorted(tile_sizes, reverse=True):
        if size <= space:
            tiles.append(size)

        tiles.append()

    combos += 1

for i in range(max_row_size):
    tiles.append(1)
