PATH_SNIPPET = "day_9"
def main
  # input = File.open("./input/test_input.txt").readlines.map{|line| line.chomp.split(' ').map(&:to_i) }
  input = File.open("./input/#{PATH_SNIPPET}.txt").readlines.map{|line| line.chomp.split(' ').map(&:to_i) }

  puts part_1(input)
  puts part_2(input)
end

# Parts =========================================

def part_1 rows
  total = 0
  rows.each do |row|
    total += next_value_for_row(row)
  end
  total
end

def part_2 input
 "xmas!"
end

# Helpers =======================================

def next_value_for_row(row)
  if row.uniq == [0]
    return 0
  else
    next_row = []
    row.each_with_index do |n, i|
      if i < row.length - 1
        next_row[i] = row[i + 1] - n
      end
    end

    return row.last + next_value_for_row(next_row)
  end
end

# ===============================================

main
