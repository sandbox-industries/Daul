from math import fsum


avo_data = {}

# Request user to input data for 4 weeks of March
for idx in range(1,5):

    avg_price = input(f'What is the average avocado price from week {idx} in March 2015?')
    num_sold = input(f'How many avocadoes were sold in week {idx} of March 2015?')

    # This fills the initialized dict where {key= week#_price_sold: val= (week_avg_price, week_num_sold)}
    avo_data[f'week{idx}_price_sold'] = (float(f'{float(avg_price):.2f}'), int(num_sold))

total_money = sum([val[0]*val[1] for val in avo_data.values()])
total_sold = sum([val[1] for val in avo_data.values()])
avg_price = f'{(fsum([val[0] for val in avo_data.values()])/4):.2f}'


print('Total Market Size:', total_money)
print("Number of avocados sold:", total_sold)
print('Average avocado price:', avg_price)
print('Full Trucks:', total_sold // 1000000)
print('Remaining avocados:' total_sold % 1000000)
print(total_money)
print(total_sold)
print(avg_price)
print(total_sold // 1000000)
print(total_sold % 1000000)