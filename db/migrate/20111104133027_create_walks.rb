class CreateWalks < ActiveRecord::Migration
  def change
    create_table :walks do |t|
      t.string :title
      t.text :description

      t.timestamps
    end
  end
end
