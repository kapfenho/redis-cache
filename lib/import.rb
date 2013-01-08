%w[bundler/setup redis json logger].each    { |r| require r }
%w[spooler_native spooler_db customer].each { |r| require_relative r }

class Import

  def initialize(dest, in_file, sfile = '')
    @s = case dest
         when :db then SpoolerDB.new
         else          SpoolerNative.new(sfile)
         end
    @in_file = in_file
    @logger = Logger.new(STDERR)
    @logger.level = Logger::INFO
  end

  def import
    i = 0
    File.open(@in_file, 'r').each_line do |l|
      a = l.strip!.gsub(/"/, '').split(';')
      c = Customer.new(a)

      if a.size != 6 
        @logger.error "Invalid data in row #{i}: #{l}"
      else
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

