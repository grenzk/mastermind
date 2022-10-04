# frozen_string_literal: true

# Mastermind Game
class Mastermind
  COLORS = %w[red orange yellow green blue indigo violet].freeze
  FEEDBACK = %w[black white].freeze

  attr_reader :slots, :smaller_slots

  def initialize
    @slots = ['', '', '', '']
    @smaller_slots = ['', '', '', '']
  end

  def display_row
    puts "| #{slots[0]} | #{slots[1]} | #{slots[2]} | #{slots[3]} |"
    puts '-------------'
    puts "| #{smaller_slots[0]} | #{smaller_slots[1]} | #{smaller_slots[2]} | #{smaller_slots[3]} |"
  end
end

game = Mastermind.new
