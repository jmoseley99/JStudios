class ChangeAttriubtesInBookings < ActiveRecord::Migration[5.2]
  def self.up
    rename_column :bookings, :RoomNo, :room_id
    rename_column :rooms, :Description, :description
    rename_column :rooms, :RoomID, :room_id
  end
end
