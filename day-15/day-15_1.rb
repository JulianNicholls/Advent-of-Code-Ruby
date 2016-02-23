require 'pp'

input = File.read 'input.txt'

ingredients = []

input.each_line do |line|
  next if line =~ /^\s+$/

  sections = line.scan(/(\w+ -?\d)/)
  ingredients << sections.each_with_object({}) do |section, object|
    key, value = section[0].split
    object[key] = value
  end
end

puts ingredients

(1..97).each do |sprinkles|
  (1..98-sprinkles) do |pb|
    (1..99-(pb + sprinkles)).each do |frosting|
      sugar = 100 - (pb + sprinkles + frosting)

      total = 1
      ingredients[0].keys.each do |key|
        param = sprinkles * ingredients[0][key] +
                pb * ingredients[1][key] +
                frosting * ingredients[2][key] +
                sugar * ingredients[3][key]
      end
    end
  end
end
