require 'sinatra'
require 'sequel'

configure do
  set :database, Sequel.connect(ENV['DATABASE_URL'] || 'sqlite://coffey.db')    
end

$LOAD_PATH.unshift(File.dirname(__FILE__) + '/lib')
require 'post'

get '/' do
  'hi'
end
