PATH_SNIPPET = "day_5"

class Almanac

  def initialize
    # @input = File.open("./input/test_input.txt").readlines.map(&:chomp)
    # @part_1_seeds = @input.first[7, @input.first.length - 7].split(' ').flatten.map(&:to_i)
    # # puts @part_1_seeds
    # @maps = [
    #   build_map(4, 5),
    #   build_map(8, 10),
    #   build_map(13, 16),
    #   build_map(19, 20),
    #   build_map(23, 25),
    #   build_map(28, 29),
    #   build_map(32, 33)
    # ]
    # # puts @maps.inspect

    # @part_2_seeds = [[79, 14], [55, 13]]

    @input = File.open("./input/#{PATH_SNIPPET}.txt").readlines.map(&:chomp)
    @part_1_seeds = @input.first[7, @input.first.length - 7].split(' ').flatten.map(&:to_i)
    @maps = [
      build_map(4, 48),
      build_map(51, 70),
      build_map(73, 98),
      build_map(101, 139),
      build_map(142, 185),
      build_map(188, 223),
      build_map(226, 236)
    ]

    @part_2_seeds = [
      [3489262449, 222250568],
      [2315397239, 327729713],
      [1284963, 12560465],
      [1219676803, 10003052],
      [291763704, 177898461],
      [136674754, 107182783],
      [2917625223, 260345082],
      [1554280164, 216251358],
      [3900312676, 5629667],
      [494259693, 397354410]
    ]
  end

  # Parts =========================================

  # find the lowest location number that corresponds to a seed number
  def part_1
    lowest_location_number = nil
    @part_1_seeds.each do |seed|
      location = location_for_seed(seed)
      lowest_location_number = location if lowest_location_number == nil || location < lowest_location_number
    end
    lowest_location_number
  end

  def part_2
    location = 0
    while true
      seed = seed_for_location(location)
      if seed_exists(seed)
        return location
      end
      location += 1
    end
  end

  # Helpers =======================================

  def build_map(first_line, last_line)
    @input[first_line - 1, last_line - (first_line - 1)].map {|line| line.split(' ').flatten.map(&:to_i)}
  end

  # input: source
  # output: destination
  def lookup(map_index, source)
    destination = nil
    # puts source
    @maps[map_index].each do |range|
      dest_range_start = range[0]
      source_range_start = range[1]
      range_length = range[2]
      # we found the range that includes the source
      if source >= source_range_start && source < source_range_start + range_length
        destination = dest_range_start + (source - source_range_start)
      end
    end
    return source if !destination
    destination
  end

  # input: destination
  # output: source
  def reverse_lookup(map_index, destination)
    source = nil
    # puts source
    @maps[map_index].each do |range|
      dest_range_start = range[0]
      source_range_start = range[1]
      range_length = range[2]
      # we found the range that includes the destination
      if destination >= dest_range_start && destination < (dest_range_start + range_length)
        source = destination - dest_range_start + source_range_start
      end
    end
    return destination if !source
    source
  end

  def location_for_seed(seed)
    key = seed
    @maps.length.times do |map_index|
      key = lookup(map_index, key)
    end

    key
  end

  def seed_for_location(location)
    key = location
    @maps.length.times do |map_index|
      key = reverse_lookup(@maps.length - 1 - map_index, key)
    end

    key
  end

  def seed_exists(seed)
    @part_2_seeds.each do |range|
      return true if seed >= range[0] && seed < range[0] + range[1]
    end
    false
  end

  # ===============================================
end

almanac = Almanac.new
puts almanac.part_1
puts almanac.part_2

