class Booking < ApplicationRecord
  has_one :room, foreign_key: :room_id

  validates :date, presence: true
  #validate :date_not_in_past


  ##def date_not_in_past
    #if date < Date.today
     # errors.add(:date, "cannot be in the past!")
    #end
  #end
end

