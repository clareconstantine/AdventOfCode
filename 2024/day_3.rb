PATH_SNIPPET = "day_3"
def main
  # input = File.open("./input/test_input.txt").readlines.map(&:chomp)
  input = File.open("./input/#{PATH_SNIPPET}.txt").readlines.map(&:chomp)[0]

  puts part_1(input)
  puts part_2(input)
end

# Constants =====================================

MUL_REGEX = /mul\(\d+,\d+\)/

DO_DONT_REGEX = /do\(\)|don't\(\)/

DO = "do()"

DONT = "don't()"

# Parts =========================================

def part_1 input
  total = 0
  # find all of the actual mul statements
  input.scan(MUL_REGEX) do |mul|
    # for each of those, get the two numbers out
    # multiply them
    # add the product to total
    total += evaluate_mul mul
  end
  total
end

def part_2 input
  total = 0
  mul_enabled = true

  # find all of the actual mul statements and their indexes
  # make an array [[match, index], ...]
  mul_and_idxs  = input.enum_for(:scan, MUL_REGEX).map { [Regexp.last_match.to_s, Regexp.last_match.begin(0)] }

  # find all of the do and don't statements and their indexes
  # make an array [[match, index], ...]
  do_dont_and_idxs = input.enum_for(:scan, DO_DONT_REGEX).map { [Regexp.last_match.to_s, Regexp.last_match.begin(0)] }

  # walk through both arrays
  # look at the next instruction index for both arrays and use whichever instruction has a smaller index

  # position in mul array
  i = 0

  # position in do_dont array
  j = 0

  while i < mul_and_idxs.size
    # no more do_donts or next instruction is mul
    if j >= do_dont_and_idxs.size || get_instruction_index(mul_and_idxs, i) < get_instruction_index(do_dont_and_idxs, j)
      # if mul enabled, add the product to the total
      if mul_enabled
        total += evaluate_mul(get_instruction(mul_and_idxs, i))
      end
      # move to next mul
      i += 1
    # next instruction is do_dont
    else
      if get_instruction(do_dont_and_idxs, j) == DO
        mul_enabled = true
      else
        mul_enabled = false
      end
      j += 1
    end
  end
  total
end

# Helpers =======================================

# returns the product when passed in a mul statement as a string
def evaluate_mul mul
  x, y = mul.scan(/\d+/)
  x.to_i * y.to_i
end

# for an array of the form [[instruction, idx], ...] returns the idx at index i
def get_instruction_index array, i
  array[i][1]
end

# for an array of the form [[instruction, idx], ...] returns the instruction at index i
def get_instruction array, i
  array[i][0]
end

# ===============================================

main
