class AddDefaultValueToDonatedUser < ActiveRecord::Migration
  def change
    change_column :users, :donated, :decimal, default: 0.0
  end
end
