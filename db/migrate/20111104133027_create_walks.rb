class CreateWalks < ActiveRecord::Migration
  def change
    create_table :walks do |t|
      t.string :title
      t.text :description
      t.text :notes
      t.string :link
      t.integer :user_id

      t.timestamps
    end
  end
end
