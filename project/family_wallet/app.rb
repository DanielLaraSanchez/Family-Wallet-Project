require( 'sinatra' )
require( 'sinatra/contrib/all' )
require_relative('./models/accounts')
require_relative('./models/tags')
require_relative('./models/transactions')

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
  erb ( :new_transaction )
end

post '/transactions' do
  transaction = Transaction.new( params )
  transaction.save
  redirect to ("/transactions")
end

get '/accounts/:id' do

  @accounts = Account.find( params[:id])
  erb(:show_account)
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


  # post '/bitings' do
  #   biting = Biting.new(params)
  #   biting.save
  #   redirect to("/bitings")
  # end
