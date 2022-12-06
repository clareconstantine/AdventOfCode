def overlapping_assignment row
  endpoints = row.split(/[-,\,]/).map(&:to_i)
  elf_1_start = endpoints[0]
  elf_1_end = endpoints[1]
  elf_2_start = endpoints[2]
  elf_2_end = endpoints[3]
  p endpoints
  if (elf_1_start >= elf_2_start && elf_1_start <= elf_2_end) || (elf_1_end >= elf_2_start && elf_1_end <= elf_2_end)
    p "^ true"
    return true
  else
    p "^ false"
    return false
  end
end

def contained_assignment row
  endpoints = row.split(/[-,\,]/).map(&:to_i)
  elf_1_start = endpoints[0]
  elf_1_end = endpoints[1]
  elf_2_start = endpoints[2]
  elf_2_end = endpoints[3]

  if (elf_1_start <= elf_2_start && elf_1_end >= elf_2_end) || (elf_2_start <= elf_1_start && elf_2_end >= elf_1_end)
    return true
  else
    return false
  end
end

def main
  assignment_rows = File.open("input/day_4.txt").readlines.map(&:chomp)
  # assignment_rows = [
  #   "2-4,6-8",
  #   "2-3,4-5",
  #   "5-7,7-9",
  #   "2-8,3-7",
  #   "6-6,4-6",
  #   "2-6,4-8"
  # ]

  overlapping_assignment_count = 0
  assignment_rows.each do |row|
    if overlapping_assignment(row) || contained_assignment(row)
      overlapping_assignment_count += 1
    end
  end
  p overlapping_assignment_count
end

main
