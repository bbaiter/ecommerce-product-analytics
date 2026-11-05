import sqlite3
import pandas as pd
import glob
import os

conn = sqlite3.connect('../data/ecommerce.db')
sql_files = sorted(glob.glob('../sql/*.sql'))

for file_path in sql_files:
    filename = os.path.basename(file_path)
    if filename == 'schema.sql':
        continue
    with open(file_path, 'r', encoding='utf-8') as f:
        query = f.read()
    df = pd.read_sql(query, conn)
    print(df)

conn.close()