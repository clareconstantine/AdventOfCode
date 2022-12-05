def part_1 strings
  nice_count = 0

  strings.each do |string|
    vowels = []
    contains_naughty_pairs = false
    contains_double_letters = false
    double_letters = ""
    string.chars.each_with_index do |cur_char, i|
      next_char = i < string.length ? string[i+1] : nil

      if ['ab', 'cd', 'pq', 'xy'].include?("#{cur_char}#{next_char}")
        # p "naughty pair: #{cur_char}#{next_char}"
        contains_naughty_pairs = true
      end

      if next_char == cur_char
        # p "double letters: #{cur_char}#{next_char}"
        contains_double_letters = true
        double_letters = "#{cur_char}#{next_char}"
      end

      if "aeiou".include? cur_char
        vowels << cur_char
      end
    end
    if !contains_naughty_pairs && contains_double_letters && vowels.length >= 3
      nice_count += 1
      p string
      p "NICE: double letters: #{double_letters} vowels: #{vowels}"
    else
      # p "NAUGHTY: #{contains_naughty_pairs ? "naughty pair. " : ""} #{!contains_double_letters ? "no double letters. " : ""} #{vowels.length < 3 ? "not enough vowels." : ""}"
    end
  end
  p nice_count
end

def part_2 strings
  nice_count = 0

  strings.each do |string|
    has_char_sandwich = false
    sandwich = ""
    has_repeated_pairs = false
    pair = ""
    string.chars.each_with_index do |cur_char, i|
      next_char = i < string.length ? string[i+1] : nil
      next_next_char = i < string.length - 1 ? string[i+2] : nil

      if cur_char == next_next_char
        has_char_sandwich = true
        sandwich = "#{cur_char}#{next_char}#{next_next_char}"
      end

      if next_next_char && string[i + 2, string.length - i - 2].include?("#{cur_char}#{next_char}")
        has_repeated_pairs = true
        pair = "#{cur_char}#{next_char}"
      end
    end
    if has_char_sandwich && has_repeated_pairs
      nice_count += 1
      p string
      p "NICE: sandwich: #{sandwich} repeated pair: #{pair}"
    end

  end
  p nice_count
end

def main
  strings = File.open("day_5_input.txt").readlines.map(&:chomp)
  # strings = ["ugknbfddgicrmopn", "aaa", "jchzalrnumimnmhp", "haegwjzuvuyypxyu", "dvszwmarrgswjxmb"]
  # part_1(strings)
  part_2(strings)
end


main
