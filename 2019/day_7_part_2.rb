#
# This is a solution for https://adventofcode.com/2019/day/7
# it builds off the code from day 5
#
# heavily inspred by Mateusz Przybył's solution:
# https://github.com/MrSimbax/Advent_Of_Code_2019/blob/master/day7.jl
#

class Amplifier
  def initialize
    @memory = [3,8,1001,8,10,8,105,1,0,0,21,46,55,72,85,110,191,272,353,434,99999,3,9,1002,9,5,9,1001,9,2,9,102,3,9,9,101,2,9,9,102,4,9,9,4,9,99,3,9,102,5,9,9,4,9,99,3,9,1002,9,2,9,101,2,9,9,1002,9,2,9,4,9,99,3,9,1002,9,4,9,101,3,9,9,4,9,99,3,9,1002,9,3,9,101,5,9,9,1002,9,3,9,101,3,9,9,1002,9,5,9,4,9,99,3,9,1001,9,2,9,4,9,3,9,101,2,9,9,4,9,3,9,101,2,9,9,4,9,3,9,1001,9,2,9,4,9,3,9,102,2,9,9,4,9,3,9,102,2,9,9,4,9,3,9,102,2,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,102,2,9,9,4,9,3,9,1002,9,2,9,4,9,99,3,9,102,2,9,9,4,9,3,9,102,2,9,9,4,9,3,9,1001,9,1,9,4,9,3,9,1001,9,1,9,4,9,3,9,1002,9,2,9,4,9,3,9,1001,9,2,9,4,9,3,9,102,2,9,9,4,9,3,9,101,1,9,9,4,9,3,9,1001,9,1,9,4,9,3,9,101,2,9,9,4,9,99,3,9,1002,9,2,9,4,9,3,9,1001,9,2,9,4,9,3,9,101,2,9,9,4,9,3,9,1001,9,1,9,4,9,3,9,1002,9,2,9,4,9,3,9,1001,9,1,9,4,9,3,9,1001,9,1,9,4,9,3,9,1001,9,2,9,4,9,3,9,1001,9,1,9,4,9,3,9,101,2,9,9,4,9,99,3,9,1001,9,2,9,4,9,3,9,102,2,9,9,4,9,3,9,101,2,9,9,4,9,3,9,1001,9,2,9,4,9,3,9,1001,9,2,9,4,9,3,9,1002,9,2,9,4,9,3,9,102,2,9,9,4,9,3,9,1002,9,2,9,4,9,3,9,1002,9,2,9,4,9,3,9,1001,9,1,9,4,9,99,3,9,101,1,9,9,4,9,3,9,102,2,9,9,4,9,3,9,102,2,9,9,4,9,3,9,1001,9,2,9,4,9,3,9,1002,9,2,9,4,9,3,9,1002,9,2,9,4,9,3,9,102,2,9,9,4,9,3,9,102,2,9,9,4,9,3,9,1001,9,2,9,4,9,3,9,1001,9,2,9,4,9,99]
  end

  def set_output_amp amp
    @output_amp = amp
  end

  def terminated?
    @terminated
  end

# Runs the amplifier starting from instruction at index 'i' (by default 0).
# 'input' is a queue with input to the program.
# 'output' is a queue with output of the program.
# Returns...
#     * 0 if program ended normally (reached halt instruction
#       or instruction pointer is out of bounds)
#     * current 'i' if program is waiting for input but 'input' is empty;
#       run the amp again with this 'i' after filling 'input'
#       to resume execution
  def compute input, output, i = 0
    while i < @memory.length
      opcode = @memory[i] % 100 # the opcode is the 1's and 10's place

      modes = get_modes(@memory[i])
      mode_1 = modes[0]
      mode_2 = modes[1]
      mode_3 = modes[2]

      if [1, 2, 4, 5, 6, 7, 8].include? opcode
        param_1 = @memory[(position?(mode_1) ? @memory[i+1] : i+1)]
      end

      if [1, 2, 5, 6, 7, 8].include? opcode
        param_2 = @memory[(position?(mode_2) ? @memory[i+2] : i+2)]
      end

      if opcode == 1
        # add
        @memory[(position?(mode_3) ? @memory[i+3] : i+3)] = param_1 + param_2
        i += 4
      elsif opcode == 2
        # multiply
        @memory[(position?(mode_3) ? @memory[i+3] : i+3)] = param_1 * param_2
        i += 4
      elsif opcode == 3
        # input
        @memory[(position?(mode_1) ? @memory[i+1] : i+1)] = input.shift
        i += 2
      elsif opcode == 4
        # output
        output.push param_1
        i += 2
        return i
      elsif opcode == 5
        # jump-if-true
        if param_1 != 0
          i = param_2
        else
          i += 3
        end
      elsif opcode == 6
        # jump-if-false
        if param_1 == 0
          i = param_2
        else
          i += 3
        end
      elsif opcode == 7
        # less than
        @memory[(position?(mode_3) ? @memory[i+3] : i+3)] = (param_1 < param_2 ? 1 : 0)
        i += 4
      elsif opcode == 8
        # equals
        @memory[(position?(mode_3) ? @memory[i+3] : i+3)] = (param_1 == param_2 ? 1 : 0)
        i += 4
      elsif opcode == 99
        # halt
        return nil
      end
    end
  end

  private

  def position? mode
    mode == 0
  end

  # return an array with the modes for the params (always length 3)
  def get_modes instruction
    modes = instruction.to_s.chars.map(&:to_i)
    while modes.length < 5
      modes.unshift 0
    end
    modes[0..2]
    # flip the order so they are in order of the param order
    # [param_1_mode, param_2_mode, param_3_mode]
    modes = [modes[2], modes[1], modes[0]]
  end
end

def phase_permutations phases
  phases.permutation.to_a
end

# Runs the given amps in a loop until all of them halt.
# 'inputs' and 'outputs' are input and output queues for the amps,
# as arrays of arrays of ints.
# If an amp is waiting for input and is not be provided with any,
# it will run forever.
def run_amps amps, inputs, outputs
  num_amps = amps.length
  pid = 0
  programs_running = num_amps
  instruction_indices = Array.new(5) { 0 }
  while programs_running > 0
    if instruction_indices[pid]
      instruction_indices[pid] = amps[pid].compute(inputs[pid], outputs[pid], instruction_indices[pid])
      if !instruction_indices[pid]
        programs_running -= 1
      end
    end

    pid += 1
    if pid > num_amps
      pid = 0
    end
  end
end

def main
  max_output = 0

  phase_permutations([5, 6, 7, 8, 9]).each do |phases|
    amps = Array.new(5) { Amplifier.new }

    inputs = []
    outputs = []

    inputs[0] = outputs[4] = [phases[0], 0]
    inputs[1] = outputs[0] = [phases[1]]
    inputs[2] = outputs[1] = [phases[2]]
    inputs[3] = outputs[2] = [phases[3]]
    inputs[4] = outputs[3] = [phases[4]]

    run_amps(amps, inputs, outputs)

    max_output = outputs[4].first if outputs[4].first > max_output
  end

  max_output
end

puts main







