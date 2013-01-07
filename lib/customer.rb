require 

class Customer
  attr_accessor :id, :msisdn, :acct, :fname, :lname, :zip

  # http://www.ruby-doc.org/stdlib-1.9.3/libdoc/json/rdoc/JSON.html
  # http://flori.github.com/json/
  # http://flori.github.com/json/doc/index.html
  # http://www.json.org

  def to_json(*a)
    {
      'json_class'   => self.class.name, # = 'Range'
      'data'         => [ first, last, exclude_end? ]
    }.to_json(*a)
  end
  
  def initialize(str)
    # json str to object
  end
  
  def self.get_by_msisdn(db, msisdn)
    id = db.hget 'cons:lookup:msisdn', p[:msisdn]
    Customer.new(db.get("cons:#{id}"))
  end

end
    
