require('pg')
# require_relative('./models/accounts.rb')
# require_relative('./models/tags.rb')
require_relative('../db/sql_runner.rb')

class Transaction
attr_accessor(:tag_id, :account_id, :date_of_transaction, :type, :quantity, :issuer)
attr_reader(:id)
def initialize ( transaction )

@id = transaction['id'].to_i() if transaction['id'].to_i()
@tag_id = transaction['tag_id'].to_i()
@account_id = transaction['account_id'].to_i()
@date_of_transaction = transaction['date_of_transaction']
@type = transaction['type']
@quantity = transaction['quantity']
@issuer = transaction['issuer']


end

def save()
sql = ' INSERT INTO transactions
(tag_id, account_id, date_of_transaction, type, quantity, issuer)
VALUES ($1, $2, $3, $4, $5, $6)
RETURNING *;'
values = [@tag_id, @account_id, @date_of_transaction, @type, @quantity, @issuer]
transaction_data = SqlRunner.run(sql, values)
@id = transaction_data.first['id'].to_i()
end

def delete()
sql = 'DELETE FROM transactions WHERE id = $1'
values = [@id]
transaction_data = SqlRunner.run(sql, values)
end

def update()
sql = 'UPDATE transactions SET (tag_id, account_id, date_of_transaction, type, quantity, issuer)
= ($1, $2, $3, $4, $5, $6) WHERE id = $7'
values = [@tag_id, @account_id, @date_of_transaction, @type, @quantity,  @issuer, @id]
SqlRunner.run(sql, values)
end

def self.find(id)
sql = 'SELECT * FROM transactions WHERE id = $1'
values = [id]
transaction_data = SqlRunner.run(sql, values)
result = Transaction.new(transaction_data.first)
return result
end

def self.all()
sql = 'SELECT * FROM transactions;'
values = []
transaction_data = SqlRunner.run(sql, values)
result = transaction_data.map { |transaction| Transaction.new(transaction)}
return result
end

def transactions_by_tags()
  sql = 'SELECT * FROM tags
  WHERE id = $1'
  values = [@tag_id]
  results = SqlRunner.run(sql, values)
  return Tag.new( results.first )

end

def transactions_by_accounts()
sql = 'SELECT * FROM accounts
WHERE id = $1'
values = [@account_id]
results = SqlRunner.run(sql, values)
return Account.new( results.first )

end









end
