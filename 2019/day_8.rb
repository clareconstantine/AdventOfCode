#
# This is a solution for https://adventofcode.com/2019/day/8
#

WIDTH = 25
HEIGHT = 6

BLACK = "0"
WHITE = "1"
TRANSPARENT = "2"

def image_layers width, height
  image_data = File.read("input/day_8.txt").chomp.chars
  layers = []
  while image_data.length > 0
    layers.push(image_data.shift(width*height))
  end
  layers
end

# part 1

def part_1 layers
  min_0_count = WIDTH * HEIGHT + 1
  solution = nil
  layers.each do |layer|
    count_0 = 0
    count_1 = 0
    count_2 = 0
    layer.each do |pixel|
      case pixel
      when "0"
        count_0 += 1
      when "1"
        count_1 += 1
      when "2"
        count_2 += 1
      end
    end
    if count_0 < min_0_count
      min_0_count = count_0
      solution = count_1 * count_2
    end
  end
  puts "Part 1: #{solution}"
end

# part 2

def visible_pixels layers
  visible_pixels = []
  i = 0
  while i < layers.first.length
    ith_pixels = layers.map {|layer| layer[i]}
    visible_pixel = ith_pixels.find{|pix| pix != TRANSPARENT }
    # replace black with ' ' to make it easier to see image
    visible_pixel = ' ' if visible_pixel == BLACK
    visible_pixels.push(visible_pixel)
    i += 1
  end
  visible_pixels
end

def print_image layer
  HEIGHT.times do
    puts layer.shift(WIDTH).join
  end
end

def part_2 layers
  visible_layer = visible_pixels layers

  print_image visible_layer
end

layers = image_layers WIDTH, HEIGHT

part_1 layers
part_2 layers


