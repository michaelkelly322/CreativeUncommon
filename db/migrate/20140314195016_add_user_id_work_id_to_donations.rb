class AddUserIdWorkIdToDonations < ActiveRecord::Migration
  def change
    add_column :donations, :user_id, :integer
    add_column :donations, :work_id, :integer
    add_index :donations, [:user_id, :work_id]
  end
end
