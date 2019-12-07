#
# This is a solution for https://adventofcode.com/2019/day/4
#

input = 125730..579381

# Part 1: Count valid passwords in the input range that meet the following criteria:
#   - It is a six-digit number.
#   - The value is within the range given in your puzzle input.
#   - Two adjacent digits are the same (like 22 in 122345).
#   - Going from left to right, the digits never decrease; they only ever increase or stay the same (like 111123 or 135679).

module Enumerable
  def sorted?
    each_cons(2).all? { |a, b| (a <=> b) <= 0 }
  end
end

def count_valid_passwords_part_1 range
  valid_pw_count = 0

  range.each do |pw|
    digits = pw.to_s.chars.map(&:to_i)
    if digits.sorted? && digits.uniq.length != digits.length
      valid_pw_count += 1
    end
  end

  valid_pw_count
end

puts count_valid_passwords_part_1 input

# Part 2: Same as above but the passwords must contain at least one repeated digit that ONLY APPEARS TWICE

def contains_pair digits
  valid = false
  current_digit = digits.first
  current_count = 0
  digits.each do |d|
    if d == current_digit
      current_count += 1
    else
      if current_count == 2
        valid = true
      end
      current_count = 1
      current_digit = d
    end
  end
  if current_count == 2
    valid = true
  end
  valid
end

def count_valid_passwords_part_2 range
  valid_pw_count = 0

  range.each do |pw|
    digits = pw.to_s.chars.map(&:to_i)
    if digits.sorted? && contains_pair(digits)
      valid_pw_count += 1
    end
  end

  valid_pw_count
end

puts count_valid_passwords_part_2 input
