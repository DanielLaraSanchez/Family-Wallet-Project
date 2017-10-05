require( 'sinatra' )
require( 'sinatra/contrib/all' ) if development?
require_relative( '../models/transactions.rb' )
require_relative( '../models/tags.rb' )
require_relative( '../models/accounts.rb' )
