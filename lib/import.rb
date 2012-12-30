##### redis-cache.rb
#
# Fill redis cache with data
# Author: horst kapfenberger
#

%w[rubygems redis json logger benchmark].each { |r| require r }
require_relative 'db_spooler'
require_relative 'native_spooler'

class Import

  CKEYS = [:id, :msisdn, :acct, :fn, :ln, :zip]

  def initialize(dest = :db, fname = '')
    @s = NativeSpooler.new(fname) if dest != :db
    @s ||= DBSpooler.new
    @logger = Logger.new(STDERR)
    @logger.level = Logger::INFO
  end

  def import
    i = 0
    @logger.info Benchmark.measure {

      File.open('data/sample.csv', "r").each_line do |l|
        a = l.strip!.gsub(/"/, '').split(',')

        if a.size != 6 
          @logger.error "Invalid data in row #{i}: #{l}"
        else
          h = Hash[CKEYS.zip(a)]
          @s.spool('set' , "cons:#{h[:id]}", h.to_json)
          @s.spool('hset', 'cons:lookup:msisdn', h[:msisdn], h[:id])
          @s.spool('hset', 'cons:lookup:acct', h[:acct], h[:id])
          @s.spool('sadd', "cons:ln:#{h[:ln]}", h[:id])
        end
        i += 1
      end
      @s.flush
    }
  end

end

