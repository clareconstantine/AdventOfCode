PATH_SNIPPET = "day_4"
def main
  # lines = File.open("./input/test_input.txt").readlines.map(&:chomp).map(&:chars)
  lines = File.open("./input/#{PATH_SNIPPET}.txt").readlines.map(&:chomp).map(&:chars)

  puts part_1(lines)
  puts part_2(lines)
end

# Constants =====================================

# Parts =========================================

def part_1 lines
  total = 0
  # iterate through each cell
  lines.each_with_index do |line, i|
    line.each_with_index do |char, j|
      # if it's an X, count the XMAS's that it's part of
      if char == 'X'
        total += count_xmas(lines, i, j)
      end
    end
  end
  total
end

def part_2 lines
 total = 0
  # iterate through each cell
  lines.each_with_index do |line, i|
    line.each_with_index do |char, j|
      # if it's an A, check if it's the center of an X-MAS
      if char == 'A'
        total += 1 if is_an_x_mas(lines, i, j)
      end
    end
  end
  total
end

# Helpers =======================================

def count_xmas lines, i, j
  count = 0
  # up left: (i - 1, j - 1) (i - 2, j - 2), (i - 3, j - 3)
  if (i - 3 >= 0) && (j - 3 >= 0)
    count += 1 if lines[i-1][j-1] == "M" && lines[i-2][j-2] == "A" && lines[i-3][j-3] == "S"
  end
  # up: (i - 1, j) (i - 2, j), (i - 3, j)
  if i - 3 >= 0
    count += 1 if lines[i-1][j] == "M" && lines[i-2][j] == "A" && lines[i-3][j] == "S"
  end
  # up right: (i - 1, j + 1) (i - 2, j + 2), (i - 3, j + 3)
  if (i - 3 >= 0) && (j + 3 < lines[i].size)
    count += 1 if lines[i-1][j+1] == "M" && lines[i-2][j+2] == "A" && lines[i-3][j+3] == "S"
  end
  # right: (i, j + 1) (i, j + 2), (i, j + 3)
  if j + 3 < lines[i].size
    count += 1 if lines[i][j+1] == "M" && lines[i][j+2] == "A" && lines[i][j+3] == "S"
  end
  # down right: (i + 1, j + 1) (i + 2, j + 2), (i + 3, j + 3)
  if (i + 3 < lines.size) && (j + 3 < lines[i].size)
    count += 1 if lines[i+1][j+1] == "M" && lines[i+2][j+2] == "A" && lines[i+3][j+3] == "S"
  end
  # down: (i + 1, j) (i + 2, j), (i + 3, j)
  if i + 3 < lines.size
    count += 1 if lines[i+1][j] == "M" && lines[i+2][j] == "A" && lines[i+3][j] == "S"
  end
  # down left: (i + 1, j - 1) (i + 2, j - 2), (i + 3, j - 3)
  if (i + 3 < lines.size) && (j - 3 >= 0)
    count += 1 if lines[i+1][j-1] == "M" && lines[i+2][j-2] == "A" && lines[i+3][j-3] == "S"
  end
  # left: (i, j - 1) (i, j - 2), (i, j - 3)
  if j - 3 >= 0
    count += 1 if lines[i][j-1] == "M" && lines[i][j-2] == "A" && lines[i][j-3] == "S"
  end
  count
end

def is_an_x_mas lines, i, j
  # if we are on an edge and can't be the center of an X
  if i == 0 || j == 0 || i + 1 >= lines.size || j + 1 >= lines[i].size
    return false
  end

  # upper left to lower right line
  if (lines[i-1][j-1] == "M" && lines[i+1][j+1] == "S") || (lines[i+1][j+1] == "M" && lines[i-1][j-1] == "S")
    # upper right to lower left line
    if (lines[i-1][j+1] == "M" && lines[i+1][j-1] == "S") || (lines[i+1][j-1] == "M" && lines[i-1][j+1] == "S")
      return true
    end
  end
  false
end

# ===============================================

main
