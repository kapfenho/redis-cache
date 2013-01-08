require 'SecureRandom'

BEG = 1_000_000 
f = File.new(ARGV[1],'w')

for id in BEG..(BEG + ARGV[0].to_i - 1)

  msisdn = '660' + Random.rand(1000000..9999999).to_s
  acct = Random.rand(9000000000..9399999999)
  fn = SecureRandom.urlsafe_base64(Random.rand(3..12))
  ln = SecureRandom.urlsafe_base64(Random.rand(3..12))
  zip = Random.rand(1000..9999)
  f << "#{id.to_s};#{msisdn};#{acct.to_s};#{fn};#{ln};#{zip}\n"
end

f.close

