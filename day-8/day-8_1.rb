input = open 'input.txt'

def cooked_size(line)
  index = 0
  size  = 0

  while index < line.size
    char   = line[index]
    size  += 1
    index += 1

    next if char != '\\'

    index += line[index] == 'x' ? 3 : 1
  end

  size
end

raw = 0
cooked = 0

input.each_line do |line|
  next if line =~ /^\s+$/

  raw += line.chomp!.size
  cooked += cooked_size(line[1...-1])
end

printf "Raw: %d, Cooked: %d, Diff: %d\n", raw, cooked, (raw - cooked)
