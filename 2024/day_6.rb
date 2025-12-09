PATH_SNIPPET = "day_6"
class Day6
  def initialize
    input = File.open("./input/test_input.txt").readlines.map(&:chomp).map(&:chars)
    # input = File.open("./input/#{PATH_SNIPPET}.txt").readlines.map(&:chomp).map(&:chars)

    # create class variables here
    @map = input

    @direction = :up

    # indexes of the current row and current col
    @row, @col = get_starting_position

    @positions_visited = [[@row, @col]]
    @positions_visited_w_dir = {
                                up: [],
                                right: [],
                                down: [],
                                left: []
                              }

    puts part_1
    puts part_2
  end

  # Constants =====================================

  TURNS = {
    up: :right,
    right: :down,
    down: :left,
    left: :up
  }

  STEPS = {
    up: {row_delta: -1, col_delta: 0},
    right: {row_delta: 0, col_delta: 1},
    down: {row_delta: 1, col_delta: 0},
    left: {row_delta: 0, col_delta: -1},
  }

  OBSTACLE = "#"
  GUARD = "^"
  EMPTY_SPACE = "."

  # Parts =========================================

  def part_1
    while on_map?(@row, @col)
      next_row, next_col = next_space
      if !on_map?(next_row, next_col)
        return @positions_visited.uniq.size
      end
      if !obstacle?(next_row, next_col)
        @row = next_row
        @col = next_col
        @positions_visited << [@row, @col]
        # p "[#{@row}, #{@col}]"
      else
        # p "turning from #{@direction} to #{TURNS[@direction]}"
        turn
      end
    end
  end

  def part_2
    loop_count = 0
    @map.each_with_index do |_, i|
      @map.first.each_with_index do |_, j|
        if empty_space?(i, j)
          @map[i][j] = OBSTACLE
        end
        if creates_loop?
          loop_count += 1
        end
        @map[i][j] = EMPTY_SPACE
      end
    end
    loop_count
  end

  # Helpers =======================================

  def get_starting_position
    @map.each_with_index do |row, i|
      row.each_with_index do |sym, j|
        if sym == GUARD
          return [i, j]
        end
      end
    end
  end

  # returns the new direction after turning
  def turn
    @direction = TURNS[@direction]
  end

  def obstacle? row, col
    @map[row][col] == OBSTACLE
  end

  def empty_space? row, col
    @map[row][col] == EMPTY_SPACE
  end

  def on_map? row, col
    if row >= @map.size || row < 0 || col >= @map[row].size || col < 0
      return false
    end
    true
  end

  # return the row and col indexes of the next space
  def next_space
    next_row = @row + STEPS[@direction][:row_delta]
    next_col = @col + STEPS[@direction][:col_delta]

    [next_row, next_col]
  end

  # if the guard patrols the map in its current state, will the guard enter a loop?
  # if the guard comes back to a position they have already visited, going the same
  # direction they were before, we are in a loop
  def creates_loop?
    while on_map?(@row, @col)
      next_row, next_col = next_space
      if !on_map?(next_row, next_col)
        return false
      end
      if !obstacle?(next_row, next_col)
        if already_visited_in_same_dir?(next_row, next_col, @dir)
          return true
        end
        @row = next_row
        @col = next_col
        @positions_visited_w_dir[@dir] << [@row, @col]
      else
        turn
      end
    end
    false
  end

  def already_visited_in_same_dir? row, col, dir
    positions_visited_w_dir[dir].includes?([row, col]) ? true : false
  end

end

day_6 = Day6.new
