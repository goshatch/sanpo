class CreateProfiles < ActiveRecord::Migration
  def change
    create_table :profiles do |t|
      t.integer :user_id, :null => false
      t.string :real_name
      t.text :bio
      t.string :twitter
      t.string :website

      t.timestamps
    end
  end
end
