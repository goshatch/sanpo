class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :label
      t.float :latitude
      t.float :longitude
      t.integer :step_num
      t.integer :walk_id
      t.timestamps
    end
  end
end
