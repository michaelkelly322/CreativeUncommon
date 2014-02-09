class AddSessionKeyToUsers < ActiveRecord::Migration
  def change
    add_column :users, :session_key, :string
    add_index :users, :session_key
  end
end
