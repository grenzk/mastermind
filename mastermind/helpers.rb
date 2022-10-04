module Helpers
  def color_input_valid?(user_input)
    'roygbiv'.match?(user_input)
  end

  def color_not_picked?(user_input)
    slots.none?(Constants::CHOICES[user_input])
  end

  def slot_occupied?(idx)
    slots[idx].empty?
  end

  def position_valid?(idx)
    idx.between?(0, 3) && slot_occupied?(idx)
  end

  def slots_full?
    slots.all? { |color| Constants::COLORS.include?(color) }
  end

  def correct_position?(color)
    secret_code.index(color) == slots.index(color)
  end

  def won?
    secret_code.eql?(slots)
  end
end
