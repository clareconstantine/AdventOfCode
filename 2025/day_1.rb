PATH_SNIPPET = "day_1"
def main
  # input = File.open("./input/test_input.txt").readlines.map(&:chomp)
  input = File.open("./input/#{PATH_SNIPPET}.txt").readlines.map(&:chomp)

  puts part_1(input)
  puts part_2(input)
end

# Parts =========================================

def part_1 input
  rotations = input.map do |line|
    direction = line[0]
    distance = line[1..].to_i

    if direction == "L"
      distance *= -1
    end

    distance
  end

  dial = 50
  pw = 0

  rotations.each do |turn|
    dial += turn
    
    dial = dial % 100
    dial += 100 if dial < 0

    pw += 1 if dial == 0
  end

  pw
end

def part_2 input
  dial = 50
  pw = 0

  rotations = input.map do |line|
    direction = line[0]
    distance = line[1..].to_i

    if direction == "L"
      distance *= -1
    end

    distance
  end

  # [-49, -24, 48...]
  rotations.each do |turn| 
    dial += turn

    pw += (dial / 100).abs

    if dial < 0
      dial = (-1 * (dial % 100)) + 100
      pw += 1
    else
      dial = dial % 100
    end
  end

  pw
end

# Helpers =======================================

# ===============================================

main