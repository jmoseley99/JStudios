class Room < ApplicationRecord
  validates :room_id, :description, :price, presence: true
  validate :price_over_zero, :empty_description, :illegal_room_id

  # This validation ensures that the admin cannot create a new room with the id
  # less than zero
  def illegal_room_id
    if room_id.nil?
      errors.add(:room_id, "cannot be null")
    else
      if room_id < 0
        errors.add(:room_id, " cannot be less than 0")
      end
    end
  end

  # This validation ensures that the admin cannot create a new room with the price
  # less than zero
  def price_over_zero
    if price.nil?
      errors.add(:price, "cannot be null")
    else
      if price < 0
        errors.add(:price, "Price cannot be below zero!")
      end
    end
  end

  # This validation ensures that the admin cannot create a new room with the description box
  # being left empty
  def empty_description
    if description == ""
      errors.add(:description, "Must include description")
    end
  end
end
