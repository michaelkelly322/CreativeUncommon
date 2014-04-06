class CreateDonations < ActiveRecord::Migration
  def change
    create_table :donations do |t|
      t.decimal :amount
      t.boolean :site_donation
      t.boolean :approved

      t.timestamps
    end
  end
end
