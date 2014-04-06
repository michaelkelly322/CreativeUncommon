class CreateWorks < ActiveRecord::Migration
  def change
    create_table :works do |t|
      t.string :blurb
      t.string :title
      t.string :author_name
      t.text :body
      t.boolean :mature
      t.boolean :draft

      t.timestamps
    end
  end
end
