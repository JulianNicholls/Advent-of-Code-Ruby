input = File.read('input.txt')

Pos = Struct.new(:e, :n)

pos = Pos.new(0, 0)

houses = Hash.new(0)
houses[pos] = 2

def update(pos, char)
  case char
  when '>' then pos.e += 1
  when '<' then pos.e -= 1
  when '^' then pos.n += 1
  when 'v' then pos.n -= 1
  end
end

input.each_char do |char|
  update(pos, char)
  houses[pos] += 1
end

puts houses.keys.size
