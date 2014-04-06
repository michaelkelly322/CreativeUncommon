class AddPdfBinaryToWork < ActiveRecord::Migration
  def change
    add_column :works, :pdf, :binary
  end
end
