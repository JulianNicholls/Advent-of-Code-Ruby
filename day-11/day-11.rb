def char_triple(text)
  (0..text.size-3).each do |idx|
    ord = text[idx].ord
    return true if ord == text[idx + 1].ord - 1 && ord == text[idx + 2].ord - 2
  end

  false
end

def next_char(char)
  case char
  when 'h' then 'j'
  when 'k' then 'm'
  when 'n' then 'p'
  when 'z' then 'a'
  else (char.ord + 1).chr
  end
end

def next_string(str)
  index = str.size - 1

  loop do
    nxt = next_char(str[index])
    str[index] = nxt
    break str unless nxt == 'a'
    index -= 1
  end
end

def good?(str)
  return false if str =~ /[iol]/
  return false unless char_triple(str)
  return false unless str.match(/([[:alpha:]])\1[[:alpha:]]*([[:alpha:]])\2/)

  true
end

['abcdefgh', 'ghijklmn', 'cqjxjnds', 'cqjxxzaa'].each do |str|
  print "#{str}: "

  str = next_string(str) until good? str

  puts str
end
