require 'json'
require 'pp'

input = JSON.parse(File.read 'input.txt')

def trim(hash)
  hash.delete_if { |k, v| v.is_a?(Hash) && v.values.include?('red') }

  hash.keys.each do |key|
    val = hash[key]
    if val.is_a? Hash
      trim(val)
    elsif val.is_a? Array
      trim_array(val)
    end
  end
end

def trim_array(array)
  array.delete_if { |item| item.is_a?(Hash) && item.values.include?('red') }

  array.each do |item|
    if item.is_a? Hash
      trim(item)
    elsif item.is_a? Array
      trim_array(item)
    end
  end
end

trim(input)

pp input
puts input.to_s.scan(/-*\d+/).map(&:to_i).reduce(:+)
