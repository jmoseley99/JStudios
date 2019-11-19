class Booking < ApplicationRecord
  has_one :room, foreign_key: :room_id

  validates :date, presence: true
  validates :time, presence: true
  validates :room_id, presence: true
  #validate :date_not_in_past
  validate :no_time_overlap

  def no_time_overlap
    @other_bookings = Booking.where(:date => date)
    @other_bookings.each do |other_booking|
      if other_booking.time.strftime("%I:%M%p") == time.strftime("%I:%M%p") && other_booking.room_id == room_id
        errors.add(:time, "Cannot book, overlapping sessions!")
      end
    end
  end
  ##def date_not_in_past
    #if date < Date.today
     # errors.add(:date, "cannot be in the past!")
    #end
  #end
end

