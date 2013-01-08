## Rakefile for redis-cache
##

require 'rake/clean'
require_relative 'lib/import.rb'

DEF_IF = "data/sample.csv"
DEF_SFILE = "output/native"
DEF_SAMPLE_SIZE = 100_000

task :default => [:native]

CLEAN.include 'output/*'

directory "output"

desc "Generate sample input data, defaults size => #{DEF_SAMPLE_SIZE}, out = #{DEF_IF}"
task :sample, [:size, :out] do |t, args|
  args.with_defaults(:size => DEF_SAMPLE_SIZE, :out => DEF_IF)
  puts "### Generating and writing #{args.size} sample data rows to #{args.out}"
  ruby "lib/sample.rb #{args.size} #{args.out}"
end

desc "Import the data directly to database, slower than native, defaults in => #{DEF_IF}"
task :import, [:in] do |t, args|
  args.with_defaults(:in => DEF_IF)
  puts "### Directly importing data rows from #{args.in} to database"
  Import.new(:db, args.in).import
  # puts "### Done. You may want to start the UI: >rake server<"
end

desc "Generate native stream file, defaults in => #{DEF_IF}, sfile => #{DEF_SFILE}"
task :native, [:in, :sfile] => ["output"] do |t, args|
  args.with_defaults(:in => DEF_IF, :sfile => DEF_SFILE)
  puts "### Generating native stream file to #{args.sfile}"
  Import.new(:native, args.in, args.sfile).import
  # puts "### Done.  Use >rake stream< to send it to database."
end

desc "Stream native file to database, defaults sfile => #{DEF_SFILE}"
task :stream, [:sfile] do |t, args|
  args.with_defaults(:sfile => DEF_SFILE)
  puts "### Streaming file to database"
  %x[sh 'lib/stream.sh' #{args.sfile}]
  # puts "### Done. You may want to start the UI: >rake server<"
end

desc "Start frontend server"
task :server do
  ruby '-rubygems lib/server.rb'
end

