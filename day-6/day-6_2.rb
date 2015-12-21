require 'pp'

input = File.read 'input.txt'

lights = Array.new(1000) { Array.new(1000, 0) }

Point = Struct.new(:y, :x)

def action_type(text)
  return :on  if text =~ /on/
  return :off if text =~ /off/

  :toggle
end

def perform(larray, tl, br, action)
  (tl.y..br.y).each do |line|
    (tl.x..br.x).each do |col|
      current = larray[line][col]

      case action
      when :on      then new_val = current + 1
      when :off     then new_val = current - 1
      when :toggle  then new_val = current + 2
      end

      larray[line][col] = [0, new_val].max
    end
  end
end

input.each_line do |instructions|
  parts = instructions.match(/(.+) (\d{1,3}),(\d{1,3}) through (\d{1,3}),(\d{1,3})/)

  if parts
    action = action_type(parts[1])
    top_left = Point.new(parts[2].to_i, parts[3].to_i)
    bottom_right = Point.new(parts[4].to_i, parts[5].to_i)

    perform(lights, top_left, bottom_right, action)
  end
end

brightness = 0

lights.each do |line|
  line_value = line.reduce(:+)
  # puts "#{line.size} - #{on_here}"
  brightness += line_value
end

puts "Brightness: #{brightness}"
