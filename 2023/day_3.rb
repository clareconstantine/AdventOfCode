PATH_SNIPPET = "day_3"
def main
  # input = File.open("./input/test_input.txt").readlines.map(&:chomp)
  rows = File.open("./input/#{PATH_SNIPPET}.txt").readlines.map(&:chomp).map(&:chars)

  puts part_1(rows)
  puts part_2(rows)
end

# Parts =========================================

def part_1 rows
  part_number_sum = 0

  in_number = false
  part_number = false
  number = ''

  rows.each_with_index do |row, i|
    row.each_with_index do |c, j|
      # if the current char is a number
      if is_digit(c)
        in_number = true
        number = number + c
        # we aren't yet sure it's a part number, so check for adjacent symbols
        # and if there is one, we are looking at a part_number
        if !part_number
          if adjacent_symbol(rows, i, j)
            part_number = true
          end
        end
      else
        # current char is not a number, but we just finished reading a number
        # if it was a part number, add it to our total and reset variables
        if in_number && part_number
          part_number_sum += number.to_i
        end
        in_number = false
        part_number = false
        number = ''
      end
    end
  end
  part_number_sum
end

def part_2 rows
 "xmas!"
end

# Helpers =======================================

def is_digit(c)
  "0123456789".include?(c)
end

def is_symbol(c)
  c && !".0123456789".include?(c)
end

def adjacent_symbol(rows, i, j)
  # top row
  if i == 0
    # first col
    if j == 0
      return is_symbol(rows[i][j+1]) || is_symbol(rows[i+1][j]) || is_symbol(rows[i+1][j+1])
    # last col
    elsif j == rows[i].length - 1
      return is_symbol(rows[i][j-1]) || is_symbol(rows[i+1][j-1]) || is_symbol(rows[i+1][j])
    else
      return is_symbol(rows[i][j-1]) || is_symbol(rows[i][j+1]) || is_symbol(rows[i+1][j-1]) || is_symbol(rows[i+1][j]) || is_symbol(rows[i+1][j+1])
    end
  # bottom row
  elsif i == rows.length - 1
    # first col
    if j == 0
      return is_symbol(rows[i-1][j]) || is_symbol(rows[i-1][j+1]) || is_symbol(rows[i][j+1])
    # last col
    elsif j == rows[i].length - 1
      return is_symbol(rows[i-1][j-1]) || is_symbol(rows[i-1][j]) || is_symbol(rows[i][j-1])
    else
      return is_symbol(rows[i-1][j-1]) || is_symbol(rows[i-1][j]) || is_symbol(rows[i-1][j+1]) || is_symbol(rows[i][j-1]) || is_symbol(rows[i][j+1])
    end
  # middle row
  else
    return is_symbol(rows[i-1][j-1]) || is_symbol(rows[i-1][j]) || is_symbol(rows[i-1][j+1]) || is_symbol(rows[i][j-1]) || is_symbol(rows[i][j+1]) || is_symbol(rows[i+1][j-1]) || is_symbol(rows[i+1][j]) || is_symbol(rows[i+1][j+1])
  end
end

# ===============================================

main
