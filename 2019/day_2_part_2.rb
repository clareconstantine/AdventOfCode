#
# This is a solution for https://adventofcode.com/2019/day/2#part2
#

def day_2_part_2
  noun = 0
  verb = 0

  while noun < 100
    while verb < 100
      if compute(noun, verb) == 19690720
        return (100 * noun) + verb
      end
      verb += 1
    end
    noun += 1
    verb = 0
  end
end

def compute noun, verb
  memory = [1,noun,verb,3,1,1,2,3,1,3,4,3,1,5,0,3,2,1,13,19,2,9,19,23,1,23,6,27,1,13,27,31,1,31,10,35,1,9,35,39,1,39,9,43,2,6,43,47,1,47,5,51,2,10,51,55,1,6,55,59,2,13,59,63,2,13,63,67,1,6,67,71,1,71,5,75,2,75,6,79,1,5,79,83,1,83,6,87,2,10,87,91,1,9,91,95,1,6,95,99,1,99,6,103,2,103,9,107,2,107,10,111,1,5,111,115,1,115,6,119,2,6,119,123,1,10,123,127,1,127,5,131,1,131,2,135,1,135,5,0,99,2,0,14,0]
  i = 0

  while i < memory.length
    if memory[i] == 1
      memory[memory[i+3]] = memory[memory[i+2]] + memory[memory[i+1]]
      i += 4
    elsif memory[i] == 2
      memory[memory[i+3]] = memory[memory[i+2]] * memory[memory[i+1]]
      i += 4
    elsif memory[i] == 99
      break
    end
  end
  memory[0]
end

puts day_2_part_2
