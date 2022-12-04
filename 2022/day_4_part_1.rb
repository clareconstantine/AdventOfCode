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
  assignment_rows = File.open("day_4_input.txt").readlines.map(&:chomp)

  contained_assignment_count = 0
  assignment_rows.each do |row|
    if contained_assignment(row)
      contained_assignment_count += 1
    end
  end
  p contained_assignment_count
end

main
