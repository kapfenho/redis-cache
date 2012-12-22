##### redis db spooler

class DBSpooler

  def initialize()
    @db = Redis.new
  end

  def spool(*cmd)
    @db.send *cmd
  end

  def flush
  end

end



