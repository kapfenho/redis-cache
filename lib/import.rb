##### redis-cache.rb
#
# Fill redis cache with data
# Author: horst kapfenberger
#

# %w[rubygems redis json logger].each { |r| require r }
%w[redis json logger].each { |r| require r }
require_relative 'spooler_native'
require_relative 'spooler_db'
require_relative 'customer'

class Import

  # CKEYS = [:id, :msisdn, :acct, :fn, :ln, :zip]

  def initialize(dest = :db, fname = '')
    @s = SpoolerNative.new(fname) if dest != :db
    @s ||= SpoolerDB.new
    @logger = Logger.new(STDERR)
    @logger.level = Logger::INFO
  end

  def import
    i = 0
    File.open('data/sample.csv', "r").each_line do |l|
      a = l.strip!.gsub(/"/, '').split(';')
      c = Customer.new(a)

      if a.size != 6 
        @logger.error "Invalid data in row #{i}: #{l}"
      else
        # h = Hash[CKEYS.zip(a)]
        @s.spool('set' , "cons:#{c.id}", c.to_json)
        @s.spool('hset', 'cons:lookup:msisdn', c.msisdn, c.id)
        @s.spool('hset', 'cons:lookup:acct', c.acct, c.id)
        @s.spool('sadd', "cons:ln:#{c.ln}", c.id)
      end
      i += 1
    end
    @s.flush
  end

end

