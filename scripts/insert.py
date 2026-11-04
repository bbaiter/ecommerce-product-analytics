import pandas as pd
import sqlite3
import glob
import os

SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
BASE_DIR = os.path.dirname(SCRIPT_DIR)

DB_PATH = os.path.join(BASE_DIR, 'data', 'ecommerce.db')
CSV_PATTERN = os.path.join(BASE_DIR, 'data', '*.csv')
#CSV_PATTERN = os.path.join(BASE_DIR, 'data', 'test_sample.csv')
conn = sqlite3.connect(DB_PATH)
cursor = conn.cursor()

#ускорение вставки
cursor.execute("PRAGMA synchronous = OFF")
cursor.execute("PRAGMA journal_mode = MEMORY")

#список путей к файлам
csv_files = glob.glob(CSV_PATTERN)
CHUNK_SIZE = 200_000

for file_path in csv_files:
    print(f"Обработка: {os.path.basename(file_path)}")
    
    for chunk in pd.read_csv(file_path, chunksize=CHUNK_SIZE):
        #Nan -> none
        chunk = chunk.where(pd.notnull(chunk), None)
        
        users = chunk[['user_id']].drop_duplicates()
        cursor.executemany(
            "INSERT OR IGNORE INTO users (user_id) VALUES (?)", 
            users.values.tolist()
        )
        
        products = chunk[['product_id', 'category_id', 'category_code', 'brand']].drop_duplicates('product_id')
        cursor.executemany(
            "INSERT OR IGNORE INTO products (product_id, category_id, category_code, brand) VALUES (?, ?, ?, ?)", 
            products.values.tolist()
        )
        
        events = chunk[['event_time', 'event_type', 'user_id', 'product_id', 'user_session', 'price']]
        cursor.executemany(
            "INSERT INTO events (event_time, event_type, user_id, product_id, user_session, price) VALUES (?, ?, ?, ?, ?, ?)", 
            events.values.tolist()
        )
        
        conn.commit()

conn.close()
print("Загрузка завершена.")