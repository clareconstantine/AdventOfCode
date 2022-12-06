def box_paper box
  sorted_dimensions = box.split('x').map(&:to_i).sort
  edge_1 = sorted_dimensions[0]
  edge_2 = sorted_dimensions[1]
  edge_3 = sorted_dimensions[2]

  face_1 = 2 * edge_1 * edge_2
  face_2 = 2 * edge_2 * edge_3
  face_3 = 2 * edge_3 * edge_1

  face_1 + face_2 + face_3 + (edge_1 * edge_2)
end

def box_ribbon box
  sorted_dimensions = box.split('x').map(&:to_i).sort
  edge_1 = sorted_dimensions[0]
  edge_2 = sorted_dimensions[1]
  edge_3 = sorted_dimensions[2]

  (2 * edge_1) + (2 * edge_2) + (edge_1 * edge_2 * edge_3)
end

def main
  boxes = File.open("input/day_2.txt").readlines.map(&:chomp)

  total_paper = 0
  total_ribbon = 0

  boxes.each do |box|
    total_paper += box_paper(box)
    total_ribbon += box_ribbon(box)
  end
  p "total paper: #{total_paper}"
  p "total ribbon: #{total_ribbon}"
end

main
