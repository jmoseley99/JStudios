class CreateRooms < ActiveRecord::Migration[5.2]
  def change
    create_table :rooms do |t|
      t.integer :RoomID
      t.text :Description

      t.timestamps
    end
  end
end
