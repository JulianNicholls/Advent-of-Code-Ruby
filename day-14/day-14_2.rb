require 'pp'

input = File.read 'input.txt'

speeds = {}

input.each_line do |line|
  next if line =~ /^\s+$/

  name, speed, run_time, rest_time = line.match(/(\w+) can fly (\d{1,2}) km\/s for (\d{1,2}) .* (\d{2,3}) sec/).captures

  speeds[name] = { speed: speed.to_i, run_time: run_time.to_i, rest_time: rest_time.to_i, points: 0 }
end

(1..2503).each do |time|
  max = 0

  speeds.keys.each do |key|
    this = speeds[key]
    cycle_time = this[:run_time] + this[:rest_time]
    cycles = time / cycle_time
    left = time % cycle_time

    distance = cycles * this[:run_time] * this[:speed]
    distance += left < this[:run_time] ? left * this[:speed] : this[:run_time] * this[:speed]
    this[:distance] = distance
    max = distance if distance > max
  end

  speeds.keys.each do |key|
    speeds[key][:points] += 1 if speeds[key][:distance] == max
  end
end

speeds.each do |k, v|
  puts "#{k}: #{v}"
end
