# frozen_string_literal: true

module Constants
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
end
