class AddLengthToWalks < ActiveRecord::Migration
  def change
    add_column :walks, :length, :integer, :default => 0
  end
end
