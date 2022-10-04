# frozen_string_literal: true

# Mastermind Game
class Mastermind
  CHOICES = {
    'r' => 'red',
    'o' => 'orange',
    'y' => 'yellow',
    'g' => 'green',
    'b' => 'blue',
    'i' => 'indigo',
    'v' => 'violet'
  }.freeze
  FEEDBACK = { false => 'white', true => 'black' }.freeze
  COLORS = CHOICES.values

  attr_reader :secret_code, :slots, :smaller_slots

  def initialize
    @secret_code = COLORS.sample(4)
    @slots = ['', '', '', '']
    @smaller_slots = []
  end

  def slot_occupied?(idx)
    slots[idx].empty?
  end

  def slots_full?
    slots.all? { |color| COLORS.include?(color) }
  end

  def won?
    secret_code.eql?(slots)
  end

  def position_valid?(idx)
    idx.between?(0, 3) && slot_occupied?(idx)
  end

  def correct_position?(color)
    secret_code.index(color) == slots.index(color)
  end

  def color_not_picked?(user_input)
    slots.none?(CHOICES[user_input])
  end

  def color_input_valid?(user_input)
    'roygbiv'.match?(user_input)
  end

  def pick_color
    puts 'Pick your color. [roygbiv]'
    user_input = gets.chomp.downcase

    cond_one = color_input_valid?(user_input) && color_not_picked?(user_input)
    cond_two = color_input_valid?(user_input) && !color_not_picked?(user_input)

    return CHOICES[user_input] if cond_one

    puts "\nYou already picked the color." if cond_two
    puts "\nInvalid input. Try again." unless cond_two

    pick_color
  end

  def place_color(count)
    color = pick_color

    handle_color_placement(color)

    system 'clear'
    display_attempts(count)
    display_row
  end

  def handle_color_placement(color)
    loop do
      user_input = integer_as_input
      idx = user_input - 1

      if position_valid?(idx)
        slots[idx] = color
        break
      end

      puts "\nThe position is already taken."
    end
  end

  def integer_as_input
    puts 'Place your color. [1 - 4]'
    Integer(gets.chomp)
  rescue StandardError
    puts "\nPlease enter a valid number."
    retry
  end

  def display_feedback
    feedback = smaller_slots.map { |key| FEEDBACK[key] }
    puts "feedback: | #{feedback[0]} | #{feedback[1]} | #{feedback[2]} | #{feedback[3]} |\n "
  end

  def display_row
    puts "\nslots: | #{slots[0]} | #{slots[1]} | #{slots[2]} | #{slots[3]} |\n "
  end

  def display_attempts(count)
    puts "No. of attempts: #{count}"
  end

  def display_title
    puts "\nGUESS THE SECRET CODE.\ncolors: ROYGBIV"
    display_row
  end

  def play
    10.downto(0) do |count|
      place_color(count) until slots_full?

      break if won?

      guesses = secret_code.intersection(slots)
      guesses.each { |color| smaller_slots << correct_position?(color) }

      display_feedback

      slots.map! { '' }

      smaller_slots.clear
    end
  end

  def start
    display_title

    play

    puts 'You lose! The mastermind wins.' unless won?
    puts "Well done codebreaker! Here's a cookie!"
  end
end

game = Mastermind.new
game.play
