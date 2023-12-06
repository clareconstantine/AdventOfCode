PATH_SNIPPET = "day_1"

def part_1
  input = File.open("./input/#{PATH_SNIPPET}.txt").readlines.map(&:chomp)

  total = 0
  input.each do |line|
    digits = line.scan /\d/
    first_digit = digits.first.to_i
    last_digit = digits.last.to_i

    total += first_digit * 10 + last_digit
  end

  total
end

def part_2
  input = File.open("./input/#{PATH_SNIPPET}.txt").readlines.map(&:chomp)
  # input = File.open("./input/test_input.txt").readlines.map(&:chomp)

  total = 0
  input.each do |line|
    digits = line.scan(/(?=(\d|one|two|three|four|five|six|seven|eight|nine|zero))/).flatten
    first_digit = DIGIT_DICT[digits.first] ? DIGIT_DICT[digits.first] : digits.first.to_i
    last_digit = DIGIT_DICT[digits.last] ? DIGIT_DICT[digits.last] : digits.last.to_i

    value = first_digit * 10 + last_digit
    total += value
  end

  total
end

DIGIT_DICT = {
  "zero" => 0,
  "one" => 1,
  "two" => 2,
  "three" => 3,
  "four" => 4,
  "five" => 5,
  "six" => 6,
  "seven" => 7,
  "eight" => 8,
  "nine" => 9
}

def main
  # puts part_1

  puts part_2
end

main
