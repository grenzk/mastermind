# frozen_string_literal: true

# For displaying data
module Outputs
  def display_title
    puts "\nGUESS THE SECRET CODE.\ncolors: ROYGBIV"
    display_row
  end

  def display_attempts(count)
    puts "No. of attempts: #{count}"
  end

  def display_row
    puts "\nslots: | #{slots[0]} | #{slots[1]} | #{slots[2]} | #{slots[3]} |\n "
  end

  def display_feedback
    feedback = smaller_slots.map { |key| Constants::FEEDBACK[key] }
    puts "feedback: | #{feedback[0]} | #{feedback[1]} | #{feedback[2]} | #{feedback[3]} |\n "
  end
end
