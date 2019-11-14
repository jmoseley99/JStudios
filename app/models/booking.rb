class Booking < ApplicationRecord
  has_one :room, foreign_key: :room_id
end
