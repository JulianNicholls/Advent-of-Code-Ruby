input = File.read('input.txt')

def categorise(word)
  return :naughty unless word.scan(/[aeiou]/).size >= 3
  return :naughty unless word.scan(/([[:alpha:]])\1/).size > 0
  return :naughty if word.scan(/(ab)|(cd)|(pq)|(xy)/).size > 0

  :nice
end

words = input.each_line.with_object({naughty: 0, nice: 0}) do |word, cats|
  key = categorise(word)
  cats[key] += 1
end

puts words
