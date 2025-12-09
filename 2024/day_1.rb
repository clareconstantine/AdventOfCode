PATH_SNIPPET = "day_1"
def main
  left_list = []
  right_list = []

  # input = File.open("./input/test_input.txt").readlines.map(&:chomp)
  input = File.open("./input/#{PATH_SNIPPET}.txt").readlines.map do |line|line
    ids = line.chomp.split
    left_list << ids[0].to_i
    right_list << ids[1].to_i
  end

  left_list.sort!
  right_list.sort!

  puts part_1(left_list, right_list)
  puts part_2(left_list, right_list)
end

# Parts =========================================

def part_1 left_list, right_list
  total_distance = 0
  left_list.each_with_index do |left_id, i|
    right_id = right_list[i]
    total_distance += (left_id - right_id).abs
  end
  puts total_distance

  # puts left_list
  # puts "================"
  # puts right_list
end

def part_2 left_list, right_list
  frequencies = get_frequencies_of_left_in_right(left_list, right_list)

  get_similarity_score(left_list, frequencies)
end

# Helpers =======================================

def get_frequencies_of_left_in_right left_list, right_list
  # initialize hash with keys from left_list and defaultvalue 0
  frequencies = Hash[left_list.product([0])]

  # go through the right list and for each id, if it was in the left list, add 1 to its frequency
  right_list.each do |id|
    if frequencies.key? id
      frequencies[id] = frequencies[id] += 1
    end
  end
  frequencies
end

def get_similarity_score left_list, frequencies
  similarity_score = 0
  left_list.each do |id|
    similarity_score += id * frequencies[id]
  end
  similarity_score
end
# ===============================================

main
