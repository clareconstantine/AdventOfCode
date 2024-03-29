require 'tree'

def part_1 output
  output.shift()
  root = Tree::TreeNode.new("/", 0)
  cur_dir = root

  output.each_with_index do |line, i|
    if line[0] == '$'
      if line[1] == 'cd'
        if line[2] == '..'
          child_sum = 0
          cur_dir.children.each do |child|
            child_sum += child.content
          end
          cur_dir.content = child_sum
          # moving out a level
          cur_dir = cur_dir.parent
        else
          # moving in a level
          cur_dir = cur_dir.children.select {|c| c.name.include?(line[2])}.first
        end
      elsif line[1] == 'ls'
        # don't do anything, the next lines will list files in this directory
      end
    elsif line[0] == 'dir'
      new_dir = Tree::TreeNode.new("#{line[1]}#{i}", 0)
      cur_dir.add(new_dir)
    else
      # make node for file with its size as the content
      size = line[0].to_i
      filename = line[1]
      new_file = Tree::TreeNode.new("#{filename}#{i}", size)
      cur_dir.add(new_file)
    end
  end

  root
end

def find_part_1_answer root
  sum = 0

  root.each do |node|
    if node.content <= 100000 && !node.leaf?
      sum += node.content
    end
  end

  sum
end

def part_2 root
  total_disk_space = 70000000
  required_unused_space = 30000000

  # set size on root
  sum = 0
  root.children.each do |node|
    sum += node.content
  end
  root.content = sum

  current_unused_space = total_disk_space - root.content
  space_to_delete = required_unused_space - current_unused_space
  size_of_smallest_directory_to_delete(root, space_to_delete)
end

def size_of_smallest_directory_to_delete root, space_to_delete
  node_to_delete = root
  root.each do |node|
    if !node.leaf? && node.content >= space_to_delete && node.content < node_to_delete.content
      node_to_delete = node
    end
  end
  node_to_delete.content
end

def main
  output = File.open("input/day_7.txt").readlines.map do |line|
    line = line.chomp.split()
    line
  end

  # output = File.open("input/test_input.txt").readlines.map do |line|
  #   line = line.chomp.split()
  #   line
  # end

  file_tree_with_sizes = part_1(output)
  p find_part_1_answer(file_tree_with_sizes)
  p part_2(file_tree_with_sizes)
end

main
