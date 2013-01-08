require 'json'

class Customer

  CKEYS = [:id, :msisdn, :acct, :fn, :ln, :zip]

  CKEYS.each do |a|
    # to check, symbols?
    # define_method(a.to_s) { @h[a.to_s] }
    define_method(a) { @h[a] }
  end

  def to_json(*a)
    @h.to_json(*a)
  end

  def initialize(o)
    @h = Hash[CKEYS.zip(o)] if o.is_a? Array    # Array
    @h = o if o.is_a? Hash                      # Hash
    @h = JSON.parse(o) if o.is_a? String        # JSON String
  end

  def self.get(db, id)
    xx = Customer.new(db.get("cons:#{id}"))
    puts xx.to_s
    xx
  end

  def self.get_by_msisdn(db, msisdn)
    self.get(db, db.hget('cons:lookup:msisdn', msisdn))
  end

  def self.get_by_acct(db, acct)
    self.get(db, db.hget('cons:lookup:acct', acct))
  end

  def self.search(db, p)
    r = []
    if !p['msisdn'].to_s.empty?
      # return [ self.get_by_msisdn(db, p['msisdn']) ]
      e = self.get_by_msisdn(db, p['msisdn'])
      r << e unless e.nil?
    elsif p.key? :acct
      e = self.get_by_acct(db, p['acct'])
      r << e unless e.nil?
    end
    r 
  end

end

