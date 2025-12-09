PATH_SNIPPET = "day_5"
def main
  # input = File.open("./input/test_input.txt").readlines.map(&:chomp)
  input = File.open("./input/#{PATH_SNIPPET}.txt").readlines.map(&:chomp)

  # come_before: hash of the rules for what pages the key page must come before
  #   key: page that must come first
  #   value: array of the pages that must come after the key page
  # divider_index: the indiex of the blank line in the index
  come_before, divider_index = create_come_before_hash(input)

  # each list of pages is an array of ints
  lists = create_lists(input, divider_index)

  # p divider_index
  # p come_before.inspect
  # p lists.inspect
  puts part_1(lists, come_before)
  puts part_2(lists, come_before)
end

# Constants =====================================

# Parts =========================================

def part_1 lists, come_before
  total = 0
  lists.each do |list|
    if correct_order?(list, come_before)
      total += get_middle_number(list)
    end
  end
  total
end

def part_2 lists, come_before
  incorrect_lists = get_incorrect_lists(lists, come_before)

  total = 0
  incorrect_lists.each do |list|
    total += get_middle_number(correct_list(list, come_before))
  end
  total
end

# Helpers =======================================

# make a hash from the rules:
#   75|21
#   75|6
#   35|3
# come_before: {75: [21, 6], 35: [3]}
#
# also return the index of the blank line in the input
def create_come_before_hash input
  divider_index = nil

  come_before = {}
  input.each_with_index do |line, i|
    if line == ""
      divider_index = i
      break
    end
    before, after = line.scan(/\d+/)
    if come_before[before.to_i]
      come_before[before.to_i] << after.to_i
    else
      come_before[before.to_i] = [after.to_i]
    end
  end

  [come_before, divider_index]
end

# array of lists of page numbers (each page list is also an array)
def create_lists input, divider_index
  lists = []
  input.each_with_index do |line, i|
    if i > divider_index
      lists << line.split(',').map(&:to_i)
    end
  end
  lists
end

def correct_order? list, come_before
  list.each_with_index do |_ , i|
    cur_page_i = i
    later_page_i = i + 1
    cur_page = list[cur_page_i]
    while later_page_i < list.size
      later_page = list[later_page_i]
      # if the later page is supposed to be before the current page, then a rule is broken and we return false
      if come_before[later_page]&.include?(cur_page)
        return false
      end
      later_page_i += 1
    end
  end
  true
end

def get_middle_number list
  list[list.size / 2]
end

def get_incorrect_lists lists, come_before
  incorrect_lists = []
  lists.each do |list|
    if !correct_order?(list, come_before)
      incorrect_lists << list
    end
  end
  incorrect_lists
end

# put the pages in the list in order so that they follow the come_before rules
def correct_list list, come_before
  # keep running through the list and moving pages until it's correct
  while !correct_order?(list, come_before)
    list.each_with_index do |_ , i|
      cur_page_i = i
      later_page_i = i + 1
      cur_page = list[cur_page_i]
      while later_page_i < list.size
        later_page = list[later_page_i]
        # if the later page is supposed to be before the current page,
        # move the later page before the current page
        if come_before[later_page]&.include?(cur_page)
          list.delete_at(later_page_i)
          list.insert(cur_page_i, later_page)
        end
        # then keep going through the list
        later_page_i += 1
      end
    end
  end
  list
end

# ===============================================

main
