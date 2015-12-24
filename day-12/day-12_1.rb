# It's hardly worth writing in Ruby
# since this one-liner will do it:

# puts File.read('input.txt').scan(/-*\d+/).map(&:to_i).reduce(:+)

input = File.read 'input.txt'

numbers = input.scan(/-*\d+/).map(&:to_i)

puts numbers.first
puts numbers.last

puts numbers.reduce(:+)
