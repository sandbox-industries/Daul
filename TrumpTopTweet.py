import pandas as pd
import re
trumpTweets = r"D:\Python\Pycharm\Repos\Daul\Datasets\trumptweets\trumptweets.csv"
df_Tweets = pd.read_csv(trumpTweets)
uniques = set()
print(df_Tweets['content'])
df_Tweets['content'].str.lower().str.split().apply(uniques.update)
print(df_Tweets['content'].str.lower().str.split())
print(uniques)
print(len(uniques))

word_count = {}
# pd_Tweets['content'].str.lower().str.split().apply(
df_Tweets['content'].str.lower().str.split()