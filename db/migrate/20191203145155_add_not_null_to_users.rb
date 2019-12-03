class AddNotNullToUsers < ActiveRecord::Migration[5.2]
  def change
    change_column_null :users, :is_admin, false
  end
end
