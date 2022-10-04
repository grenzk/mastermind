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

    if color_input_valid?(user_input) && color_not_picked?(user_input)
      return CHOICES[user_input]
    elsif color_input_valid?(user_input) && !color_not_picked?(user_input)
      puts "\nYou already picked the color."
    else
      puts "\nInvalid input. Try again."
    end

    pick_color
  end

  def place_color
    color = pick_color
    puts 'Place your color. [1 - 4]'

    while (user_input = gets.chomp.to_i)
      case user_input
      when 0
        puts "\nInvalid input. Try again.\nPlace your color. [1 - 4]"
      else
        idx = user_input - 1

        if position_valid?(idx)
          slots[idx] = color
          break
        else
          puts "\nThe position is already taken.\nPlace your color. [1 - 4]"
        end
      end
    end
    display_row
  end

  def display_row
    puts "| #{slots[0]} | #{slots[1]} | #{slots[2]} | #{slots[3]} |"
  end

  def play
    place_color until slots_full?

    if secret_code.eql?(slots)
      puts 'You win!'
    else
      guesses = secret_code.intersection(slots)
      unless guesses.empty?
        guesses.each { |color| smaller_slots << correct_position?(color) }
      end
    end
  end
end

game = Mastermind.new
game.play
