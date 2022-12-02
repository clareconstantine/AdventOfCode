def box_paper box
  sorted_dimensions = box.split('x').map(&:to_i).sort
  edge_1 = sorted_dimensions[0]
  edge_2 = sorted_dimensions[1]
  edge_3 = sorted_dimensions[2]

  face_1 = 2 * edge_1 * edge_2
  face_2 = 2 * edge_2 * edge_3
  face_3 = 2 * edge_3 * edge_1

  face_1 + face_2 + face_3 + edge_1 * edge_2
end

def main
  boxes = File.open("day_2_input.txt").readlines.map(&:chomp)
  total_paper = 0
  boxes.each do |box|
    total_paper += box_paper(box)
  end
  p total_paper
end

main
