def update_lights directions, lights, switch_function
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
            light = method(switch_function).call(action, light)
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

def on_off_switch action, light
  case action
  when "toggle"
    !light
  when "on"
    true
  else
    false
  end
end

def brightness_switch action, light
  case action
  when "toggle"
    light += 2
  when "on"
    light += 1
  else
    light > 0 ? light -= 1 : 0
  end
  light
end

def num_lights_on light_rows
  count = 0
  light_rows.each do |row|
    count += row.count(true)
  end
  count
end

def total_brightness (light_rows)
  total = 0
  light_rows.each do |row|
    total += row.sum
  end
  total
end

def part_1 directions
  lights = Array.new(1000, Array.new(1000, false))
  lights = update_lights(directions, lights, :on_off_switch)
  num_lights_on(lights)
end

def part_2 directions
  lights = Array.new(1000, Array.new(1000, 0))
  lights = update_lights(directions, lights, :brightness_switch)
  total_brightness(lights)
end

def main
  directions = File.open("day_6_input.txt").readlines.map do |dir|
    dir.chomp.split(',')
  end

  p part_1(directions)
  p part_2(directions)
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
