PATH_SNIPPET = "day_2"
def main
  # reports = File.open("./input/test_input.txt").readlines.map {|line| line.chomp.split.map(&:to_i)}
  reports = File.open("./input/#{PATH_SNIPPET}.txt").readlines.map {|line| line.chomp.split.map(&:to_i)}

  puts part_1(reports)
  puts part_2(reports)
end

# Constants =====================================

MAX_SAFE_DELTA = 3

# Parts =========================================

def part_1 reports
  # puts reports.inspect
  total_safe_reports = 0
  reports.each do |report|
    if is_safe? report
      total_safe_reports += 1
      # puts "safe: #{report}"
    else
      # puts "not safe: #{report}"
    end
  end
  total_safe_reports
end

def part_2 reports
  # puts reports.inspect
  total_safe_reports = 0
  reports.each do |report|
    if is_safe? report
      total_safe_reports += 1
      # puts "safe: #{report}"
    else
      report.each_with_index do |level, i|
        # try removing each level and see if it is safe
        temp = report.reject.with_index{|_, j| j == i }
        if is_safe? temp
          total_safe_reports += 1
          break
        end
      end
      # puts "not safe: #{report}"
    end
  end
  total_safe_reports
end

# Helpers =======================================

def is_safe? report
  expect_increase = report[0] < report[1]

  report.each_with_index do |current_level, i|
    # skip once we get to the last element bc we've been looking ahead one and we are done
    if i < report.length - 1
      next_level = report[i + 1]
      # does it fail to continually increase or decrease?
      if (expect_increase && next_level <= current_level) || (!expect_increase && next_level >= current_level)
        # puts "increase/decrease, #{i}"
        return false
      end
      # does the delta fall outside the acceptable range?
      if (current_level - next_level).abs > MAX_SAFE_DELTA
        # puts "delta, #{i}"
        return false
      end
    end
  end
  true
end

# ===============================================

main
