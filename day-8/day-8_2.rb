input = open 'input.txt'

def cooked_size(line)
  length = line.size + 2

  line.each_char do |ch|
    length += 1 if ch == '\\' || ch == '"'
  end

  length
end

raw = 0
cooked = 0

input.each_line do |line|
  next if line =~ /^\s+$/

  raw += line.chomp!.size
  cooked += cooked_size(line)
end

printf "Raw: %d, Cooked: %d, Diff: %d\n", raw, cooked, (cooked - raw)
