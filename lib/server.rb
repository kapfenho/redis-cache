require 'sinatra'
require 'redis'
require_relative 'customer'

db = Redis.new

get '/' do
  @customers ||= []
  erb :index
end

get '/search' do
  @customers = Customer.search(db, params)
  erb :index
end

