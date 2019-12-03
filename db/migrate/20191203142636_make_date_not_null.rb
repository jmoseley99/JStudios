class MakeDateNotNull < ActiveRecord::Migration[5.2]
  def change
    change_column_null :bookings, :date, false
  end
end
