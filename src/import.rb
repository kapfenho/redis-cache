##### redis-cache.rb
#
# Fill redis cache with data
#
# Author: horst kapfenberger
#

%w[rubygems redis json logger benchmark].each { |r| require r }
require_relative 'gen_redis_proto'

ckeys = [:id, :msisdn, :acct, :fn, :ln, :zip]
i = 0
mode = :file  # :db
out = ""

logger = Logger.new(STDERR)
logger.level = Logger::INFO

logger.info Benchmark.measure {

  db = Redis.new
  File.open('data/fullset-cons.csv', "r").each_line do |l|
    a = l.strip!.gsub(/"/, '').split(',')

    if a.size != 6 
      logger.error "Invalid data in row #{i}: #{l}"
    else
      h = Hash[ckeys.zip(a)]
      if mode == :file
        out << gen_redis_proto('SET', "cons:#{h[:id]}", h.to_json)
        out << gen_redis_proto('HSET', 'cons:lookup:msisdn', h[:msisdn], h[:id])
        out << gen_redis_proto('HSET', 'cons:lookup:acct', h[:acct], h[:id])
        out << gen_redis_proto('SADD',  "cons:ln:#{h[:ln]}", h[:id])
      else
        db.set "cons:#{h[:id]}", h.to_json
        db.hset 'cons:lookup:msisdn', h[:msisdn], h[:id]
        db.hset 'cons:lookup:acct', h[:acct], h[:id]
        db.sadd "cons:ln:#{h[:ln]}", h[:id]
      end
    end
    i += 1

  end
  puts out

}

