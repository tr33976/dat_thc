import pandas as pd
import os

path = "/Users/tyler/Documents/astrafy-thc/"
os.chdir(path)

orders = pd.read_csv('./data/orderscsv.csv')
sales = pd.read_csv('./data/salescsv.csv')

for i in [orders, sales]:
    print(i.info())
    print(i.describe())

