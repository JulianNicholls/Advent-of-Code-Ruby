require 'pp'

input = File.read 'input.txt'

registers = {}

def collect(exp)
  if exp.size == 1 && exp.first =~ /^\d+$/
    return { value: exp.first.to_i }
  end

  return { expression: exp }
end

def evaluate(registers, key)
  return key.to_i if key =~ /^\d+$/
  return registers[key][:value] if registers[key].key? :value

  parts = registers[key][:expression]

  if parts.size == 1
    registers[key][:value] = evaluate(registers, parts[0])     # Just a source
  elsif parts.size == 2
    fail "Evaluate NOT Syntax Error: #{parts}" unless parts[0] == 'NOT'
    registers[key][:value] = ~evaluate(registers, parts[1])
  else
    fail "Evaluate Op Syntax Error: '#{parts}'" unless parts.size == 3

    left  = evaluate(registers, parts[0])
    right = evaluate(registers, parts[2])

    registers[key][:value] = case parts[1].upcase   # operation
                             when 'AND'    then left & right
                             when 'OR'     then left ^ right
                             when 'LSHIFT' then left << right
                             when 'RSHIFT' then left >> right
                             else fail "Exp: #{parts}"
                             end
  end

  printf "%-2s: %s\n" , key, registers[key]
  registers[key].fetch(:value)  # Cause failure on cockup
end

input.each_line do |line|
  next if line =~ /^\s+$/

  *exp, assign, dest = line.split
  registers[dest] = collect(exp)
  puts "#{line.chomp}: #{registers[dest]}" if registers[dest].key? :value
end

puts "a = #{evaluate(registers, 'a')}"

puts "Red Herrings:"
pp registers.select { |key, value| !value.key? :value }
