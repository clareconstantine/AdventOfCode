def part_1 stream
  find_marker(stream, 4)
end

def part_2 stream
  find_marker(stream, 14)
end

def find_marker stream, marker_length
  marker_candidate = []

  stream.each_with_index do |char, i|
    marker_candidate.push(char)
    if i > marker_length - 1
      marker_candidate.shift
    end
    if marker_candidate.uniq.length == marker_length
      return i + 1
    end
  end
end

def main
  stream = File.open("input/day_6.txt").readlines.map(&:chomp)[0].chars

  p part_1(stream)
  p part_2(stream)
end

main
