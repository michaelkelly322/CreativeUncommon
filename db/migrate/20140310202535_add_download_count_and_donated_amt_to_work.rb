class AddDownloadCountAndDonatedAmtToWork < ActiveRecord::Migration
  def change
    add_column :works, :downloaded, :integer
  end
end
