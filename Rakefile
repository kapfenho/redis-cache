## Rakefile for redis-cache
##

require 'rake/clean'
require_relative 'lib/import.rb'

task :default => [:native]

CLEAN.include 'output/*'

desc "Import the data directly to database, slower than native"
task :import do
  a = Import.new(:db)
  a.import
end

desc "Generate the native stream file with data"
task :native do
  Import.new(:native, 'output/native').import
end

desc "Generate sample input with random data"
task :sample do
  ruby 'lib/sample.rb data/sample.csv'
end

desc "Stream native file to database"
task :stream do
  %x[sh 'lib/stream.sh' 'output/native']
end


