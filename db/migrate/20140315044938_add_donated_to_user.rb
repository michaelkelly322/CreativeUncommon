class AddDonatedToUser < ActiveRecord::Migration
  def change
    add_column :users, :donated, :decimal
  end
end
