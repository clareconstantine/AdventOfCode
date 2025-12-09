class String
  def is_i?
     /\A[-+]?\d+\z/ === self
  end
end

def get_value input, signals
  input.is_i? ? input.to_i : signals[input.to_sym]
end

def build_circuit instructions
  signals = {}
  executed = {}
  while executed.size < instructions.size do
    instructions.each_with_index do |line, i|
      if !executed[i]
        input_str = line[0]
        destination = line[1]
        value = parse_input(input_str, signals)
        if value
          signals[destination.to_sym] = value
          executed[i] = true
        end
      end
    end
  end

  signals[:a]
end

def parse_input input_str, signals
  input = input_str.split()

  if input.include? 'AND'
    a = get_value(input[0], signals)
    b = get_value(input[2], signals)
    if a && b
      a & b
    end
  elsif input.include? 'OR'
    a = get_value(input[0], signals)
    b = get_value(input[2], signals)
    if a && b
      a | b
    end
  elsif input.include? 'LSHIFT'
    a = get_value(input[0], signals)
    b = get_value(input[2], signals)
    if a && b
      a << b
    end
  elsif input.include? 'RSHIFT'
    a = get_value(input[0], signals)
    b = get_value(input[2], signals)
    if a && b
      a >> b
    end
  elsif input.include? 'NOT'
    a = get_value(input[1], signals)
    if a
      ~ a
    end

  else
    get_value(input[0], signals)
  end
end

def main
  part_1_instructions = File.open("input/day_7.txt").readlines.map do |line|
    line = line.chomp.split(' -> ')
    line
  end

  part_2_instructions = File.open("input/day_7_part_2.txt").readlines.map do |line|
    line = line.chomp.split(' -> ')
    line
  end

  # instructions = [
  #   ["123", "x"],
  #   ["456", "y"],
  #   ["x AND y", "d"],
  #   ["x OR y", "e"],
  #   ["x LSHIFT 2", "f"],
  #   ["y RSHIFT 2", "g"],
  #   ["NOT x", "h"],
  #   ["NOT y", "i"]
  # ]

  wire_a_signal_part_1 = build_circuit(part_1_instructions)
  p wire_a_signal_part_1

  wire_a_signal_part_2 = build_circuit(part_2_instructions)
  p wire_a_signal_part_2
end

main
