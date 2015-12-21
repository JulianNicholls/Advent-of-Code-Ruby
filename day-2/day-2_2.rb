input = File.read('input.txt')

length = input.each_line.reduce(0) do |acc, line|
  values = line.split('x').map(&:to_i).sort

  acc += 2 * (values[0] + values[1]) + values[0] * values[1] * values[2]
end

puts length
