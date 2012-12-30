## Rakefile for redis-cache
##

require 'rake/clean'
require_relative 'lib/import.rb'

task :default => [:import]

desc "Import the data directly to database, slower than native"
task :import do
  a = Import.new(:db)
  a.import
end

CLEAN.include "output/*"

desc "Generate the native stream file with data"
task :native do
  a = Import.new(:native, 'output/spool.redis')
  a.import
end

desc "Generate sample input with random data"
task :sample do
  ruby 'lib/sample.rb'
end

desc "Stream native file to database"
task :stream do
  # todo: pv output/spool.redis | redis-cli --pipe 
end


