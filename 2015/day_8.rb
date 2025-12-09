PATH_SNIPPET = "day_8"
def main
  # input = File.open("./input/test_input.txt").readlines.map(&:chomp)
  input = File.open("./input/#{PATH_SNIPPET}.txt").readlines.map(&:chomp)

  puts part_1(input)
  puts part_2(input)
end

# Constants =====================================

# Parts =========================================

def part_1 input
  "merry"
end

def part_2 input
 "xmas!"
end

# Helpers =======================================

# ===============================================

main
