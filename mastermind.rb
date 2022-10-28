# frozen_string_literal: true

require_relative 'mastermind/constants'
require_relative 'mastermind/helpers'
require_relative 'mastermind/outputs'

# Mastermind Game
class Mastermind
  include Constants
  include Helpers
  include Outputs

  attr_reader :secret_code, :slots, :smaller_slots, :guesses_with_feedback

  def initialize
    @secret_code = COLORS.sample(4)
    @slots = ['', '', '', '']
    @smaller_slots = []
    @guesses_with_feedback = []
  end

  def pick_color
    puts 'Pick your color. [roygbiv]'
    user_input = gets.chomp.downcase

    exit if user_input == 'q'

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
    display_history
    display_row
  end

  def handle_color_placement(color)
    loop do
      user_input = integer_as_input

      exit if user_input == 5

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

  def play
    10.downto(0) do |count|
      place_color(count) until slots_full?

      break if won?

      guesses = secret_code.intersection(slots)
      guesses.each { |color| smaller_slots << correct_position?(color) }

      display_feedback

      add_move_to_history

      clear_slots
    end
  end

  def add_move_to_history
    guesses_with_feedback << "#{first_chr(slots)} || #{first_chr(smaller_slots)}"
  end

  def start
    display_title

    play

    display_secret_code

    puts "Well done codebreaker! Here's a cookie!" if won?
    puts 'You lose! The mastermind wins.' unless won?

    restart_game
  end

  def restart_game
    loop do
      puts 'Play again?'
      user_input = gets.chomp.downcase

      if user_input == 'y'
        reset
        start
      end

      break if user_input == 'n'

      puts 'Invalid input. Try again.'
    end
  end
end

game = Mastermind.new
game.start
