input = File.open("day_1_input.txt").readlines.map(&:chomp)[0]

floor = 0

input.each_char do |char|
  if char == '('
    floor += 1
  elsif char == ')'
    floor -= 1
  end
end

p floor
