### redis native spooler

class SpoolerNative

  def initialize(fname, nr = 1)
    @fname = fname
    @nr = nr
    @str = ""
  end

  def spool(*cmd)
    @str << "*"+cmd.length.to_s+"\r\n"
    cmd.each{|arg|
      @str << "$"+arg.to_s.bytesize.to_s+"\r\n"
      @str << arg.to_s+"\r\n"
    }
  end

  def flush
    f = File.new(@fname, "w")
    f << @str
    f.close 
  end

end

