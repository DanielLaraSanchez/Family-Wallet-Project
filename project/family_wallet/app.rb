require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative('./models/accounts')
require_relative('./models/tags')
require_relative('./models/transactions')
require("pry")

also_reload('./controllers/*')
also_reload('./models/*')

get '/index' do
  @accounts = Account.all()
  erb( :index )
end

get '/tags' do
@tags = Tag.all()
  erb( :tags )
end

get '/accounts' do
  @accounts = Account.all()
  erb( :accounts)
end

get '/transactions' do
  @transactions = Transaction.all()
  erb ( :transactions )
end

get '/accounts/new_account' do
erb(:new_account)
end

post '/accounts' do
  account = Account.new( params )
  account.save
  redirect to ("/accounts")
end

get '/transactions/new_transaction' do
  #get all the account and make @accounts
  @accounts = Account.all
  @tags = Tag.all
  erb ( :new_transaction )
end

post '/transactions' do
  # transaction = Transaction.new( params )
  # transaction.save
  #
  # account = Account.find(params["account_id"])
  # account.add_credit( params["quantity"] )

  account = Account.find(params["account_id"])
  account.new_transaction(params)

  redirect to ("/transactions")
end



get '/accounts/:id' do

  @accounts = Account.find( params[:id])
  erb(:show_account)
end



get '/accounts/:id/account_transactions' do
  @accounts = Account.find ( params[:id])
  @transactions = @accounts.transactions()
  erb(:account_transactions)
end

post '/accounts/:id/account_edit' do
  @accounts = Account.find ( params[:id])
  erb(:account_edit)
end

post '/accounts/:id/account_update' do
  @accounts = Account.new( params[:id])
  erb(:account_update)
end

get '/accounts/:id/account_transfer' do
  @account = Account.find(params[:id])
  @accounts = Account.all()

  # @accounts.transfer_credit
  erb(:account_transfer)
end

post '/accounts/:id/account_transfer' do
  # @account = Account.all()
  @account = Account.find( params[:id])
  @account.transfer_credit(params['transfer'], params['reciever_id'])
  redirect to ("/accounts") # make this a redirect
end

post '/accounts/:id/account_delete' do
  @accounts = Account.find( params[:id])
  @accounts.delete()
  redirect to ("/transactions")
end






get '/transactions/:id'  do

  @transactions = Transaction.find( params[:id])
  erb(:show_transaction)
end

post '/transactions/:id/transaction_edit' do
  @transactions = Transaction.find( params[:id])
  erb(:transaction_edit)
end

post '/transactions/:id/transaction_update' do
  @transactions = Transaction.new( params[:id])
  erb(:transaction_update)

end

post '/transactions/:id/transaction_delete' do
  @transactions = Transaction.find( params[:id])
  @transactions.delete()
redirect to ("/transactions")
end





  # post '/bitings' do
  #   biting = Biting.new(params)
  #   biting.save
  #   redirect to("/bitings")
  # end
