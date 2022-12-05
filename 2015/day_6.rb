def update_lights directions
  lights = Array.new(1000, Array.new(1000, false))
  directions.each do |dir|
    action = dir[0]
    x_start = dir[1].to_i
    y_start = dir[2].to_i
    x_end = dir[3].to_i
    y_end = dir[4].to_i

    lights = lights.each_with_index.map do |light_row, i|
      if i >= y_start && i <= y_end # the row is in range
        light_row = light_row.each_with_index.map do |light, j|
          if j >= x_start && j <= x_end # the light is in range
            light = switch(action, light)
          end
          light
        end
      end
      light_row
    end
    lights
  end
  lights
end

def switch action, light
  case action
  when "toggle"
    !light
  when "on"
    true
  else
    false
  end
end

def count_lights light_rows
  count = 0
  light_rows.each do |row|
    count += row.count(true)
  end
  count
end

def part_1 directions
  lights = update_lights(directions)
  count_lights(lights)
end

def part_2 directions

end

def main
  directions = File.open("day_6_input.txt").readlines.map do |dir|
    dir.chomp.split(',')
  end

  p part_1(directions)
  # p part_2(directions)
end

main

# y
# [
# 0  [0, 1, 2, ... 999], x
# 1  [],
# 2  [],
# ...
# 999 [],
# ]
