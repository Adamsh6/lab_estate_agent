DROP TABLE IF EXISTS properties;

CREATE TABLE properties (
  id SERIAL8 PRIMARY KEY,
  address VARCHAR(255),
  value INT,
  bedroom_num INT2,
  buy_let VARCHAR(255)

);
