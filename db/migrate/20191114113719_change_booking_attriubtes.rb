class ChangeBookingAttriubtes < ActiveRecord::Migration[5.2]
  def self.up
    rename_column :bookings, :User_ID, :user_id
    remove_column :bookings, :userid
    rename_column :bookings, :Date, :date
    rename_column :bookings, :Time, :time
  end
end
