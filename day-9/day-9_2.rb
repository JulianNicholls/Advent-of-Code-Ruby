input = open 'input.txt'

distances = {}

input.each_line do |line|
  next if line =~ /^\s+$/

  place1, place2, distance = line.match(/(\w+) to (\w+) = (\d+)/).captures

  distances[place1] ||= {}
  distances[place1][place2] = distance.to_i
  distances[place2] ||= {}
  distances[place2][place1] = distance.to_i
end

longest = 0

distances.keys.permutation do |list|
  start = list.shift()
  distance = 0

  list.each do |place|
    distance += distances[start][place]
    start = place
  end

  if distance > longest
    longest = distance
    puts "#{start}, #{list.join ', '}: #{distance}"
  end
end
