input = File.read 'input.txt'

floor = input.each_char.inject(0) do |acc, char|
  acc += if char == '('
           1
         elsif char == ')'
           -1
         else
           0
         end
end

puts floor
