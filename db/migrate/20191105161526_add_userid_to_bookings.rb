class AddUseridToBookings < ActiveRecord::Migration[5.2]
  def change
    add_column :bookings, :userid, :integer
  end
end
