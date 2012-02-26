class CreateUserLocations < ActiveRecord::Migration
  def change
    create_table :user_locations do |t|
      t.integer :user_id, :null => true, :default => nil
      t.string :ip_address, :null => true, :default => nil
      t.float :latitude, :null => true, :default => nil
      t.float :longitude, :null => true, :default => nil

      t.timestamps
    end
  end
end
