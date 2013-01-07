require 'sinatra'
require 'redis'

# class Customer
#   def self.search(params)
#     if p[:msisdn]
      
# end

db = Redis.new

get '/' do
  erb :index
end

get '/search' do
  # params[:fname]
  # @customers = Customer.search(params)
  id = db.hget 'cons:lookup:msisdn', p[:msisdn]
  cust = db.get "cons:#{id}"
  erb :index
end

