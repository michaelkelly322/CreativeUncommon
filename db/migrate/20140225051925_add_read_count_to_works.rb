class AddReadCountToWorks < ActiveRecord::Migration
  def change
    add_column :works, :read_count, :integer
    add_index :works, :read_count
  end
end
