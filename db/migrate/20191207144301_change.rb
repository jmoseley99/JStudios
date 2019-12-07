class Change < ActiveRecord::Migration[5.2]
  def change
    change_column :bookings, :user_id, :integer, :null => true
  end
end
