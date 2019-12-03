class AddNotNullToRooms < ActiveRecord::Migration[5.2]
  def change
    change_column_null :rooms, :room_id, false
    change_column_null :rooms, :description, false
    change_column_null :rooms, :price, false
  end
end
