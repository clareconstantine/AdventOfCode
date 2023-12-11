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
  gear_ratio_sum = 0

  potential_gears = {}
  # {
  #   "star_i" => {
  #     "star_j" => {
  #       [part_number_1, part_number_2, ...],
  #      },
  #   }
  # }

  in_number = false
  relevant_part_number = false
  number = ''

  star_i = nil
  star_j = nil

  rows.each_with_index do |row, i|
    row.each_with_index do |c, j|
      # if the current char is a number
      if is_digit(c)
        in_number = true
        number = number + c
        # we aren't yet sure it's a part number we care about, so check for adjacent stars
        # and if there is one, we are looking at a part number that might be part of a gear ratio
        if !relevant_part_number
          coords = adjacent_star_coords(rows, i, j)
          if coords
            relevant_part_number = true
            star_i = coords[:i]
            star_j = coords[:j]
          end
        end
      else
        # current char is not a number, but we just finished reading a number
        # if it was a part number we care about, add it to our potential_gears list
        if in_number && relevant_part_number
          if potential_gears[star_i.to_s]
            if potential_gears[star_i.to_s][star_j.to_s]
              potential_gears[star_i.to_s][star_j.to_s].push(number.to_i)
            else
              potential_gears[star_i.to_s][star_j.to_s] = [number.to_i]
            end
          else
            potential_gears[star_i.to_s] = {}
            potential_gears[star_i.to_s][star_j.to_s] = [number.to_i]
          end
        end
        in_number = false
        relevant_part_number = false
        number = ''
        star_i = nil
        star_j = nil
      end
    end
  end

  gear_ratio_sum(potential_gears)
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

# returns {i: x, j: y} that reflect the i and j coordinates of the star
def adjacent_star_coords(rows, i, j)
  if i > 0 && j > 0
    return {i: i-1, j: j-1} if "*" == rows[i-1][j-1]
  end

  if i > 0
    return {i: i-1, j: j} if "*" == rows[i-1][j]
  end

  if i > 0 && j < rows[i].length - 1
    return {i: i-1, j: j+1} if "*" == rows[i-1][j+1]
  end

  if j > 0
    return {i: i, j: j-1} if "*" == rows[i][j-1]
  end

  if i < rows.length - 1 && j > 0
    return {i: i+1, j: j-1} if "*" == rows[i+1][j-1]
  end

  if j < rows[i].length - 1
    return {i: i, j: j+1} if "*" == rows[i][j+1]
  end

  if i < rows.length - 1
    return {i: i+1, j: j} if "*" == rows[i+1][j]
  end

  if i < rows.length - 1 && j < rows[i].length - 1
    return {i: i+1, j: j+1} if "*" == rows[i+1][j+1]
  end
end

def gear_ratio_sum(potential_gears)
  sum = 0

  potential_gears.values.each do |i|
    i.values.each do |j|
      if j.length == 2
        sum += j[0] * j[1]
      end
    end
  end
  sum
end

# ===============================================

main
