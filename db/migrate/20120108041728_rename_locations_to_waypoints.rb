class RenameLocationsToWaypoints < ActiveRecord::Migration
  def up
    rename_table :locations, :waypoints
  end

  def down
    rename_table :waypoints, :locations
  end
end
