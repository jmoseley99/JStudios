class AddNotNullToBookings < ActiveRecord::Migration[5.2]
  def change
    change_column_null :bookings, :time, false
    change_column_null :bookings, :user_id, false
    change_column_null :bookings, :room_id, false
    change_column_null :bookings, :duration, false
  end
end
