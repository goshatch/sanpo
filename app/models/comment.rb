class Comment < ActiveRecord::Base
  belongs_to :user
  belongs_to :walk

  def self.send_notification(id)
    find(id).send_notification
  end

  def send_notification
    Notifications.new_comment_on_walk(self).deliver
  end
end
