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

  def valid_pick?(user_input)
    'roygbiv'.match?(user_input) && slots.none?(CHOICES[user_input])
  end

  def pick_color
    puts 'Pick your color. [roygbiv]'
    user_input = gets.chomp.downcase

    valid_pick?(user_input) ? CHOICES[user_input] : pick_color
  end

  def display_row
    puts "| #{slots[0]} | #{slots[1]} | #{slots[2]} | #{slots[3]} |"
    puts '-------------'
    puts "| #{smaller_slots[0]} | #{smaller_slots[1]} | #{smaller_slots[2]} | #{smaller_slots[3]} |"
  end
end

game = Mastermind.new
game.pick_color
