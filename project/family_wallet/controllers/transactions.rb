require( 'sinatra' )
require( 'sinatra/contrib/all' ) if development?
require_relative( '../models/accounts' )
require_relative( '../models/tags' )
require_relative( '../models/transactions' )
