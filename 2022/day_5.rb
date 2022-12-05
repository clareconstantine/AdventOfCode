def part_1 stacks, directions
  directions.each do |dir|
    dir = dir.split(',')
    num_to_move = dir[0].to_i
    from_stack = dir[1].to_i
    to_stack = dir[2].to_i

    num_to_move.times do
      crate = stacks[from_stack].pop
      stacks[to_stack].push(crate)
    end
  end
  stacks
end

def part_2 stacks, directions
  tmp_stack = []

  directions.each do |dir|
    dir = dir.split(',')
    num_to_move = dir[0].to_i
    from_stack = dir[1].to_i
    to_stack = dir[2].to_i

    # this workss too! had a typo in my input but thought it was in my algorithm.
    # stacks[to_stack] = stacks[to_stack] + stacks[from_stack].slice(stacks[from_stack].length - num_to_move, num_to_move)
    # stacks[from_stack] = stacks[from_stack].slice(0, stacks[from_stack].length - num_to_move)

    num_to_move.times do
      crate = stacks[from_stack].pop
      tmp_stack = tmp_stack.push(crate)
    end

    num_to_move.times do
      crate = tmp_stack.pop
      stacks[to_stack].push(crate)
    end
  end
  stacks
end

def top_crates stacks
  top_crates = ""
  stacks.each do |stack|
    if stack.last
      top_crates += stack.last
    end
  end

  top_crates
end

def starting_stacks
  [
    [], # bc the stack numbers start at 1
    ['S', 'L', 'W'],
    ['J', 'T', 'N', 'Q'],
    ['S', 'C', 'H', 'F', 'J'],
    ['T', 'R', 'M', 'W', 'N', 'G', 'B'],
    ['T', 'R', 'L', 'S', 'D', 'H', 'Q', 'B'],
    ['M', 'J', 'B', 'V', 'F', 'H', 'R', 'L'],
    ['D', 'W', 'R', 'N', 'J', 'M'],
    ['B', 'Z', 'T', 'F', 'H', 'N', 'D', 'J'],
    ['H', 'L', 'Q', 'N', 'B', 'F', 'T']
  ]
  # [
  #   [],
  #   ['Z', 'N'],
  #   ['M', 'C', 'D'],
  #   ['P']
  # ]
end

def main
  directions = File.open("day_5_input.txt").readlines.map(&:chomp)
  # directions = [
  #   "1,2,1",
  #   "3,1,3",
  #   "2,2,1",
  #   "1,1,2"
  # ]

  part_1_stacks = part_1(starting_stacks, directions)
  p top_crates(part_1_stacks)

  part_2_stacks = part_2(starting_stacks, directions)
  p top_crates(part_2_stacks)
end

main
