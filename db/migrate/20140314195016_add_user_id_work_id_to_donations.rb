class AddUserIdWorkIdToDonations < ActiveRecord::Migration
  def change
    add_column :donations, :user_id, :integer
    add_column :donations, :work_id, :integer
    add_index :donations, :user_id
    add_index :donations, :work_id
  end
end
