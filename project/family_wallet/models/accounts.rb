require('pg')
require_relative('../db/sql_runner.rb')
require_relative('./transactions.rb')


class Account
  attr_accessor(:holder_name, :holder_last_name, :account_number, :type)
  attr_reader(:id)

  def initialize ( account )
    @id = account['id'].to_i() if account['id'].to_i()
    @holder_name = account['holder_name']
    @holder_last_name = account['holder_last_name']
    @account_number = account['account_number'].to_i()
    @type = account['type']
    @credit = 0

  end


  def save()
    sql = ' INSERT INTO accounts
    (holder_name, holder_last_name, account_number, type)
    VALUES ($1, $2, $3, $4)
    RETURNING *;'
    values = [@holder_name, @holder_last_name, @account_number, @type]
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

  def update()
    sql = 'UPDATE accounts SET (holder_name, holder_last_name, account_number, type)
    = ($1, $2, $3, $4) WHERE id = $5'
    values = [@id]
    SqlRunner.run(sql, values)
  end

  def add_credit


  end
  #
  # def check_credit_all_accounts()
  #
  # end
  #
  # def check_spenses_all_accounts

end
