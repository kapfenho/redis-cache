require 'bundler/setup'
require 'sinatra'
require 'redis'
require 'haml'
require 'sass'
require_relative 'customer'

db = Redis.new

get '/' do
  @customers ||= []
  @ct = 0
  haml :index, :format => :html5
end

get '/search' do
  start = Time.now
  @customers = Customer.search(db, params)
  @ct = Time.now - start
  haml :index, :format => :html5
end

