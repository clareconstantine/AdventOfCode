require 'pry'

PATH_SNIPPET = "day_8"
def main
  # input = File.open("./input/test_input.txt").readlines.map(&:chomp)
  input = File.open("./input/#{PATH_SNIPPET}.txt").readlines.map(&:chomp)

  directions = input[0].chars
  map = build_map(input[2, input.length - 1], /[A-Z]+/)

  puts part_1(directions, map)
  puts part_2(directions, map)
end

# Parts =========================================

def part_1 directions, map
  location = "AAA"
  num_steps = 0
  while location != "ZZZ"
    dir = directions.shift
    if dir == "R"
      location = map[location][1]
    else
      location = map[location][0]
    end
    directions = directions.push(dir)
    num_steps += 1
  end
  num_steps
end

def part_2 directions, map
  starts = map.keys.filter {|k| k[2] == "A"}
  steps_to_z = []

  starts.each_with_index do |location, j|
    num_steps = 0
    while !(location[2] == "Z")
      dir = directions.shift
      if dir == "R"
        location = map[location][1]
      else
        location = map[location][0]
      end
      directions = directions.push(dir)
      num_steps += 1
    end
    steps_to_z[j] = num_steps
  end
  steps_to_z.reduce(1, :lcm)
end

# Helpers =======================================

def build_map(rows, regex)
  map = {}
  rows.each do |row|
    components = row.scan(regex).flatten
    map[components[0]] = [components[1], components[2]]
  end
  map
end

# ===============================================

main
