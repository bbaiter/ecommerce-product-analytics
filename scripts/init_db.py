import sqlite3
import os

SCRIPT_DIR = os.path.dirname(os.path.abspath(__file__))
BASE_DIR = os.path.dirname(SCRIPT_DIR)

DB_PATH = os.path.join(BASE_DIR, 'data', 'ecommerce.db')
SQL_PATH = os.path.join(BASE_DIR, 'sql', 'schema.sql')

os.makedirs(os.path.dirname(DB_PATH), exist_ok=True)

conn = sqlite3.connect(DB_PATH)

with open(SQL_PATH, 'r', encoding='utf-8') as f:
    schema_sql = f.read()

conn.executescript(schema_sql)
conn.commit()
conn.close()

print(f"База данных создана по пути: {DB_PATH}")