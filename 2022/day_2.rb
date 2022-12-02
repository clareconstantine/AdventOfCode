
def win_points game
  score = 0
  if ["A X", "B Y", "C Z"].include? game
    score = 3
  elsif ["A Z", "B X", "C Y"].include? game
    score = 0
  else
    score = 6
  end

  score
end

def symbol_points game
  score = 0
  if game[2] == "X"
    score = 1
  elsif game[2] == "Y"
    score = 2
  else
    score = 3
  end

  score
end

def main
  games = File.open("day_2_input.txt").readlines.map(&:chomp)
  total_score = 0
  games.each do |game|
    total_score += win_points(game) + symbol_points(game)
  end
  p total_score
end

main
