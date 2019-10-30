class CreateBookings < ActiveRecord::Migration[5.2]
  def change
    create_table :bookings do |t|
      t.date :Date
      t.time :Time
      t.integer :RoomNo

      t.timestamps
    end
  end
end
