class ChangeWaypointsFloatPrecision < ActiveRecord::Migration
  def up
    change_column :waypoints, :latitude, :decimal, :precision => 20, :scale => 16
    change_column :waypoints, :longitude, :decimal, :precision => 20, :scale => 16
  end

  def down
    raise ActiveRecord::IrreversibleMigration
  end
end
