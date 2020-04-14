# A Pythagorean triplet is a set of three natural numbers, a < b < c, for which,
#
# a**2 + b**2 = c**2
# For example, 3**2 + 4**2 = 9 + 16 = 25 = 5**2.
#
# There exists exactly one Pythagorean triplet for which a + b + c = 1000.
# Find the product abc.

def solve(sum_of_sides):
    import time
    start = time.time()
    for a in range(1,sum_of_sides):
        for b in range(a+1,sum_of_sides - a):
            for c in range(b+1,sum_of_sides - (a + b)):
                # Loop through all possible values of a, b, c

                if a ** 2 + b ** 2 == c ** 2 and sum_of_sides % (a + b + c) == 0:
                    # Checks if the sides make a perfect right triangle and
                    # divide into our desired sum (1000) evenly because the desired
                    # right triangle can be a scaled up version of a smaller one

                    quotient = 1000 // (a + b + c)
                    a *= quotient
                    b *= quotient
                    c *= quotient
                    # Find the factor the sides must be scaled up to, to sum up to 1000
                    # and multiply

                    return a * b * c, time.time()-start

print(solve(1000))

# import time
# sum_of_sides = 1000
# start = time.time()
# flag = False
# while flag == False:
#     for a in range(1, sum_of_sides):
#         print(a)
#         for b in range(a + 1, sum_of_sides):
#             for c in range(b + 1, sum_of_sides- (a + b)):
#                 if a ** 2 + b ** 2 == c ** 2 and 1000 % (a + b + c) == 0:  # conditional
#                     div = 1000 // (a + b + c)
#                     a *= div
#                     b *= div
#                     c *= div
#                     print(a * b * c, time.time() - start)
#                     flag = True