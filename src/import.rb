require 'rubygems'
require 'redis'

db = Redis.new
File.open('data/fullset-cons.csv', "r").each_line do |l|
  l1 = l.gsub /"/, ''
  a = l1.split(',')
  if a.size != 6 
    puts 'Error for: #{l}'
    next
  end
  db.set 
  db.lpush a[0].downcase, a[2]
end
#    db.lpush i, products[Random.rand(0..11)]

# db['Horst'] = '42'
# p db['Horst']
