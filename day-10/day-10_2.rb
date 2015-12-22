input = '3113322113'

50.times do
  output = ''
  cur = input.slice! 0
  count = 1

  input.each_char do |char|
    if char == cur
      count += 1
    else
      output << count.to_s << cur
      cur = char
      count = 1
    end
  end

  output << count.to_s << cur

  puts "#{output[0..80]} : #{output.size}"
  input = output
end
