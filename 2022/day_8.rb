def part_1 forest
  num_visible = 0
  forest.each_with_index do |tree_row, y|
    tree_row.each do |tree, x|
      if visible
    end
  end

end

def part_2 forest

end

def main
  forest = File.open("input/day_8.txt").readlines.map do |line|
    line = line.chomp.chars.map(&:to_i)
    line
  end
  p forest
  p part_1(forest)
end

main
