#!/usr/bin/env python3

import subprocess
import sys
import traceback

def run_program_test():
    march_avg_prices = [1.06, 1.02, 1.03, 1.07]
    march_sale_count = [31500669, 32046402, 33091256, 30894158]

    interlaced = list()
    for index in range(len(march_avg_prices)):
        interlaced.append(march_avg_prices[index])
        interlaced.append(march_sale_count[index])

    prog_input = "\n".join(str(val) for val in interlaced) + "\n"

    try:
        run_result = subprocess.run([sys.executable, "project_0.py"],
                input=prog_input.encode(), capture_output=True, timeout=10)
    except Exception:
        traceback.print_exc(file=sys.stdout)

    run_output = run_result.stdout.decode()
    print("Program output:")
    print(run_output)

    expected_market_size = 0
    for index in range(len(march_avg_prices)):
        expected_market_size += march_avg_prices[index] * \
                march_sale_count[index]
    expected_num_sold = sum(march_sale_count)
    expected_avg_price = expected_market_size / expected_num_sold
    expected_full_trucks = expected_num_sold // 1000000
    expected_remainder = expected_num_sold % 1000000

    expected_outs = [
            str(round(expected_market_size, 2)),
            str(round(expected_num_sold, 2)),
            str(round(expected_avg_price, 2)),
            str(int(expected_full_trucks)), str(int(expected_remainder))
        ]

    expected_out_names = [
            "market size", "number of avocadoes sold",
            "average avocado price", "full truck count",
            "last truck count"
        ]

    expected_in_14_days = "22.74"
    expected_in_60_days = "652530.45"
    expected_days_to_1000 = "30.96"
    expected_days_to_2000 = "34.06"
    expected_days_to_1mil = "61.91"

    expected_stretch = [expected_in_14_days, expected_in_60_days,
            expected_days_to_1000, expected_days_to_2000,
            expected_days_to_1mil]

    # Check for regular expected outputs
    for out, name in zip(expected_outs, expected_out_names):
        found_it = "FOUND!" if out in run_output else "not found :-("

        print("Looking for {}:".format(name))
        print("\tExpected: {}".format(out))
        print("\tWas value found in your program output? {}".format(found_it))

    # Check for stretch output
    if all(out in run_output for out in expected_stretch):
        print("All stretch outputs were found in your result!  NICE!")
    else:
        print("Not all expected stretch outputs were found...")

if __name__ == "__main__":
    run_program_test()
