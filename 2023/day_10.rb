PATH_SNIPPET = "day_10"

# row, col
# START = [31, 28]

UP = "up"
DOWN = "down"
LEFT = "left"
RIGHT = "right"

def main
  # input = File.open("./input/test_input.txt").readlines.map{|line| line.chomp.chars}
  input = File.open("./input/#{PATH_SNIPPET}.txt").readlines.map{|line| line.chomp.chars}

  # part_1(input)
  puts part_1(input)
  # puts part_2(input)
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
  # position = {row: 2, col: 1, dir: DOWN}
  position = {row: 32, col: 28, dir: DOWN}
  # position = {row: 3, col: 0, dir: DOWN}
  num_steps = 1
  while grid[position[:row]][position[:col]] != 'S'
    position = next_position(grid, position)
    num_steps += 1
  end
  (num_steps / 2) + (num_steps % 2)
end

def part_2 grid
  # position = {row: 2, col: 1, dir: DOWN}
  position = {row: 32, col: 28, dir: DOWN}
  # position = {row: 3, col: 0, dir: DOWN}
  # loop_grid = mark_loop(grid, position)
  # loop_grid
  while grid[position[:row]][position[:col]] != 'S'
    puts position
    grid[position[:row]][position[:col]] = "P"
    puts grid
    position = next_position(grid, position)
  end
  grid
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
  puts position
end

# the pipes in the loop will all be replaced with "P"
def mark_loop(grid, position)
  while grid[position[:row]][position[:col]] != 'S'
    grid[position[:row]][position[:col]] = "P"
    position = next_position(grid, position)
  end
  grid
end

# ===============================================

main
