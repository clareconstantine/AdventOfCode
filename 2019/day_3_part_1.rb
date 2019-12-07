require './day_3_part_1_input'

#
# This is a solution for https://adventofcode.com/2019/day/3
#

# generate a hash key from an x and y input
def key x, y
  "#{x}x#{y}y"
end

# input: [{direction: String, length: Integer}]
# output: [{x: Integer, y: Integer}]
def compute_coordinates wire
  coords = {}
  current_coord = {x: 0, y: 0}
  wire.each do |w|
    x, y = nil
    if w[:direction] == "R"
      w[:length].times do
        x = current_coord[:x] + 1
        y = current_coord[:y]
        c = {
          x: x,
          y: y
        }
        coords[key(x, y)] = c
        current_coord = c
      end
    elsif w[:direction] == "L"
      w[:length].times do
        x = current_coord[:x] - 1
        y = current_coord[:y]
        c = {
          x: x,
          y: y
        }
        coords[key(x, y)] = c
        current_coord = c
      end
    elsif w[:direction] == "U"
      w[:length].times do
        x = current_coord[:x]
        y = current_coord[:y] + 1
        c = {
          x: x,
          y: y
        }
        coords[key(x, y)] = c
        current_coord = c
      end
    elsif w[:direction] == "D"
      w[:length].times do
        x = current_coord[:x]
        y = current_coord[:y] - 1
        c = {
          x: x,
          y: y
        }
        coords[key(x, y)] = c
        current_coord = c
      end
    end
  end
  coords
end

# input: two arrays of the form [{x: Integer, y: Integer}]
# output: an integer representing the intersection of these two arrays that is the shortest
#         Manhattan distance from the origin
def closest_intersection c1, c2
  current_shortest_distance = nil
  c1.each do |k, v|
    if c2[k]
      this_distance = v[:x].abs + v[:y].abs
      if !current_shortest_distance || this_distance < current_shortest_distance
        current_shortest_distance = this_distance
      end
    end
  end
  current_shortest_distance
end

def find_closest_intersection wire_1, wire_2
  c1 = compute_coordinates wire_1
  c2 = compute_coordinates wire_2

  closest_intersection c1, c2
end

#--------------------------------------------------------------------

# Run on actual input:
puts find_closest_intersection Input::WIRE_1, Input::WIRE_2

#--------------------------------------------------------------------

# Provided test cases

ex0_w1 = [{direction: "R", length: 8},{direction: "U", length: 5},{direction: "L", length: 5},{direction: "D", length: 3}]
ex0_w2 = [{direction: "U", length: 7},{direction: "R", length: 6},{direction: "D", length: 4},{direction: "L", length: 4}]
ex0_expected = 6

ex1_w1 = [{direction: "R", length: 75},{direction: "D", length: 30},{direction: "R", length: 83},
  {direction: "U", length: 83},{direction: "L", length: 12},{direction: "D", length: 49},
  {direction: "R", length: 71},{direction: "U", length: 7},{direction: "L", length: 72}]
ex1_w2 = [{direction: "U", length: 62},{direction: "R", length: 66},{direction: "U", length: 55},
  {direction: "R", length: 34},{direction: "D", length: 71},{direction: "R", length: 55},
  {direction: "D", length: 58},{direction: "R", length: 83}]
ex1_expected = 159

ex2_w1 = [{direction: "R", length: 98},{direction: "U", length: 47},{direction: "R", length: 26},
  {direction: "D", length: 63},{direction: "R", length: 33},{direction: "U", length: 87},
  {direction: "L", length: 62},{direction: "D", length: 20},{direction: "R", length: 33},
  {direction: "U", length: 53},{direction: "R", length: 51}]
ex2_w2 = [{direction: "U", length: 98},{direction: "R", length: 91},{direction: "D", length: 20},
  {direction: "R", length: 16},{direction: "D", length: 67},{direction: "R", length: 40},
  {direction: "U", length: 7},{direction: "R", length: 15},{direction: "U", length: 6},
  {direction: "R", length: 7}]
ex2_expected = 135


# test with the examples...

ex0_actual = find_closest_intersection ex0_w1, ex0_w2
puts ex0_actual == ex0_expected ? "PASS" : "FAIL - expected #{ex0_expected}, got #{ex0_actual}"

ex1_actual = find_closest_intersection ex1_w1, ex1_w2
puts ex1_actual == ex1_expected ? "PASS" : "FAIL - expected #{ex1_expected}, got #{ex1_actual}"

ex2_actual = find_closest_intersection ex2_w1, ex2_w2
puts ex2_actual == ex2_expected ? "PASS" : "FAIL - expected #{ex2_expected}, got #{ex2_actual}"
