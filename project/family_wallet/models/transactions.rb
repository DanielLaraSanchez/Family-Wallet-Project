require('pg')
# require_relative('./models/accounts.rb')
require_relative('./tags.rb')
require_relative('../db/sql_runner.rb')

class Transaction
attr_accessor(:tag_id, :account_id, :date_of_transaction, :type, :quantity, :issuer)
attr_reader(:id)
def initialize ( transaction )

@id = transaction['id'].to_i()
@tag_id = transaction['tag_id'].to_i()
@account_id = transaction['account_id'].to_i()
@date_of_transaction = transaction['date_of_transaction']
@type = transaction['type']
@quantity = transaction['quantity'].to_f
@issuer = transaction['issuer']


end

def save()
sql = ' INSERT INTO transactions
(tag_id, account_id, type, quantity, issuer)
VALUES ($1, $2, $3, $4, $5)
RETURNING *;'
values = [@tag_id, @account_id, @type, @quantity, @issuer]
transaction_data = SqlRunner.run(sql, values)
@id = transaction_data.first['id'].to_i()
end

def delete()
sql = 'DELETE FROM transactions WHERE id = $1'
values = [@id]
transaction_data = SqlRunner.run(sql, values)
end

def self.delete_all() #why does it not have * and no values?
  sql = "DELETE FROM transactions"
  values = []
  SqlRunner.run( sql, values )
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

def self.transactions_by_tags(tag_id)#why do you
  sql = 'SELECT * FROM transactions
  WHERE tag_id = $1'
  values = [tag_id]
  results = SqlRunner.run(sql, values)
  tags_transaction = results.map { |tags_hash| Transaction.new(tags_hash)}
  return tags_transaction

end

# def transactions()
#   sql = "SELECT * FROM transactions WHERE account_id = $1;"
#   values = [@id]
#   result = SqlRunner.run(sql, values)
#   account_transactions = result.map {|transaction_hash| Transaction.new(transaction_hash)}
#   return account_transactions
# end

def transactions_by_accounts()
sql = 'SELECT * FROM accounts
WHERE id = $1'
values = [@account_id]
results = SqlRunner.run(sql, values)
return Account.new( results.first )

end

def self.transactions_by_date(number_of_days)
sql = "SELECT * FROM transactions
WHERE date_of_transaction > current_date - interval '#{number_of_days} day'"
values = []
transaction_data = SqlRunner.run(sql, values)
results = transaction_data.map { |transaction| Transaction.new(transaction) }
return results
end



def self.sum_transactions_amount()
# sql = 'SELECT SUM(quantity) AS total FROM transactions;'
# values = []
# result = SqlRunner.run(sql, values)[0]["total"].to_f()
  total = 0
  transactions = Transaction.all
  for transaction in transactions
    if transaction.type == 'Income'
      total += transaction.quantity
    else
      total -= transaction.quantity
    end
  end

  return total
end









end
