class AddApprovedToWork < ActiveRecord::Migration
  def change
    add_column :works, :approved, :boolean, default: false
    add_index :works, :approved
  end
end
