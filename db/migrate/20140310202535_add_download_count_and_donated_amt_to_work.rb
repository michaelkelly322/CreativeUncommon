class AddDownloadCountAndDonatedAmtToWork < ActiveRecord::Migration
  def change
    add_column :works, :downloaded, :integer
    add_column :works, :donated, :decimal
  end
end
