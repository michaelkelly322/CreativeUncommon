class AddGenreToWorks < ActiveRecord::Migration
  def change
    add_column :works, :genre, :string
  end
end
