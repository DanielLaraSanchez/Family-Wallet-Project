require( 'sinatra' )
require( 'sinatra/contrib/all' ) if development?

# require_relative( './models/accounts.rb' )
# # require_relative( '../models/tags.rb' )
# # require_relative( '../models/transactions.rb' )
#
#
# get '/accounts' do
#  @account = Account.all
# erb ( :index )
# end
get '/accounts' do
  "Hello World"
  erb(:index)

end
