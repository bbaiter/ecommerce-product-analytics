CREATE TABLE IF NOT EXISTS users (
    user_id BIGINT PRIMARY KEY
);

CREATE TABLE IF NOT EXISTS products (
    product_id BIGINT PRIMARY KEY,
    category_id BIGINT,
    category_code VARCHAR(255),
    brand VARCHAR(255)
);

CREATE TABLE IF NOT EXISTS events (
    event_id INTEGER PRIMARY KEY AUTOINCREMENT,
    event_time DATETIME,
    event_type VARCHAR(50),
    user_id BIGINT,
    product_id BIGINT,
    user_session VARCHAR(50),
    price NUMERIC
);

CREATE INDEX IF NOT EXISTS idx_events_user_id ON events(user_id);
CREATE INDEX IF NOT EXISTS idx_events_event_time ON events(event_time);