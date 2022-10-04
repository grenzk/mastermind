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

  attr_reader :slots, :smaller_slots

  def initialize
    @slots = ['', '', '', '']
    @smaller_slots = ['', '', '', '']
  end

  def slot_occupied?(idx)
    slots[idx].empty?
  end

  def slots_full?
    slots.all? { |color| COLORS.include?(color) }
  end

  def valid_place?(idx)
    idx.between?(0, 3) && slot_occupied?(idx)
  end

  def valid_pick?(user_input)
    'roygbiv'.match?(user_input) && slots.none?(CHOICES[user_input])
  end

  def pick_color
    puts 'Pick your color. [roygbiv]'
    user_input = gets.chomp.downcase

    valid_pick?(user_input) ? CHOICES[user_input] : pick_color
  end

  def place_color
    color = pick_color
    puts 'Place your color. [1 - 4]'

    player_input =
      begin
        Integer(gets)
      rescue StandardError
        false
      end

    if player_input
      idx = player_input - 1
      valid_place?(idx) ? slots[idx] = color : place_color
    else
      place_color
    end
    display_row
  end

  def display_row
    puts "| #{slots[0]} | #{slots[1]} | #{slots[2]} | #{slots[3]} |"
    puts '-------------'
    puts "| #{smaller_slots[0]} | #{smaller_slots[1]} | #{smaller_slots[2]} | #{smaller_slots[3]} |"
  end

  def play
    place_color until slots_full?
  end
end

game = Mastermind.new
game.place_color
