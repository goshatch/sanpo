class ChangeWalkCoordinatesToFloat < ActiveRecord::Migration
  def change
    change_column :walks, :latitude, :float
    change_column :walks, :longitude, :float
  end
end
