input = File.read('input.txt')

area = input.each_line.reduce(0) do |acc, line|
  values = line.split('x').map(&:to_i).sort

  acc += 3 * values[0] * values[1] + 2 * values[0] * values[2] + 2 * values[1] * values[2]
end

print area
