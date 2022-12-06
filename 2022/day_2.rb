def symbol_points their_move, result
  symbols = {
    A: 1, # "rock",
    B: 2, # "paper",
    C: 3, # "scissors",
  }

  result_transformations = {
    X: -1,
    Y: 0,
    Z: 1
  }

  points = (symbols[their_move] + result_transformations[result])
  points += 3 if points < 1
  points -= 3 if points > 3
  points
end

def result_points result
  results = {
    X: 0, # "loss",
    Y: 3, # "draw",
    Z: 6, # "win"
  }

  results[result]
end

def score game
  result = game[2].to_sym
  their_move = game[0].to_sym

  result_points(result) + symbol_points(their_move, result)
end

def main
  games = File.open("input/day_2.txt").readlines.map(&:chomp)
  # games = ["A Y", "B X", "C Z"]
  total_score = 0
  games.each do |game|
    total_score += score(game) unless game == ""
  end
  p total_score
end

main
# p score("A X")
# p score("B Z")
# p score("C Y")

