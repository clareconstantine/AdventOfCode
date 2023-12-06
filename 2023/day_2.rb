PATH_SNIPPET = "day_2"

def main
  # games = File.open("./input/test_input.txt").readlines.map(&:chomp)
  games = File.open("./input/#{PATH_SNIPPET}.txt").readlines.map(&:chomp)

  puts part_1(games)
  puts part_2(games)
end

# Parts =========================================

def part_1(games)
  red_total = 12
  green_total = 13
  blue_total = 14

  id_sum = 0

  games.each do |game|
    id = game.split(':').first[5..].to_i
    possible = true
    cube_sets(game)

    cube_sets(game).each do |cubes|
      red = get_cube_count(cubes, "red")
      green = get_cube_count(cubes, "green")
      blue = get_cube_count(cubes, "blue")

      if red > red_total || green > green_total || blue > blue_total
        possible = false
      end
    end

    if possible
      id_sum += id
    end
  end

  id_sum
end

def part_2(games)
  power_sum = 0

  games.each do |game|
    power_sum += power_of_min_set_for_game(game)
  end

  power_sum
end

# Helpers =======================================

def get_cube_count(cubes, color)
  cubes.scan(/(\d*) #{color}/).flatten.first.to_i || 0
end

def cube_sets(game)
  game.split(':')[1].split(';')
end

def power_of_set(red, green, blue)
  red * green * blue
end

def power_of_min_set_for_game(game)
  min_red = 0
  min_green = 0
  min_blue = 0

  cube_sets(game).each do |cubes|
    red = get_cube_count(cubes, "red")
    green = get_cube_count(cubes, "green")
    blue = get_cube_count(cubes, "blue")

    min_red = red if red > min_red
    min_green = green if green > min_green
    min_blue = blue if blue > min_blue
  end

  power_of_set(min_red, min_green, min_blue)
end

# ===============================================

main
