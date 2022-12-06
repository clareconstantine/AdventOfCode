input = File.open("input/day_1.txt").readlines.map(&:chomp)[0]

floor = 0

input.each_char.with_index do |char, i|
  if char == '('
    floor += 1
  elsif char == ')'
    floor -= 1
  end
  if floor == -1
    p i+1
    break
  end
end
