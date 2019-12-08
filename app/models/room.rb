class Room < ApplicationRecord
  validates :room_id, :description, :price, presence: true
  validate :price_over_zero, :empty_description

  def price_over_zero
    if price < 0
      errors.add(:price, "Price cannot be below zero!")
    end
  end

  def empty_description
    if description == ""
      errors.add(:description, "Must include description")
    end
  end
end
