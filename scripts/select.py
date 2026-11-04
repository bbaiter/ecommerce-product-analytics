import sqlite3
import pandas as pd
import os

#пути
BASE_DIR = os.path.dirname(os.path.dirname(os.path.abspath(__file__)))
DB_PATH = os.path.join(BASE_DIR, 'data', 'ecommerce.db')
SQL_PATH = os.path.join(BASE_DIR, 'sql', 'test_query.sql')

conn = sqlite3.connect(DB_PATH)

with open(SQL_PATH, 'r', encoding='utf-8') as file:
    query = file.read()

df = pd.read_sql(query, conn)
print(df)

conn.close()