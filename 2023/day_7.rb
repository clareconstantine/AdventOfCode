PATH_SNIPPET = "day_7"
class ClassName
  HAND_TYPES = {
    five_of_a_kind: 7,
    four_of_a_kind: 6,
    full_house: 5,
    three_of_a_kind: 4,
    two_pair: 3,
    one_pair: 2,
    high_card: 1
  }

  CARD_VALUES_1 = {
    "2" => 1,
    "3" => 2,
    "4" => 3,
    "5" => 4,
    "6" => 5,
    "7" => 6,
    "8" => 7,
    "9" => 8,
    "T" => 9,
    "J" => 10,
    "Q" => 11,
    "K" => 12,
    "A" => 13
  }

  CARD_VALUES_2 = {
    "J" => 0,
    "2" => 1,
    "3" => 2,
    "4" => 3,
    "5" => 4,
    "6" => 5,
    "7" => 6,
    "8" => 7,
    "9" => 8,
    "T" => 9,
    "Q" => 10,
    "K" => 11,
    "A" => 12
  }

  def initialize
    # input = File.open("./input/test_input.txt").readlines.map(&:chomp)
    input = File.open("./input/#{PATH_SNIPPET}.txt").readlines.map(&:chomp)

    # create class variables here
    @players = setup_players(input)

    puts part_1
    puts part_2
  end

  # Parts =========================================

  def part_1
    @part = 1
    score_hands
    rank_hands
    total_winnings
  end

  def part_2
    @part = 2
    score_hands
    rank_hands
    total_winnings
  end

  # Helpers =======================================

  def setup_players(input)
    players = []
    input.each do |line|
      line = line.split(' ')
      players.push({
        hand: line[0],
        bid: line[1]
      })
    end
    players
  end

  def hand_value_1(hand)
    score = []
    score.append(HAND_TYPES[hand_type_1(hand)])
    hand.chars.each do |card|
      score << CARD_VALUES_1[card]
    end
    score
  end

  def hand_type_1(hand)
    card_counts = {}
    hand.chars.each do |card|
      if card_counts[card]
        card_counts[card] += 1
      else
        card_counts[card] = 1
      end
    end

    num_unique_cards = card_counts.keys.length
    card_totals = card_counts.values.sort
    if num_unique_cards == 1
      return :five_of_a_kind
    elsif card_totals == [1, 4]
      return :four_of_a_kind
    elsif card_totals == [2, 3]
      return :full_house
    elsif card_totals == [1, 1, 3]
      return :three_of_a_kind
    elsif card_totals == [1, 2, 2]
      return :two_pair
    elsif num_unique_cards == 4
      return :one_pair
    elsif num_unique_cards == 5
      return :high_card
    end
  end

  def hand_value_2(hand)
    score = []
    score.append(HAND_TYPES[hand_type_2(hand)])
    hand.chars.each do |card|
      score << CARD_VALUES_2[card]
    end
    score
  end

  def hand_type_2(hand)
    card_counts = {}
    hand.chars.each do |card|
      if card_counts[card]
        card_counts[card] += 1
      else
        card_counts[card] = 1
      end
    end

    num_jokers = card_counts["J"] || 0
    num_unique_cards = card_counts.keys.length
    card_totals = card_counts.values.sort
    if num_unique_cards == 1 || (num_unique_cards == 2 && num_jokers > 0)
      return :five_of_a_kind
    elsif card_totals == [1, 4] || (card_totals == [1, 1, 3] && (num_jokers == 1 || num_jokers == 3)) || (card_totals == [1, 2, 2] && num_jokers == 2)
      return :four_of_a_kind
    elsif card_totals == [2, 3] || (card_totals == [1, 2, 2] && num_jokers == 1)
      return :full_house
    elsif card_totals == [1, 1, 3] || (card_totals == [1, 1, 1, 2] && (num_jokers == 1 || num_jokers == 2))
      return :three_of_a_kind
    elsif card_totals == [1, 2, 2]
      return :two_pair
    elsif num_unique_cards == 4 || (num_unique_cards == 5 && num_jokers == 1)
      return :one_pair
    elsif num_unique_cards == 5
      return :high_card
    end
  end


  def score_hands
    @players.each_with_index do |player, i|
      if @part == 1
        @players[i][:score] = hand_value_1(player[:hand])
      else
        @players[i][:score] = hand_value_2(player[:hand])
      end
    end
  end

  # sort @players in order by player[:score]
  def rank_hands
    @players = @players.sort_by do |player|
      score = player[:score]
      [score[0], score[1], score[2], score[3], score[4], score[5]]
    end
  end

  def total_winnings
    total = 0
    @players.each_with_index do |player, i|
      total += player[:bid].to_i * (i + 1)
    end
    total
  end
end

ClassName.new
