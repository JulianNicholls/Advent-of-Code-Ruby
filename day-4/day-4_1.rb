require 'digest/md5'

unless ARGV[0]
  puts "We require a string input"
  exit
end

base = ARGV[0]
cand = 0

loop do
  digest = Digest::MD5.hexdigest "#{base}#{cand}"

  break if digest[0,6] == '000000'

  cand += 1
  puts cand if cand % 100000 == 0
end

str = "#{base}#{cand}"
puts "result: #{cand}: #{Digest::MD5.hexdigest str}"
