PATH_SNIPPET = "day_1"
def main
  input = File.open("./input/#{PATH_SNIPPET}.txt").readlines.map(&:chomp)

  total = 0
  input.each do |line|
    digits = line.scan /\d/
    first_digit = digits.first.to_i
    last_digit = digits.last.to_i

    total += first_digit * 10 + last_digit
  end

  puts total
end

main
