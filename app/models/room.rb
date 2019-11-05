class Room < ApplicationRecord
  @number_of_rooms = 4
  has_many :bookings
  @room_one_price = 15
  @room_two_price = 20
  @room_three_price = 45


end
