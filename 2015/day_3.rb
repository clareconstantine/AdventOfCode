def part_1 directions
  x = 0
  y = 0
  visited = { "0,0": 1 }

  directions.each do |dir|
    case dir
    when '^'
      y += 1
    when 'v'
      y -= 1
    when '>'
      x += 1
    when '<'
      x -= 1
    end

    if visited["#{x},#{y}"]
      visited["#{x},#{y}"] += 1
    else
      visited["#{x},#{y}"] = 1
    end
  end
  p visited.size
end

def part_2 directions
  santa_x = 0
  santa_y = 0

  robo_x = 0
  robo_y = 0

  visited = { "0,0" => 2 }
  directions.each_with_index do |dir, i|
    case dir
    when '^'
      i.even? ? santa_y += 1 : robo_y += 1
    when 'v'
      i.even? ? santa_y -= 1 : robo_y -= 1
    when '>'
      i.even? ? santa_x += 1 : robo_x += 1
    when '<'
      i.even? ? santa_x -= 1 : robo_x -= 1
    end

    if i.even?
      if visited["#{santa_x},#{santa_y}"]
        visited["#{santa_x},#{santa_y}"] += 1
      else
        visited["#{santa_x},#{santa_y}"] = 1
      end
    else
      if visited["#{robo_x},#{robo_y}"]
        visited["#{robo_x},#{robo_y}"] += 1
      else
        visited["#{robo_x},#{robo_y}"] = 1
      end
    end
  end
  p visited.size
end

def main
  directions = File.open("input/day_3.txt").readlines.map(&:chomp)[0].chars

  p "part 1: #{part_1(directions)}"
  p "part 2: #{part_2(directions)}"
end

main
