PATH_SNIPPET = "day_11"

class Galaxy
  def initialize row, col
    @row = row
    @col = col
  end

  def row
    @row
  end

  def col
    @col
  end
end

class Day11
  def initialize
    # @grid = File.open("./input/test_input.txt").readlines.map{|line| line.chomp.chars}
    @grid = File.open("./input/#{PATH_SNIPPET}.txt").readlines.map{|line| line.chomp.chars}
    process_input

    puts part_1
    puts part_2
  end

  # Parts =========================================

  def part_1
    total_distance(2)
  end

  def part_2
    total_distance(1000000)
  end

  # Helpers =======================================

  # one pass through the input
  # list of empty row and cols
    # empty_rows = {row_i: true}
    # empty_cols = {col_i: true}
    # all start out empty, mark false as you encounter each galaxy
  # list of galaxies
    # galaxies = {galaxy_id: Galaxy.new(row_i, col_i)}
  def process_input
    @empty_rows = Hash.new(true)
    @empty_cols = Hash.new(true)

    @galaxies = {}
    next_galaxy_id = 0

    @grid.each_with_index do |row, row_i|
      row.each_with_index do |pos, col_i|
        if @grid[row_i][col_i] == "#"
          @galaxies[next_galaxy_id] = Galaxy.new(row_i, col_i)
          next_galaxy_id += 1

          @empty_rows[row_i] = false
          @empty_cols[col_i] = false
        end
      end
    end
  end

  def distance(start_galaxy, end_galaxy, distance_factor)
    dist = 0

    min_row = [start_galaxy.row, end_galaxy.row].min
    max_row = [start_galaxy.row, end_galaxy.row].max

    min_col = [start_galaxy.col, end_galaxy.col].min
    max_col = [start_galaxy.col, end_galaxy.col].max

    (max_row - min_row).abs.times do |i|
      @empty_rows[min_row + i] ? dist += distance_factor : dist += 1
    end

    (max_col - min_col).abs.times do |i|
      @empty_cols[min_col + i] ? dist += distance_factor : dist += 1
    end

    dist
  end

  def total_distance(distance_factor)
    distance_sum = 0
    distance_factor = distance_factor
    @galaxies.each do |start_id, start_galaxy|
      @galaxies.each do |end_id, end_galaxy|
        if start_id < end_id
          distance_sum += distance(start_galaxy, end_galaxy, distance_factor)
        end
      end
    end
    distance_sum
  end
end

Day11.new
