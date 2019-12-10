class Booking < ApplicationRecord
  has_one :room, foreign_key: :room_id

  # These are validations for a new booking. As the database specifies that no fields must be left as null, checks are made
  # to ensure that all attributes are present.
  validates :date, presence: true
  validates :time, presence: true
  validates :room_id, presence: true
  validates :duration, presence: true
  validates :user_id, presence: true
  validate :no_time_overlap, :is_date_in_past

  #This method checks to ensure that the user cannot book a studio session at the same time, and in the same room, as a previously booked session.
  #A collection is made of bookings, where the date is the same to the date of the new booking. This collection is looped through. And if for any
  #session that the times are the same, and the room is the same, then an error is thrown and the booking will not save.

  def no_time_overlap
    @other_bookings = Booking.where(:date => date)
    @other_bookings.each do |other_booking|
      if other_booking.time.strftime("%I:%M%p") == time.strftime("%I:%M%p") && other_booking.room_id == room_id
        errors.add(:time, "Cannot book, overlapping sessions!")
      end
    end
  end

  def valid_booking_time
    if duration != 30 || duration != 60
      errors.add(:duration, " must be either 30 or 60 minutes")
    end
  end

  # This method ensures that a user cannot book a session for a date in the past, as that date will have gone
  # so the booking will be wasted
  def is_date_in_past
    if date.nil?
      errors.add(:date, "cannot be null")
    else
      if date.past?
        errors.add(:date, "cannot be in the past")
      end
    end

  end
end

