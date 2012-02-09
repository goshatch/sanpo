class AddPublishedFlagToWalk < ActiveRecord::Migration
  def change
    add_column :walks, :published, :boolean, :null => false, :default => false
    add_column :walks, :published_at, :datetime, :null => true
  end
end
