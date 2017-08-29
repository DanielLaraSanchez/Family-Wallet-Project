require('pg')
require_relative('../db/sql_runner.rb')
require_relative('./transactions.rb')
require("pry")


class Account
  attr_accessor(:holder_name, :holder_last_name, :account_number, :type, :credit)
  attr_reader(:id)

  def initialize ( account )
    @id = account['id'].to_i() if account['id'].to_i()
    @holder_name = account['holder_name']
    @holder_last_name = account['holder_last_name']
    @account_number = account['account_number'].to_i()
    @type = account['type']
    if account['credit']
      @credit = account['credit'].to_i()
    else
      @credit = 0
    end

  end



  def save()
    sql = ' INSERT INTO accounts
    (holder_name, holder_last_name, account_number, type, credit)
    VALUES ($1, $2, $3, $4, $5)
    RETURNING *;'
    values = [@holder_name, @holder_last_name, @account_number, @type, @credit]
    account_data = SqlRunner.run(sql, values)
    @id = account_data.first['id'].to_i()
  end

  def self.all()
  sql = 'SELECT * FROM accounts;'
  values = []
  account_data = SqlRunner.run(sql, values)
  result = account_data.map { |account| Account.new(account)}
  return result
  end



  def self.find(id)
  sql = 'SELECT * FROM accounts WHERE id = $1'
  values = [id]
  account_data = SqlRunner.run(sql, values)
  result = Account.new(account_data.first)
  return result
  end

  def delete()
    sql = 'DELETE FROM accounts WHERE id = $1'
    values = [@id]
    account_data = SqlRunner.run(sql, values)
  end

  def self.delete_all() #why does it not have * and no values?
    sql = "DELETE FROM accounts"
    values = []
    SqlRunner.run( sql, values )
  end

  def update()
    sql = 'UPDATE accounts SET (holder_name, holder_last_name, account_number, type, credit)
    = ($1, $2, $3, $4, $5) WHERE id = $6'
    values = [@holder_name, @holder_last_name, @account_number, @type, @credit, @id]
    SqlRunner.run(sql, values)
  end

  def transactions()
    sql = "SELECT * FROM transactions WHERE account_id = $1;"
    values = [@id]
    result = SqlRunner.run(sql, values)
    account_transactions = result.map {|transaction_hash| Transaction.new(transaction_hash)}
    return account_transactions
  end

  def sum_transactions()

    total = 0
    transactions = self.transactions()
    for transaction in transactions
      if transaction.type == 'Income'
        total += transaction.quantity
      else
        total -= transaction.quantity
      end
    end

    return total
  end

  # def update_credit()
  #   credit = self.sum_transactions()
  #   @credit = credit
  #
  #   self.update()
  # end

  def add_credit(transaction)
   if transaction.type == 'Expense'
     @credit -= transaction.quantity.to_f
   else
     @credit += transaction.quantity.to_f
   end
    self.update()

  end

  def self.credit()

    total = 0

    accounts = Account.all
    for account in accounts
      total += account.credit
    end

    return total


  end



  def transfer_credit( transfer, reciever_id)
    tag = Tag.new({'type' => 'Transfer', 'color' => 'yellow'})
    tag.save
    reciever_account = Account.find(reciever_id)
    self.new_transaction({
    'tag_id' => tag.id,
    'account_id' => @id,
    'type' => 'Expense',
    'quantity' => transfer,
    'issuer' => reciever_account.holder_name
    })

    reciever_account.new_transaction({
      'tag_id' => tag.id,
      'account_id' => reciever_account.id,
      'type' => 'Income',
      'quantity' => transfer,
      'issuer' => @holder_name
      })

    end





  def self.sum_transactions_amount()

    total = 0
    accounts = Transaction.all
    for account in accounts
      if transaction.type == 'Income'
        total += transaction.quantity
      else
        total -= transaction.quantity
      end
    end

    return total
  end

  def new_transaction(transaction_details)
    transaction = Transaction.new(transaction_details)
    transaction.save
    self.add_credit(transaction)
  end




end
