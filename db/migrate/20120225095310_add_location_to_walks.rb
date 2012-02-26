class AddLocationToWalks < ActiveRecord::Migration
  def change
    add_column :walks, :latitude, :decimal, :precision => 20, :scale => 16
    add_column :walks, :longitude, :decimal, :precision => 20, :scale => 16
    add_column :walks, :location, :string
  end
end
