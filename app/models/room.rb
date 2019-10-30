class Room < ApplicationRecord
  @numberOfRooms = 4
  has_many :bookings


end
