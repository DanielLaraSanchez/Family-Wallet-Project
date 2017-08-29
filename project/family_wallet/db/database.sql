
DROP DATABASE accounts;
DROP DATABASE transactions;
DROP DATABASE tags;




 CREATE TABLE tags (
 id SERIAL PRIMARY KEY,
 type VARCHAR(255),
 color VARCHAR(255)
 );



  CREATE TABLE accounts (
  id SERIAL PRIMARY KEY,
  holder_name VARCHAR(255),
  holder_last_name VARCHAR(255),
  account_number BIGINT,
  type VARCHAR(255),
  credit FLOAT(53)
  );


  CREATE TABLE transactions (
  id SERIAL PRIMARY KEY,
  tag_id INT REFERENCES tags(id) ON DELETE CASCADE,
  account_id INT REFERENCES accounts(id) ON DELETE CASCADE,
  date_of_transaction DATE DEFAULT CURRENT_DATE,
  type VARCHAR(255),
  quantity FLOAT(53),
  issuer VARCHAR(255)
  );
