class LimitWalkTitleTo70Char < ActiveRecord::Migration
  def up
    change_column(:walks, :title, :string, {:limit => 70, :null => false})
  end

  def down
    change_column(:walks, :title, :string, {:null => true})
  end
end
