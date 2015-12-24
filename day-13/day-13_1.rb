require 'pp'

input = File.read 'input.txt'

happiness = {}

input.each_line do |line|
  next if line =~ /^\s+$/

  name, dir, value, other = line.match(/(\w+) would (\w{4}) (\d{1,2}) (?:\w+\s){6}(\w+)./).captures

  # puts "#{name}, #{dir}, #{value}, #{other}"
  value = value.to_i

  happiness[name] ||= {}
  happiness[name][other] = dir == 'gain' ? value : -value
end

delight = 0

diners = happiness.keys.size

happiness.keys.permutation do |list|
  mood = 0

  (0...diners).each do |index|
    guest = happiness[list[index]]
    mood += guest[list[(index + 1) % diners]]
    mood += guest[list[(index - 1) % diners]]
  end

  if mood > delight
    puts "#{list.join ', '}: #{mood}"
    delight = mood
  end
end
