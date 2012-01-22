class AddMailNotificationsToUser < ActiveRecord::Migration
  def change
    add_column :users, :mail_comment_notification, :boolean, :default => true
    add_column :users, :mail_follow_notification, :boolean, :default => true
    add_column :users, :mail_local_walk_notification, :boolean, :default => true
    add_column :users, :mail_weekly_digest, :boolean, :default => true
  end
end
