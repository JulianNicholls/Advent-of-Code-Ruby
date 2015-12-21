require 'pp'

input = File.read 'input.txt'

# Array.new(1000, Array.new(1000, 0))
# does not create a two dimensional 1,000,000 element array...
# It creates a 1000 element array, each of which contains the SAME
# 1000 element array!
lights = Array.new(1000) { Array.new(1000, 0) }

Point = Struct.new(:y, :x)

def action_type(text)
  return :on  if text =~ /on/
  return :off if text =~ /off/
  return :toggle if text =~ /toggle/

  fail "Cockup: #{text}"
end

def perform(larray, tl, br, action)
  fail "Not top to Bottom: #{tl} #{br}" unless tl.y <= br.y
  fail "Not Left to Right: #{tl} #{br}" unless tl.x <= br.x

  (tl.y..br.y).each do |line|
    (tl.x..br.x).each do |col|
      case action
      when :on      then new_val = 1
      when :off     then new_val = 0
      when :toggle  then new_val = 1 - larray[line][col]
      end

      larray[line][col] = new_val
    end
  end
end

input.each_line do |instructions|
  parts = instructions.match(/(.+) (\d{1,3}),(\d{1,3}) through (\d{1,3}),(\d{1,3})/)

  if parts
    action = action_type(parts[1])
    top_left = Point.new(parts[2].to_i, parts[3].to_i)
    bottom_right = Point.new(parts[4].to_i, parts[5].to_i)

    fail parts[2] if top_left.y == 0 && parts[2] != '0'
    fail parts[3] if top_left.x == 0 && parts[3] != '0'
    fail parts[4] if bottom_right.y == 0 && parts[4] != '0'
    fail parts[5] if bottom_right.x == 0 && parts[5] != '0'

    perform(lights, top_left, bottom_right, action)
  end
end

on = 0

lights.each do |line|
  on_here = line.select { |light| light == 1 }.size
  puts "#{line.size} - #{on_here}"
  on += on_here
end

puts "On: #{on}"
