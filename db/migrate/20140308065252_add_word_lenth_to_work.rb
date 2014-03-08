class AddWordLenthToWork < ActiveRecord::Migration
  def change
    add_column :works, :word_count, :integer
  end
end
