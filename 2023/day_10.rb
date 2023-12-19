require 'pry'

PATH_SNIPPET = "day_10"

# row, col
# START = [31, 28]

UP = "up"
DOWN = "down"
LEFT = "left"
RIGHT = "right"

VERTICAL_PIPES = ["|", "L", "7", "F", "J", "S"]
HORIZONTAL_PIPES = ["-", "L", "7", "F", "J", "S"]
CORNERS = ["L", "F", "7", "J"]



# row is 1-indexed
S_ROW = 32
S_COL = 28

def main
  # input = File.open("./input/test_input.txt").readlines.map{|line| line.chomp.chars}
  input = File.open("./input/#{PATH_SNIPPET}.txt").readlines.map{|line| line.chomp.chars}

  puts part_1(input)
  puts part_2(input)
end

# | is a vertical pipe connecting north and south.
# - is a horizontal pipe connecting east and west.
# L is a 90-degree bend connecting north and east.
# J is a 90-degree bend connecting north and west.
# 7 is a 90-degree bend connecting south and west.
# F is a 90-degree bend connecting south and east.
# . is ground; there is no pipe in this tile.
# S is the starting position of the animal; there is a pipe on this tile, but your sketch doesn't show what shape the pipe has.

# Parts =========================================

def part_1 grid
  position = {row: 32, col: 28, dir: DOWN}
  num_steps = 1
  while grid[position[:row]][position[:col]] != 'S'
    position = next_position(grid, position)
    num_steps += 1
  end
  (num_steps / 2) + (num_steps % 2)
end

def part_2 grid
  position = {row: S_ROW, col: S_COL, dir: DOWN}

  loop_coords = [[S_ROW - 1, S_COL]]
  while grid[position[:row]][position[:col]] != 'S'
    loop_coords << [position[:row], position[:col]]
    position = next_position(grid, position)
  end

  grid[S_ROW - 1][S_COL] = "F"

  area = 0
  grid.each_with_index do |row, row_i|
    inside = false
    row.each_with_index do |col, col_i|
      if is_loop_coord(loop_coords, row_i, col_i)
        if grid[row_i][col_i] == "|" || grid[row_i][col_i] == "L" || grid[row_i][col_i] == "J"
          inside = !inside
        end
      elsif inside
        area += 1
      end
    end
  end
  area
end

# Helpers =======================================

def next_position(grid, position)
  row = position[:row]
  col = position[:col]
  direction = position[:dir]

  if grid[row][col] == "|" && direction == UP
    return {row: row - 1, col: col, dir: UP}
  elsif grid[row][col] == "|" && direction == DOWN
    return {row: row + 1, col: col, dir: DOWN}
  elsif grid[row][col] == "-" && direction == LEFT
    return {row: row, col: col - 1, dir: LEFT}
  elsif grid[row][col] == "-" && direction == RIGHT
    return {row: row, col: col + 1, dir: RIGHT}
  elsif grid[row][col] == "L" && direction == DOWN
    return {row: row, col: col + 1, dir: RIGHT}
  elsif grid[row][col] == "L" && direction == LEFT
    return {row: row - 1, col: col, dir: UP}
  elsif grid[row][col] == "J" && direction == DOWN
    return {row: row, col: col - 1, dir: LEFT}
  elsif grid[row][col] == "J" && direction == RIGHT
    return {row: row - 1, col: col, dir: UP}
  elsif grid[row][col] == "7" && direction == RIGHT
    return {row: row + 1, col: col, dir: DOWN}
  elsif grid[row][col] == "7" && direction == UP
    return {row: row, col: col - 1, dir: LEFT}
  elsif grid[row][col] == "F" && direction == LEFT
    return {row: row + 1, col: col, dir: DOWN}
  elsif grid[row][col] == "F" && direction == UP
    return {row: row, col: col + 1, dir: RIGHT}
  end
end

def is_loop_coord(loop_coords, row, col)
  loop_coords.each do |lc|

    return true if lc == [row, col]
  end
  false
end

def is_inside(borders)
  reduced_i = borders["|"] % 2
  reduced_f7 = (borders["F"] - borders["7"]).abs
  reduced_jl = (borders["J"] - borders["L"]).abs

  return false if reduced_i == 1 && reduced_f7 == 1 && reduced_jl == 1
  return true if reduced_i == 0 && reduced_f7 == 1 && reduced_jl == 1

  (reduced_i + reduced_f7 + reduced_jl) % 2 == 1
end

# ===============================================

main
