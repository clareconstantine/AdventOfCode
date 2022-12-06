#
# This is a solution for https://adventofcode.com/2019/day/6
#

class SpaceObject
  def initialize id
    @id = id
    @orbited_by = []
    @num_orbits = nil
  end

  # children
  def orbited_by
    @orbited_by
  end

  def add_orbiter space_object
    @orbited_by.push space_object
  end



  def get_total_orbits
    if @orbited_by.empty?
      @num_orbits = 0
    end

    if !@num_orbits
      @num_orbits = 0
      @orbited_by.each do |space_object|
        @num_orbits += space_object.get_total_orbits + 1
      end
    end
     @num_orbits
  end
end

class UniversalOrbitMap
  def initialize
    orbit_map = {}
    unprocessed_map = File.open("input/day_6.txt").readlines.map(&:chomp)
    unprocessed_map.each do |orbit|
      orbiter_id = orbit.split(')')[1]
      orbited_id = orbit.split(')')[0]

      # create orbiter if it's not in map yet
      if !orbit_map[orbiter_id]
        orbit_map[orbiter_id] = SpaceObject.new(orbiter_id)
      end

      # create parent if it's not in map yet
      if !orbit_map[orbited_id]
        orbit_map[orbited_id] = SpaceObject.new(orbited_id)
      end
      # add orbiter as a child
      orbit_map[orbited_id].add_orbiter orbit_map[orbiter_id]
    end
    @map = orbit_map
  end

  def map
    @map
  end
end

# part 1
map = UniversalOrbitMap.new().map
map.each do |id, space_object|
  space_object.get_total_orbits
end

total_orbits = 0
map.each do |id, space_object|
  total_orbits += space_object.get_total_orbits
end

puts "TOTAL: #{total_orbits}"






