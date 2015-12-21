require 'pp'

input = File.read('input.txt')

Pos = Struct.new(:e, :n) do
  def to_s
    "#{e},#{n}"
  end
end

s_pos = Pos.new(0, 0)
r_pos = s_pos.dup

houses = { s_pos.to_s => 1 }

def update(pos, char)
  case char
  when '>' then pos.e += 1
  when '<' then pos.e -= 1
  when '^' then pos.n += 1
  when 'v' then pos.n -= 1
  else return false
  end

  true
end

delivery = 1

input.each_char do |char|
  if delivery == 1
    if update(s_pos, char)
      houses[s_pos.to_s] = 1
      delivery = 0
    end
  else
    if update(r_pos, char)
      houses[r_pos.to_s] = 1
      delivery = 1
    end
  end
end

puts houses.keys.size
