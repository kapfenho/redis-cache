require 'sinatra'
require 'redis'
require 'haml'
require 'sass'
require_relative 'customer'

db = Redis.new

get '/' do
  @customers ||= []
  haml :index, :format => :html5
end

get '/search' do
  @customers = Customer.search(db, params)
  puts @customers.inspect
  haml :index, :format => :html5
end

get '/style.css' do
  scss :style
end

