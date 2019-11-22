class AddUserIdToBookings < ActiveRecord::Migration[5.2]
  def change
    add_column :bookings, :User_ID, :integer
  end
end
