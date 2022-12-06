#
# This is a solution for https://adventofcode.com/2019/day/10#part2
#

class Asteroid
  attr_reader :x
  attr_reader :y

  attr_accessor :distance_from_base
  attr_accessor :angle_from_base

  def initialize (x, y)
    @x = x
    @y = y
  end
end

class AsteroidMap
  ASTEROID = '#'
  SPACE = '.'
  BASE_X = 19
  BASE_Y = 11

  def initialize
    @asteroid_map = {}
    rows = File.open("input/day_10.txt").readlines.map(&:chomp)
    @width = rows[0].length
    @height = rows.length

    rows.each_with_index do |row, y|
      row.chars.each_with_index do |symbol, x|
        if symbol == ASTEROID
          if x == BASE_X && y == BASE_Y
            @station_location = Asteroid.new(x, y)
          else
            asteroid = Asteroid.new(x, y)
            asteroid.distance_from_base = distance_from_base(asteroid)
            asteroid.angle_from_base = angle_from_base(asteroid)
            @asteroid_map["x#{x}y#{y}"] = @asteroid_map["x#{x}y#{y}"] ? @asteroid_map["x#{x}y#{y}"].push(asteroid) : [asteroid]
          end
        end
      end
    end
  end

  def station_location
    @station_location
  end

  private

  # reduce by dividing by gcd
  def simplify dx, dy
    gcd = dx.gcd(dy)

    while gcd > 1
      dx = dx/gcd
      dy = dy/gcd
      gcd = dx.gcd(dy)
    end
    {dx: dx, dy: dy}
  end

  def distance_from_base(asteroid)
    Math.sqrt(((asteroid.x - BASE_X)**2 + (asteroid.y - BASE_Y)**2).abs)
  end

  def angle_from_base(asteroid)
    dx =  asteroid.x - BASE_X
    dy =  asteroid.y - BASE_Y
    Math.atan2(dy, dx)
  end
end

  # for each asteroid, calculates slope and distance to them
  # pay atention to pos and neg x and y to determine the order in which they will be
  # encountered - perhaps store them in {slope: [{x,y}, {x,y}]} and sort each array
  # based on distance or manhattan disatance to the points
  # sort based on slope as well - ?
  # then remove the closest one from each array as it goes around?


  # what if up is a 0 angle, then calculate angle to asteroids from straight up.
  # within those groups, order by distance, and as the laser moves, remove the
  # closest asteroid in each group it hits

asteroid_map = AsteroidMap.new()
asteroid_map

