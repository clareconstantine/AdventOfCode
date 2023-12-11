PATH_SNIPPET = "day_4"

def main
  # input = File.open("./input/test_input.txt").readlines.map(&:chomp)
  input = File.open("./input/#{PATH_SNIPPET}.txt").readlines.map(&:chomp)

  puts part_1(input)
  puts part_2(input)
end

# Parts =========================================

def part_1 cards
  total_points = 0
  cards.each do |card|
    card_info = parse_card(card)
    total_points += calculate_points(card_info[:winning_numbers], card_info[:your_numbers])
  end
  total_points
end

def part_2 original_cards
  card_dir = create_card_dir(original_cards)
  card_queue = []
  total_cards = 0

  card_dir.values.each do |card|
    card_queue.push(card)
  end

  while !card_queue.empty?
    total_cards += 1
    card = card_queue.shift

    num_matches = calculate_matches(card[:winning_numbers], card[:your_numbers])

    num_matches.times do |i|
      card_queue.push(card_dir["#{card[:card_number] + i + 1}"])
    end
  end

  total_cards
end

# Helpers =======================================

def parse_card(card)
  card_number = card[5, 3].strip.to_i
  winning_numbers = card[10, 29].split(' ').map(&:to_i)
  your_numbers = card[42, card.length - 1 - 32].split(' ').map(&:to_i)

  {
    card_number: card_number,
    winning_numbers: winning_numbers,
    your_numbers: your_numbers
  }
end

def calculate_points(winning_numbers, your_numbers)
  num_matches = calculate_matches(winning_numbers, your_numbers)

  return 0 if num_matches == 0

  2 ** (num_matches - 1)
end

def calculate_matches(winning_numbers, your_numbers)
  num_matches = 0
  your_numbers.each do |num|
    winning_numbers.each do |winner|
      if num == winner
        num_matches += 1
      end
    end
  end

  num_matches
end

def create_card_dir(cards)
  dir = {}
  cards.each do |card|
    card_info = parse_card(card)
    dir["#{card_info[:card_number]}"] = card_info
  end
  dir
end

# ===============================================

main
