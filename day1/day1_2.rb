input = File.read 'input.txt'

floor = input.each_char.with_object({floor: 0, index: 0}) do |char, acc|
  acc[:index] += 1
  acc[:floor] += if char == '('
           1
         elsif char == ')'
           -1
         else
           0
         end

  if acc[:floor] == -1
    puts acc
    break
  end
end
