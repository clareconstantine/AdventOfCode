PATH_SNIPPET = "day_6"

class BoatRaceCalculator
  def initialize
    # input = File.open("./input/test_input.txt").readlines.map(&:chomp)
    input = File.open("./input/#{PATH_SNIPPET}.txt").readlines.map(&:chomp)
    @time = input[0].scan(/\d+/).map(&:to_i)
    @distance = input[1].scan(/\d+/).map(&:to_i)

    @part_1_races = setup_races
    @part_2_race = {
      time: input[0].delete(' ').scan(/\d+/).map(&:to_i)[0],
      record: input[1].delete(' ').scan(/\d+/).map(&:to_i)[0]
    }
  end

  # Parts =========================================

  # need to go farther in each race (in the time limit) than the record distance
  # starting speed is 0mm/ms
  # each ms you hold the button down for, remaining time decreases by 1ms, but speed increases 1ms/s
  # calculate the number of ways you could beat the record in each race (how many button-pressing durations)
  # and multiply them together
  def part_1
    result = 1
    @part_1_races.each do |race|
      result = result * ways_to_win(race)
    end
    result
  end

  def part_2
    ways_to_win(@part_2_race)
  end

  # Helpers =======================================

  def setup_races
    races = []
    @time.length.times do |i|
      races.push({
        time: @time[i],
        record: @distance[i]
      })
    end
    races
  end

  def ways_to_win(race)
    ways_to_win = 0
    # try every possible duration of holding down the button
    race[:time].times do |ms|
      distance = distance_in_race(race, ms)
      if distance > race[:record]
        ways_to_win += 1
      end
    end
    ways_to_win
  end

  def distance_in_race(race, button_time)
    speed = button_time
    time = (race[:time] - button_time)

    speed * time
  end

end

brc = BoatRaceCalculator.new
puts brc.part_1
puts brc.part_2
