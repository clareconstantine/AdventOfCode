#
# This is a solution for https://adventofcode.com/2019/day/10
#

ASTEROID = '#'
SPACE = '.'

class Asteroid
  def initialize (x, y)
    @x = x
    @y = y
  end

  def x
    @x
  end

  def y
    @y
  end
end

class AsteroidMap
  def initialize
    @asteroid_map = {}
    rows = File.open("input/day_10.txt").readlines.map(&:chomp)
    @width = rows[0].length
    @height = rows.length

    rows.each_with_index do |row, y|
      row.chars.each_with_index do |symbol, x|
        if symbol == ASTEROID
          @asteroid_map["x#{x}y#{y}"] = Asteroid.new(x, y)
        end
      end
    end
  end

  def station_location
    # for each map position if if is an asteroid,
    # could calculate all slopes, find first two asteroids on that line in the map
    current_best_location = @asteroid_map.values.first
    max_visible_asteroids = 0

    @asteroid_map.each do |key, candidate|
      blocked_asteroids = {}
      @asteroid_map.each do |key, asteroid|
        unless (candidate.x == asteroid.x && candidate.y == asteroid.y) || blocked_asteroids["x#{asteroid.x}y#{asteroid.y}"]
          original_dx =  asteroid.x - candidate.x
          original_dy =  asteroid.y - candidate.y
          reduced_dxdy = simplify original_dx, original_dy
          dx = reduced_dxdy[:dx]
          dy = reduced_dxdy[:dy]

          current_x = asteroid.x + dx
          current_y = asteroid.y + dy
          while current_x <= @width  && current_x >= 0 && current_y <= @height && current_y >= 0
            if @asteroid_map["x#{current_x}y#{current_y}"]
              blocked_asteroids["x#{current_x}y#{current_y}"] = @asteroid_map["x#{current_x}y#{current_y}"]
            end
            current_x += dx
            current_y += dy
          end
        end
      end
      visible_asteroids = @asteroid_map.size - blocked_asteroids.size - 1
      if visible_asteroids > max_visible_asteroids
        max_visible_asteroids = visible_asteroids
        current_best_location = candidate
      end
    end
    puts "Asteroid: #{current_best_location.x}, #{current_best_location.y}"
    puts "Num visible: #{max_visible_asteroids}"
  end

  private

  # reduce by dividing by gcd
  def simplify dx, dy
    # puts "dx: #{dx}"
    # puts "dy: #{dy}"
    gcd = dx.gcd(dy)
    # puts "gcd: #{gcd}"

    while gcd > 1
      dx = dx/gcd
      dy = dy/gcd
      gcd = dx.gcd(dy)
    end
    {dx: dx, dy: dy}
  end
end

asteroid_map = AsteroidMap.new()
asteroid_map.station_location
